package com.flatfinder.repository;

import com.flatfinder.model.Inquiry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

/**
 * InquiryRepository - Handles all database operations for Inquiry entity
 * Provides CRUD operations for inquiries/contact requests
 */
@Repository
public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
    
    /**
     * Find all inquiries for a specific property
     */
    List<Inquiry> findByPropertyId(Long propertyId);
    
    /**
     * Find all inquiries by a specific user (seeker)
     */
    List<Inquiry> findByUserId(Long userId);
    
    /**
     * Find inquiries for properties owned by a specific owner
     */
    List<Inquiry> findByPropertyIdIn(List<Long> propertyIds);
    
    /**
     * Find inquiries by status
     */
    List<Inquiry> findByStatus(String status);
}
