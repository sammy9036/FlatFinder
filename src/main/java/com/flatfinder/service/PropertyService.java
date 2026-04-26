package com.flatfinder.service;

import com.flatfinder.model.Property;
import com.flatfinder.repository.PropertyRepository;
import com.flatfinder.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * PropertyService - Business logic for property operations
 * Handles adding, viewing, searching, and deleting properties
 */
@Service
public class PropertyService {
    
    @Autowired
    private PropertyRepository propertyRepository;
    
    @Autowired
    private ImageService imageService;
    
    /**
     * Add a new property
     * @param property Property object to add
     * @return Saved property object if successful, null if validation fails
     */
    @Transactional
    public Property addProperty(Property property) {
        // Validate inputs
        if (!ValidationUtil.isNotEmpty(property.getTitle())) {
            return null;
        }
        
        if (!ValidationUtil.isPositiveNumber(property.getPrice())) {
            return null;
        }
        
        if (!ValidationUtil.isNotEmpty(property.getLocation())) {
            return null;
        }
        
        // Save property
        return propertyRepository.save(property);
    }
    
    /**
     * Get property by ID
     * @param propertyId Property ID
     * @return Property object if found, null otherwise
     */
    public Property getPropertyById(Long propertyId) {
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        return propertyOpt.orElse(null);
    }
    
    /**
     * Get all properties by owner
     * @param ownerId Owner's user ID
     * @return List of properties owned by the user
     */
    public List<Property> getPropertiesByOwner(Long ownerId) {
        return propertyRepository.findByOwnerId(ownerId);
    }
    
    /**
     * Get all available properties
     * @return List of available properties
     */
    public List<Property> getAllAvailableProperties() {
        return propertyRepository.findApprovedAndAvailable();
    }
    
    /**
     * Search properties by location
     * @param location Location/city to search
     * @return List of properties matching the location
     */
    public List<Property> searchByLocation(String location) {
        return propertyRepository.findByLocationContainingIgnoreCase(location).stream()
                .filter(this::isApprovedAndAvailable)
                .toList();
    }
    
    /**
     * Get properties within price range
     * @param minPrice Minimum price
     * @param maxPrice Maximum price
     * @return List of properties within price range
     */
    public List<Property> getPropertiesByPriceRange(Double minPrice, Double maxPrice) {
        return propertyRepository.findByPriceRange(minPrice, maxPrice).stream()
                .filter(this::isApprovedAndAvailable)
                .toList();
    }
    
    /**
     * Search properties by keyword (searches title, location, description)
     * @param keyword Search keyword
     * @return List of properties matching the keyword
     */
    public List<Property> searchProperties(String keyword) {
        return propertyRepository.searchProperties(keyword).stream()
                .filter(this::isApprovedAndAvailable)
                .toList();
    }
    
    /**
     * Get properties by city
     * @param city City name
     * @return List of properties in the city
     */
    public List<Property> getPropertiesByCity(String city) {
        return propertyRepository.findByCity(city).stream()
                .filter(this::isApprovedAndAvailable)
                .toList();
    }
    
    /**
     * Update property details
     * @param property Property object with updated information
     * @return Updated property object if successful, null otherwise
     */
    @Transactional
    public Property updateProperty(Property property) {
        if (!propertyRepository.existsById(property.getId())) {
            return null;
        }
        
        return propertyRepository.save(property);
    }
    
    /**
     * Mark property as unavailable
     * @param propertyId Property ID
     * @return Updated property object
     */
    @Transactional
    public Property markAsUnavailable(Long propertyId) {
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        
        if (propertyOpt.isEmpty()) {
            return null;
        }
        
        Property property = propertyOpt.get();
        property.setAvailable(false);
        return propertyRepository.save(property);
    }
    
    /**
     * Mark property as available
     * @param propertyId Property ID
     * @return Updated property object
     */
    @Transactional
    public Property markAsAvailable(Long propertyId) {
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        
        if (propertyOpt.isEmpty()) {
            return null;
        }
        
        Property property = propertyOpt.get();
        property.setAvailable(true);
        return propertyRepository.save(property);
    }
    
    /**
     * Delete property
     * @param propertyId Property ID
     */
    @Transactional
    public void deleteProperty(Long propertyId) {
        // Delete all associated images first
        imageService.deleteImagesByProperty(propertyId);
        // Then delete the property
        propertyRepository.deleteById(propertyId);
    }
    
    /**
     * Get all properties (for admin)
     * @return List of all properties
     */
    public List<Property> getAllProperties() {
        return propertyRepository.findAll();
    }
    
    /**
     * Get approved and available properties (for seekers)
     * @return List of approved properties
     */
    public List<Property> getApprovedProperties() {
        return propertyRepository.findApprovedAndAvailable();
    }
    
    /**
     * Get pending properties (for admin approval)
     * @return List of pending properties
     */
    public List<Property> getPendingProperties() {
        return propertyRepository.findByApprovalStatus("PENDING");
    }
    
    /**
     * Approve property by admin
     * @param propertyId Property ID to approve
     * @param adminId Admin user ID
     * @return Updated property
     */
    @Transactional
    public Property approveProperty(Long propertyId, Long adminId) {
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        if (propertyOpt.isEmpty()) {
            return null;
        }
        
        Property property = propertyOpt.get();
        property.setApprovalStatus("APPROVED");
        property.setApprovedBy(adminId);
        property.setApprovedAt(LocalDateTime.now());
        return propertyRepository.save(property);
    }
    
    /**
     * Reject property by admin
     * @param propertyId Property ID to reject
     * @param adminId Admin user ID
     * @return Updated property
     */
    @Transactional
    public Property rejectProperty(Long propertyId, Long adminId) {
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        if (propertyOpt.isEmpty()) {
            return null;
        }
        
        Property property = propertyOpt.get();
        property.setApprovalStatus("REJECTED");
        property.setApprovedBy(adminId);
        property.setApprovedAt(LocalDateTime.now());
        return propertyRepository.save(property);
    }

    private boolean isApprovedAndAvailable(Property property) {
        return property != null
                && property.isAvailable()
                && "APPROVED".equals(property.getApprovalStatus());
    }
}
