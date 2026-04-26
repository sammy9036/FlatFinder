package com.flatfinder.service;

import com.flatfinder.model.Inquiry;
import com.flatfinder.model.Property;
import com.flatfinder.model.User;
import com.flatfinder.repository.InquiryRepository;
import com.flatfinder.repository.PropertyRepository;
import com.flatfinder.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

/**
 * InquiryService - Business logic for inquiry operations
 * Handles inquiry creation, retrieval, and status management
 * Coordinates with EmailService to send notifications
 */
@Service
public class InquiryService {
    
    @Autowired
    private InquiryRepository inquiryRepository;
    
    @Autowired
    private PropertyRepository propertyRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private EmailService emailService;
    
    /**
     * Create and save an inquiry
     * Also sends email notifications to both owner and seeker
     * @param inquiry Inquiry object
     * @return Saved inquiry object if successful, null otherwise
     */
    public Inquiry createInquiry(Inquiry inquiry) {
        if (inquiry.getUserId() == null || inquiry.getPropertyId() == null) {
            return null;
        }
        
        // Get property details
        Optional<Property> propertyOpt = propertyRepository.findById(inquiry.getPropertyId());
        if (propertyOpt.isEmpty()) {
            return null;
        }
        
        Property property = propertyOpt.get();
        
        // Get seeker details
        Optional<User> seekerOpt = userRepository.findById(inquiry.getUserId());
        if (seekerOpt.isEmpty()) {
            return null;
        }
        
        User seeker = seekerOpt.get();
        
        // Get owner details
        Optional<User> ownerOpt = userRepository.findById(property.getOwnerId());
        if (ownerOpt.isEmpty()) {
            return null;
        }
        
        User owner = ownerOpt.get();
        
        // Save inquiry
        inquiry.setInquirerName(seeker.getName());
        inquiry.setInquirerEmail(seeker.getEmail());
        inquiry.setInquirerPhone(seeker.getPhoneNumber());
        
        Inquiry savedInquiry = inquiryRepository.save(inquiry);
        
        // Send email to owner
        emailService.sendInquiryToOwner(
            owner.getEmail(),
            owner.getName(),
            property.getTitle(),
            seeker.getName(),
            seeker.getEmail(),
            seeker.getPhoneNumber(),
            inquiry.getMessage()
        );
        
        // Send confirmation email to seeker
        emailService.sendInquiryToSeeker(
            seeker.getEmail(),
            seeker.getName(),
            property.getTitle(),
            owner.getName(),
            owner.getEmail(),
            owner.getPhoneNumber()
        );
        
        return savedInquiry;
    }
    
    /**
     * Get inquiry by ID
     * @param inquiryId Inquiry ID
     * @return Inquiry object if found, null otherwise
     */
    public Inquiry getInquiryById(Long inquiryId) {
        Optional<Inquiry> inquiryOpt = inquiryRepository.findById(inquiryId);
        return inquiryOpt.orElse(null);
    }
    
    /**
     * Get all inquiries for a property
     * @param propertyId Property ID
     * @return List of inquiries for the property
     */
    public List<Inquiry> getInquiriesByProperty(Long propertyId) {
        return inquiryRepository.findByPropertyId(propertyId);
    }
    
    /**
     * Get all inquiries by a seeker
     * @param userId User ID (seeker)
     * @return List of inquiries by the user
     */
    public List<Inquiry> getInquiriesByUser(Long userId) {
        return inquiryRepository.findByUserId(userId);
    }
    
    /**
     * Get all inquiries for properties owned by an owner
     * @param propertyIds List of property IDs owned by the owner
     * @return List of inquiries for those properties
     */
    public List<Inquiry> getInquiriesByOwner(List<Long> propertyIds) {
        return inquiryRepository.findByPropertyIdIn(propertyIds);
    }
    
    /**
     * Update inquiry status
     * @param inquiryId Inquiry ID
     * @param status New status (PENDING, CONTACTED, RESOLVED)
     * @return Updated inquiry object
     */
    public Inquiry updateInquiryStatus(Long inquiryId, String status) {
        Optional<Inquiry> inquiryOpt = inquiryRepository.findById(inquiryId);
        
        if (inquiryOpt.isEmpty()) {
            return null;
        }
        
        Inquiry inquiry = inquiryOpt.get();
        inquiry.setStatus(status);
        return inquiryRepository.save(inquiry);
    }
    
    /**
     * Delete inquiry
     * @param inquiryId Inquiry ID
     */
    public void deleteInquiry(Long inquiryId) {
        inquiryRepository.deleteById(inquiryId);
    }
    
    /**
     * Get all inquiries by status
     * @param status Status to filter by
     * @return List of inquiries with that status
     */
    public List<Inquiry> getInquiriesByStatus(String status) {
        return inquiryRepository.findByStatus(status);
    }
    
    /**
     * Get all inquiries (for admin)
     * @return List of all inquiries
     */
    public List<Inquiry> getAllInquiries() {
        return inquiryRepository.findAll();
    }
}
