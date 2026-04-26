package com.flatfinder.controller;

import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import com.flatfinder.service.PropertyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * SeekerController - Handles seeker/user property browsing and management
 * Allows seekers to view, search, and inquire about properties
 */
@Controller
@RequestMapping("/seeker")
public class SeekerController {
    
    @Autowired
    private PropertyService propertyService;
    
    /**
     * Check if user is logged in and is a SEEKER
     */
    private User checkSeekerSession(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != UserRole.SEEKER) {
            return null;
        }
        return user;
    }
    
    /**
     * Display seeker home page with all available properties
     */
    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        User user = checkSeekerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // Keep seeker/home consistent with public browse pages.
        List<Property> properties = propertyService.getApprovedProperties();
        model.addAttribute("properties", properties);
        model.addAttribute("user", user);
        
        return "seeker/home";
    }
    
    /**
     * Display my inquiries page
     */
    @GetMapping("/my-inquiries")
    public String myInquiries(HttpSession session) {
        User user = checkSeekerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // This is handled by InquiryController
        return "redirect:/inquiry/my-inquiries";
    }
    
    /**
     * Search properties by location
     */
    @GetMapping("/search")
    public String search(@RequestParam(required = false) String location,
                        @RequestParam(required = false) String minPrice,
                        @RequestParam(required = false) String maxPrice,
                        @RequestParam(required = false) String keyword,
                        HttpSession session,
                        Model model) {
        
        User user = checkSeekerSession(session);
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Property> properties = propertyService.getApprovedProperties();
        
        // Apply filters if provided
        if (keyword != null && !keyword.isEmpty()) {
            properties = propertyService.searchProperties(keyword);
        } else if (location != null && !location.isEmpty()) {
            properties = propertyService.searchByLocation(location);
        } else if (minPrice != null && maxPrice != null) {
            try {
                Double min = Double.parseDouble(minPrice);
                Double max = Double.parseDouble(maxPrice);
                properties = propertyService.getPropertiesByPriceRange(min, max);
            } catch (NumberFormatException e) {
                // Ignore and show all properties
            }
        }
        
        model.addAttribute("properties", properties);
        model.addAttribute("location", location);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("keyword", keyword);
        
        return "seeker/search-results";
    }
}
