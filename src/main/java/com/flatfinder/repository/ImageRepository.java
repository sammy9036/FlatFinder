package com.flatfinder.repository;

import com.flatfinder.model.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

/**
 * ImageRepository - Handles all database operations for Image entity
 * Manages property images and photos
 */
@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    
    /**
     * Find all images for a specific property
     */
    List<Image> findByPropertyId(Long propertyId);
    
    /**
     * Find primary image for a specific property
     */
    Optional<Image> findByPropertyIdAndIsPrimaryTrue(Long propertyId);
    
    /**
     * Delete all images for a property (cascade delete)
     */
    void deleteByPropertyId(Long propertyId);
}
