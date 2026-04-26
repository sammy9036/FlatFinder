package com.flatfinder.controller;

import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.service.PropertyService;
import com.flatfinder.service.ImageService;
import com.flatfinder.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * PropertyController - Handles property-related operations
 * Supports searching, viewing, adding, and managing properties
 */
@Controller
@RequestMapping("/property")
public class PropertyController {
    
    @Autowired
    private PropertyService propertyService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ImageService imageService;
    
    /**
     * Display all available properties (public view) - Only approved properties
     */
    @GetMapping("/all")
    public String viewAllProperties(Model model) {
        List<Property> properties = propertyService.getApprovedProperties();
        model.addAttribute("properties", properties);
        return "seeker/all-properties";
    }
    
    /**
     * View property details
     * @param id Property ID
     * @param model Model for view
     */
    @GetMapping("/details/{id}")
    public String viewPropertyDetails(@PathVariable Long id,
                                      @RequestParam(required = false) String status,
                                      @RequestParam(required = false) String message,
                                      Model model) {
        Property property = propertyService.getPropertyById(id);
        
        if (property == null) {
            return "redirect:/property/all";
        }
        
        User owner = userService.getUserById(property.getOwnerId());
        
        // Get images for this property
        model.addAttribute("property", property);
        model.addAttribute("owner", owner);
        model.addAttribute("images", imageService.getImagesByProperty(id));
        model.addAttribute("popupStatus", status);
        model.addAttribute("popupMessage", message);
        return "seeker/property-details";
    }
    
    /**
     * Search properties by keyword - Only approved properties
     * @param keyword Search keyword
     * @param model Model for view
     */
    @GetMapping("/search")
    public String searchProperties(@RequestParam String keyword, Model model) {
        List<Property> properties = propertyService.searchProperties(keyword);
        // Filter to show only approved properties
        properties = properties.stream()
                .filter(p -> "APPROVED".equals(p.getApprovalStatus()))
                .toList();
        model.addAttribute("properties", properties);
        model.addAttribute("keyword", keyword);
        return "seeker/search-results";
    }
    
    /**
     * Search properties by location - Only approved properties
     * @param location Location name
     * @param model Model for view
     */
    @GetMapping("/location/{location}")
    public String filterByLocation(@PathVariable String location, Model model) {
        List<Property> properties = propertyService.searchByLocation(location);
        properties = properties.stream()
                .filter(p -> "APPROVED".equals(p.getApprovalStatus()))
                .toList();
        model.addAttribute("properties", properties);
        model.addAttribute("location", location);
        return "seeker/properties-by-location";
    }
    
    /**
     * Filter properties by price range - Only approved properties
     * @param minPrice Minimum price
     * @param maxPrice Maximum price
     * @param model Model for view
     */
    @GetMapping("/price-range")
    public String filterByPrice(@RequestParam Double minPrice,
                               @RequestParam Double maxPrice,
                               Model model) {
        List<Property> properties = propertyService.getPropertiesByPriceRange(minPrice, maxPrice);
        properties = properties.stream()
                .filter(p -> "APPROVED".equals(p.getApprovalStatus()))
                .toList();
        model.addAttribute("properties", properties);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        return "seeker/properties-by-price";
    }
}
