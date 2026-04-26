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
import org.springframework.web.multipart.MultipartFile;
import java.time.LocalDateTime;
import java.util.List;

/**
 * AdminController - Handles admin operations
 * Allows admin to view and manage users and properties
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private InquiryService inquiryService;
    
    @Autowired
    private com.flatfinder.service.ImageService imageService;
    
    /**
     * Check if user is logged in and is an ADMIN
     */
    private User checkAdminSession(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != UserRole.ADMIN) {
            return null;
        }
        return user;
    }
    
    /**
     * Display admin dashboard
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Get statistics
        List<User> allUsers = userService.getAllUsers();
        List<Property> allProperties = propertyService.getAllProperties();
        List<Inquiry> allInquiries = inquiryService.getAllInquiries();
        
        model.addAttribute("totalUsers", allUsers.size());
        model.addAttribute("totalProperties", allProperties.size());
        model.addAttribute("totalInquiries", allInquiries.size());
        model.addAttribute("totalOwners", userService.getUsersByRole(UserRole.OWNER).size());
        model.addAttribute("totalSeekers", userService.getUsersByRole(UserRole.SEEKER).size());
        model.addAttribute("pendingProperties", propertyService.getPendingProperties().size());
        
        return "admin/dashboard";
    }
    
    /**
     * View all users
     */
    @GetMapping("/users")
    public String viewUsers(HttpSession session, Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<User> allUsers = userService.getAllUsers();
        model.addAttribute("users", allUsers);
        
        return "admin/users";
    }
    
    /**
     * Delete user
     */
    @GetMapping("/delete-user/{id}")
    public String deleteUser(@PathVariable Long id, HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        userService.deleteUser(id);
        
        return "redirect:/admin/users";
    }
    
    /**
     * View all properties
     */
    @GetMapping("/properties")
    public String viewProperties(HttpSession session, Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Property> allProperties = propertyService.getAllProperties();
        model.addAttribute("properties", allProperties);
        
        return "admin/properties";
    }
    
    /**
     * Delete property
     */
    @GetMapping("/delete-property/{id}")
    public String deleteProperty(@PathVariable Long id, HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        propertyService.deleteProperty(id);
        
        return "redirect:/admin/properties";
    }
    
    /**
     * View all inquiries
     */
    @GetMapping("/inquiries")
    public String viewInquiries(HttpSession session, Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Inquiry> allInquiries = inquiryService.getAllInquiries();
        model.addAttribute("inquiries", allInquiries);
        
        return "admin/inquiries";
    }
    
    /**
     * Delete inquiry
     */
    @GetMapping("/delete-inquiry/{id}")
    public String deleteInquiry(@PathVariable Long id, HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        inquiryService.deleteInquiry(id);
        
        return "redirect:/admin/inquiries";
    }
    
    /**
     * View pending properties for approval
     */
    @GetMapping("/pending-properties")
    public String viewPendingProperties(HttpSession session, Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Property> pendingProperties = propertyService.getPendingProperties();
        model.addAttribute("properties", pendingProperties);
        
        return "admin/pending-properties";
    }
    
    /**
     * Approve property
     */
    @GetMapping("/approve-property/{id}")
    public String approveProperty(@PathVariable Long id, HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        propertyService.approveProperty(id, user.getId());
        
        return "redirect:/admin/pending-properties";
    }

    /**
     * Reject property
     */
    @GetMapping("/reject-property/{id}")
    public String rejectProperty(@PathVariable Long id, HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }

        propertyService.rejectProperty(id, user.getId());

        return "redirect:/admin/pending-properties";
    }
    
    /**
     * Display add property form (Admin)
     */
    @GetMapping("/add-property")
    public String addPropertyPage(HttpSession session) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        return "admin/add-property";
    }
    
    /**
     * Handle property addition (Admin)
     */
    @PostMapping("/add-property")
    public String handleAddProperty(@RequestParam String title,
                                   @RequestParam String description,
                                   @RequestParam Double price,
                                   @RequestParam String location,
                                   @RequestParam(required = false) String city,
                                   @RequestParam(required = false) String bedrooms,
                                   @RequestParam(required = false) String bathrooms,
                                   @RequestParam(required = false) String area,
                                   @RequestParam(required = false) String amenities,
                                   @RequestParam(required = false) MultipartFile[] imageFiles,
                                   HttpSession session,
                                   Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        try {
            // Create property - Admin properties are auto-approved
            Property property = new Property();
            property.setTitle(title);
            property.setDescription(description);
            property.setPrice(price);
            property.setLocation(location);
            property.setCity(city);
            property.setBedrooms(bedrooms);
            property.setBathrooms(bathrooms);
            property.setArea(area);
            property.setAmenities(amenities);
            property.setOwnerId(user.getId());
            property.setApprovalStatus("APPROVED");
            property.setApprovedBy(user.getId());
            property.setApprovedAt(LocalDateTime.now());
            property.setAvailable(true);
            
            Property savedProperty = propertyService.addProperty(property);
            
            if (savedProperty == null) {
                model.addAttribute("error", "Failed to add property.");
                return "admin/add-property";
            }
            
            // Handle image uploads (max 4 images)
            if (imageFiles != null && imageFiles.length > 0) {
                int uploadCount = 0;
                for (MultipartFile file : imageFiles) {
                    if (file != null && !file.isEmpty() && uploadCount < 4) {
                        try {
                            boolean isPrimary = (uploadCount == 0);
                            imageService.uploadImage(savedProperty.getId(), file, isPrimary);
                            uploadCount++;
                        } catch (Exception e) {
                            System.err.println("Error uploading image: " + e.getMessage());
                        }
                    }
                }
            }
            
            return "redirect:/admin/properties";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to add property: " + e.getMessage());
            return "admin/add-property";
        }
    }
    
    /**
     * Display edit property form (Admin)
     */
    @GetMapping("/edit-property/{id}")
    public String editPropertyPage(@PathVariable Long id,
                                  HttpSession session,
                                  Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        if (property == null) {
            return "redirect:/admin/properties";
        }
        
        model.addAttribute("property", property);
        return "admin/edit-property";
    }
    
    /**
     * Handle property update (Admin)
     */
    @PostMapping("/update-property/{id}")
    public String handleUpdateProperty(@PathVariable Long id,
                                      @RequestParam String title,
                                      @RequestParam String description,
                                      @RequestParam Double price,
                                      @RequestParam String location,
                                      @RequestParam(required = false) String city,
                                      @RequestParam(required = false) String bedrooms,
                                      @RequestParam(required = false) String bathrooms,
                                      @RequestParam(required = false) String area,
                                      @RequestParam(required = false) String amenities,
                                      HttpSession session,
                                      Model model) {
        User user = checkAdminSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        if (property == null) {
            return "redirect:/admin/properties";
        }
        
        property.setTitle(title);
        property.setDescription(description);
        property.setPrice(price);
        property.setLocation(location);
        property.setCity(city);
        property.setBedrooms(bedrooms);
        property.setBathrooms(bathrooms);
        property.setArea(area);
        property.setAmenities(amenities);
        
        Property updatedProperty = propertyService.updateProperty(property);
        
        if (updatedProperty == null) {
            model.addAttribute("error", "Failed to update property.");
            return "admin/edit-property";
        }
        
        return "redirect:/admin/properties";
    }
}
