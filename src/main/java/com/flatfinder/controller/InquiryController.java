package com.flatfinder.controller;

import com.flatfinder.model.Inquiry;
import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import com.flatfinder.service.InquiryService;
import com.flatfinder.service.PropertyService;
import com.flatfinder.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * InquiryController - Handles inquiry/contact request operations
 * Manages inquiries for properties, sends emails to owners and seekers
 */
@Controller
@RequestMapping("/inquiry")
public class InquiryController {
    
    @Autowired
    private InquiryService inquiryService;
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private UserService userService;
    
    /**
     * Display inquiry form for a property
     * @param propertyId Property ID
     * @param session HTTP session (requires logged-in user)
     * @param model Model for view
     */
    @GetMapping("/contact/{propertyId}")
    public String contactForm(@PathVariable Long propertyId,
                             HttpSession session,
                             Model model) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(propertyId);
        if (property == null) {
            return "redirect:/property/all";
        }
        
        User owner = userService.getUserById(property.getOwnerId());
        
        model.addAttribute("property", property);
        model.addAttribute("owner", owner);
        return "seeker/inquiry-form";
    }
    
    /**
     * Submit inquiry/contact request
     * @param propertyId Property ID
     * @param message Inquiry message
     * @param session HTTP session (requires logged-in user)
     * @param model Model for view
     */
    @PostMapping("/submit")
    public String submitInquiry(@RequestParam Long propertyId,
                               @RequestParam String message,
                               HttpSession session,
                               Model model) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Create inquiry
        Inquiry inquiry = new Inquiry();
        inquiry.setUserId(user.getId());
        inquiry.setPropertyId(propertyId);
        inquiry.setMessage(message);
        
        // Save inquiry and send emails
        Inquiry savedInquiry = inquiryService.createInquiry(inquiry);
        
        if (savedInquiry == null) {
            return "redirect:/property/details/" + propertyId
                    + "?status=error&message=Failed+to+submit+inquiry.+Please+try+again";
        }

        return "redirect:/property/details/" + propertyId
                + "?status=success&message=Inquiry+submitted+successfully!+Owner+will+contact+you+soon";
    }

    /**
     * Show the dummy payment page for a seeker inquiry.
     */
    @GetMapping("/payment/{inquiryId}")
    public String paymentPage(@PathVariable Long inquiryId,
                              HttpSession session,
                              Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }

        Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
        if (inquiry == null || !user.getId().equals(inquiry.getUserId())) {
            return "redirect:/inquiry/my-inquiries";
        }

        Property property = propertyService.getPropertyById(inquiry.getPropertyId());
        if (property == null) {
            return "redirect:/inquiry/my-inquiries";
        }

        String status = inquiry.getStatus() != null ? inquiry.getStatus().trim().toUpperCase() : "PENDING";
        model.addAttribute("property", property);
        model.addAttribute("owner", userService.getUserById(property.getOwnerId()));
        model.addAttribute("inquiry", inquiry);
        model.addAttribute("paymentAmount", property.getPrice() != null ? property.getPrice() : 1000.0);
        model.addAttribute("paymentReference", "DUMMY-" + inquiryId + "-" + System.currentTimeMillis());
        model.addAttribute("paymentAllowed", "CONTACTED".equals(status));
        return "seeker/payment";
    }

    /**
     * Confirm dummy payment and mark inquiry as resolved.
     */
    @PostMapping("/payment/confirm/{inquiryId}")
    public String confirmPayment(@PathVariable Long inquiryId,
                                 HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }

        Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
        if (inquiry == null || !user.getId().equals(inquiry.getUserId())) {
            return "redirect:/inquiry/my-inquiries";
        }

        String status = inquiry.getStatus() != null ? inquiry.getStatus().trim().toUpperCase() : "PENDING";
        if (!"CONTACTED".equals(status)) {
            return "redirect:/inquiry/my-inquiries";
        }

        inquiryService.updateInquiryStatus(inquiryId, "RESOLVED");
        return "redirect:/inquiry/my-inquiries?paymentStatus=success&paymentMessage=Dummy+payment+completed+successfully";
    }
    
    /**
     * Get all inquiries by a seeker
     * @param session HTTP session (requires logged-in user)
     * @param model Model for view
     */
    @GetMapping("/my-inquiries")
    public String myInquiries(HttpSession session, Model model) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Get all inquiries by this user
        List<Inquiry> inquiries = inquiryService.getInquiriesByUser(user.getId());
        
        model.addAttribute("inquiries", inquiries);
        return "seeker/my-inquiries";
    }
    
    /**
     * Get all inquiries for properties owned by a user
     * @param session HTTP session (requires logged-in user)
     * @param model Model for view
     */
    @GetMapping("/received-inquiries")
    public String receivedInquiries(HttpSession session, Model model) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Get all properties owned by this user
        List<Property> properties = propertyService.getPropertiesByOwner(user.getId());
        
        // Extract property IDs
        List<Long> propertyIds = properties.stream().map(Property::getId).toList();
        
        // Get all inquiries for these properties
        List<Inquiry> inquiries = inquiryService.getInquiriesByOwner(propertyIds);
        
        model.addAttribute("inquiries", inquiries);
        return "owner/received-inquiries";
    }
    
    /**
     * Update inquiry status
     * @param inquiryId Inquiry ID
     * @param status New status
     * @param session HTTP session
     */
    @PostMapping("/update-status/{inquiryId}")
    public String updateInquiryStatus(@PathVariable Long inquiryId,
                                     @RequestParam String status,
                                     HttpSession session) {
        
        User user = (User) session.getAttribute("user");
        if (user == null || (user.getRole() != UserRole.OWNER && user.getRole() != UserRole.ADMIN)) {
            return "redirect:/auth/login";
        }

        Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
        if (inquiry == null) {
            return "redirect:/inquiry/received-inquiries";
        }

        if (user.getRole() == UserRole.OWNER) {
            Property property = propertyService.getPropertyById(inquiry.getPropertyId());
            if (property == null || !user.getId().equals(property.getOwnerId())) {
                return "redirect:/inquiry/received-inquiries";
            }
        }
        
        String normalizedStatus = status != null ? status.trim().toUpperCase() : "PENDING";
        if (!"PENDING".equals(normalizedStatus)
                && !"CONTACTED".equals(normalizedStatus)
                && !"RESOLVED".equals(normalizedStatus)
                && !"REJECTED".equals(normalizedStatus)) {
            normalizedStatus = "PENDING";
        }

        inquiryService.updateInquiryStatus(inquiryId, normalizedStatus);
        
        return "redirect:/inquiry/received-inquiries";
    }
}
