package com.flatfinder.controller;

import com.flatfinder.model.ContactMessage;
import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.repository.ContactMessageRepository;
import com.flatfinder.service.PropertyService;
import com.flatfinder.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

/**
 * HomeController - Handles home page and general navigation
 * Displays landing page with featured properties
 */
@Controller
public class HomeController {
    
    @Autowired
    private PropertyService propertyService;

    @Autowired
    private ContactMessageRepository contactMessageRepository;

    @Autowired
    private EmailService emailService;
    
    /**
     * Display home/landing page
     * Maps to root "/" path
     * Returns the index.jsp file with featured properties
     */
    @GetMapping("/")
    public String home(Model model) {
        try {
            // Keep home page and /property/all in sync by using approved + available properties.
            List<Property> featuredProperties = propertyService.getApprovedProperties();
            
            // Limit to 6 properties for featured section
            if (featuredProperties != null && featuredProperties.size() > 6) {
                featuredProperties = featuredProperties.subList(0, 6);
            }
            
            model.addAttribute("properties", featuredProperties);
            System.out.println("Loaded " + (featuredProperties != null ? featuredProperties.size() : 0) + " properties for home page");
        } catch (Exception e) {
            // Log error but continue - properties are optional for home page
            System.err.println("Error loading properties: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Return forward to index.jsp (pass model attributes)
        return "forward:/index.jsp";
    }
    
    /**
     * About page
     */
    @GetMapping("/about")
    public String about() {
        return "common/about";
    }
    
    /**
     * Contact page
     */
    @GetMapping("/contact")
    public String contact(@RequestParam(required = false) String status,
                          @RequestParam(required = false) String message,
                          HttpSession session,
                          Model model) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("loggedInUser", user);
        model.addAttribute("popupStatus", status);
        model.addAttribute("popupMessage", message);
        return "common/contact";
    }

    @PostMapping("/contact/submit")
    public String submitContact(@RequestParam String subject,
                                @RequestParam String message,
                                @RequestParam(required = false) String phone,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }

        if (subject == null || subject.isBlank() || message == null || message.isBlank()) {
            return "redirect:/contact?status=error&message=Please+fill+all+required+fields";
        }

        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setUserId(user.getId());
        contactMessage.setName(user.getName());
        contactMessage.setEmail(user.getEmail());
        contactMessage.setPhone((phone == null || phone.isBlank()) ? user.getPhoneNumber() : phone.trim());
        contactMessage.setSubject(subject.trim());
        contactMessage.setMessage(message.trim());
        contactMessageRepository.save(contactMessage);

        boolean supportMailSent = emailService.sendContactToSupport(
                contactMessage.getName(),
                contactMessage.getEmail(),
                contactMessage.getPhone(),
                contactMessage.getSubject(),
                contactMessage.getMessage());

        boolean userMailSent = emailService.sendContactConfirmationToUser(
                contactMessage.getEmail(),
                contactMessage.getName(),
                contactMessage.getSubject(),
                contactMessage.getMessage());

        if (supportMailSent && userMailSent) {
            return "redirect:/contact?status=success&message=Message+sent+successfully.+Confirmation+mail+has+been+sent+to+your+email";
        }

        return "redirect:/contact?status=warning&message=Message+saved+but+mail+delivery+failed.+Please+try+again+later";
    }
}
