package com.flatfinder.controller;

import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import com.flatfinder.model.Image;
import com.flatfinder.service.InquiryService;
import com.flatfinder.service.PropertyService;
import com.flatfinder.service.ImageService;
import com.flatfinder.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

/**
 * OwnerController - Handles property management for owners
 * Allows owners to add, view, edit, and delete their properties
 */
@Controller
@RequestMapping("/owner")
public class OwnerController {
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ImageService imageService;

    @Autowired
    private InquiryService inquiryService;
    
    /**
     * Check if user is logged in and is an OWNER
     */
    private User checkOwnerSession(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != UserRole.OWNER) {
            return null;
        }
        return user;
    }
    
    /**
     * Display owner dashboard
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Get owner's properties
        List<Property> properties = propertyService.getPropertiesByOwner(user.getId());
        List<Long> propertyIds = properties.stream().map(Property::getId).toList();
        int inquiryCount = propertyIds.isEmpty() ? 0 : inquiryService.getInquiriesByOwner(propertyIds).size();
        
        model.addAttribute("properties", properties);
        model.addAttribute("propertyCount", properties.size());
        model.addAttribute("inquiryCount", inquiryCount);
        return "owner/dashboard";
    }
    
    /**
     * Display add property form
     */
    @GetMapping("/add-property")
    public String addPropertyPage(HttpSession session) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        return "owner/add-property";
    }
    
    /**
     * Handle property addition
     * Note: Images are uploaded via AJAX after property creation (see add-property.jsp)
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
                                   @RequestParam(required = false) String imageUrl,
                                   @RequestParam(required = false) MultipartFile[] imageFiles,
                                   HttpSession session,
                                   Model model) {
        
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        try {
            // Create property - Status defaults to PENDING
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
            property.setImageUrl(imageUrl);
            property.setOwnerId(user.getId());
            property.setApprovalStatus("PENDING");
            property.setAvailable(true);
            
            // Save property
            Property savedProperty = propertyService.addProperty(property);
            
            if (savedProperty == null) {
                model.addAttribute("error", "Failed to add property. Please check your input.");
                return "owner/add-property";
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
            
            model.addAttribute("success", "Property added successfully! Awaiting admin approval.");
            return "redirect:/owner/dashboard";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to add property: " + e.getMessage());
            return "owner/add-property";
        }
    }
    
    /**
     * Display edit property form
     */
    @GetMapping("/edit-property/{id}")
    public String editPropertyPage(@PathVariable Long id,
                                   HttpSession session,
                                   Model model) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        // Check if property belongs to this owner
        if (property == null || !property.getOwnerId().equals(user.getId())) {
            return "redirect:/owner/dashboard";
        }
        
        // Get images for this property
        List<Image> images = imageService.getImagesByProperty(id);
        
        model.addAttribute("property", property);
        model.addAttribute("images", images);
        return "owner/edit-property";
    }
    
    /**
     * Handle property update
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
                                      @RequestParam(required = false) String imageUrl,
                                      HttpSession session,
                                      Model model) {
        
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        // Check if property belongs to this owner
        if (property == null || !property.getOwnerId().equals(user.getId())) {
            return "redirect:/owner/dashboard";
        }
        
        // Update property details
        property.setTitle(title);
        property.setDescription(description);
        property.setPrice(price);
        property.setLocation(location);
        property.setCity(city);
        property.setBedrooms(bedrooms);
        property.setBathrooms(bathrooms);
        property.setArea(area);
        property.setAmenities(amenities);
        property.setImageUrl(imageUrl);
        
        // Save updated property
        Property updatedProperty = propertyService.updateProperty(property);
        
        if (updatedProperty == null) {
            model.addAttribute("error", "Failed to update property.");
            return "owner/edit-property";
        }
        
        return "redirect:/owner/dashboard";
    }
    
    /**
     * Delete property
     */
    @GetMapping("/delete-property/{id}")
    public String deleteProperty(@PathVariable Long id, HttpSession session) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        // Check if property belongs to this owner
        if (property == null || !property.getOwnerId().equals(user.getId())) {
            return "redirect:/owner/dashboard";
        }
        
        propertyService.deleteProperty(id);
        
        return "redirect:/owner/dashboard";
    }
    
    /**
     * Toggle property availability
     */
    @GetMapping("/toggle-availability/{id}")
    public String toggleAvailability(@PathVariable Long id, HttpSession session) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Property property = propertyService.getPropertyById(id);
        
        if (property == null || !property.getOwnerId().equals(user.getId())) {
            return "redirect:/owner/dashboard";
        }
        
        if (property.isAvailable()) {
            propertyService.markAsUnavailable(id);
        } else {
            propertyService.markAsAvailable(id);
        }
        
        return "redirect:/owner/dashboard";
    }
    
    /**
     * Get images for a property (AJAX endpoint)
     */
    @GetMapping("/property/{id}/images")
    @ResponseBody
    public List<Image> getPropertyImages(@PathVariable Long id, HttpSession session) {
        User user = checkOwnerSession(session);
        if (user == null) {
            return null;
        }
        
        Property property = propertyService.getPropertyById(id);
        if (property == null || !property.getOwnerId().equals(user.getId())) {
            return null;
        }
        
        return imageService.getImagesByProperty(id);
    }
}
