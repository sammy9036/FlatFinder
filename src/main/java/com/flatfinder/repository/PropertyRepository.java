package com.flatfinder.repository;

import com.flatfinder.model.Property;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

/**
 * PropertyRepository - Handles all database operations for Property entity
 * Provides CRUD operations and custom queries for property search
 */
@Repository
public interface PropertyRepository extends JpaRepository<Property, Long> {
    
    /**
     * Find all properties by owner ID
     */
    List<Property> findByOwnerId(Long ownerId);
    
    /**
     * Find all available properties
     */
    List<Property> findByIsAvailableTrue();
    
    /**
     * Find properties by city
     */
    List<Property> findByCity(String city);
    
    /**
     * Find properties by location containing keyword
     */
    List<Property> findByLocationContainingIgnoreCase(String location);
    
    /**
     * Find properties within price range
     */
    @Query("SELECT p FROM Property p WHERE p.price >= :minPrice AND p.price <= :maxPrice AND p.isAvailable = true")
    List<Property> findByPriceRange(@Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice);
    
    /**
     * Search properties by title and location
     */
    @Query("SELECT p FROM Property p WHERE (p.title LIKE %:keyword% OR p.location LIKE %:keyword% OR p.description LIKE %:keyword%) AND p.isAvailable = true")
    List<Property> searchProperties(@Param("keyword") String keyword);
    
    // Approval workflow queries
    List<Property> findByApprovalStatus(String approvalStatus);
    
    @Query("SELECT p FROM Property p WHERE p.approvalStatus = 'APPROVED' AND p.isAvailable = true")
    List<Property> findApprovedAndAvailable();
    
    @Query("SELECT p FROM Property p WHERE p.ownerId = :ownerId ORDER BY p.createdAt DESC")
    List<Property> findByOwnerIdOrderByCreatedDesc(@Param("ownerId") Long ownerId);
}
