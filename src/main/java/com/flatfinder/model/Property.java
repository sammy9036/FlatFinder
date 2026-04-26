package com.flatfinder.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Property Entity - Represents a property/room listed for rent
 */
@Entity
@Table(name = "properties")
public class Property {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String title;
    
    @Column(columnDefinition = "LONGTEXT")
    private String description;
    
    @Column(nullable = false)
    private Double price;
    
    @Column(nullable = false)
    private String location;
    
    private String city;
    
    private String bedrooms;
    
    private String bathrooms;
    
    private String area; // in sq ft
    
    private String amenities;
    
    @Column(name = "owner_id", nullable = false)
    private Long ownerId;
    
    private String imageUrl; // Main image URL
    
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    private boolean isAvailable = true;
    
    @Column(name = "approval_status", length = 20)
    private String approvalStatus = "PENDING"; // PENDING, APPROVED, REJECTED
    
    @Column(name = "approved_by")
    private Long approvedBy; // Admin who approved
    
    @Column(name = "approved_at")
    private LocalDateTime approvedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (approvalStatus == null) {
            approvalStatus = "PENDING";
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Constructors
    public Property() {
    }
    
    public Property(String title, String description, Double price, String location, Long ownerId) {
        this.title = title;
        this.description = description;
        this.price = price;
        this.location = location;
        this.ownerId = ownerId;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getBedrooms() {
        return bedrooms;
    }
    
    public void setBedrooms(String bedrooms) {
        this.bedrooms = bedrooms;
    }
    
    public String getBathrooms() {
        return bathrooms;
    }
    
    public void setBathrooms(String bathrooms) {
        this.bathrooms = bathrooms;
    }
    
    public String getArea() {
        return area;
    }
    
    public void setArea(String area) {
        this.area = area;
    }
    
    public String getAmenities() {
        return amenities;
    }
    
    public void setAmenities(String amenities) {
        this.amenities = amenities;
    }
    
    public Long getOwnerId() {
        return ownerId;
    }
    
    public void setOwnerId(Long ownerId) {
        this.ownerId = ownerId;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean available) {
        isAvailable = available;
    }
    
    public String getApprovalStatus() {
        return approvalStatus;
    }
    
    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
    
    public Long getApprovedBy() {
        return approvedBy;
    }
    
    public void setApprovedBy(Long approvedBy) {
        this.approvedBy = approvedBy;
    }
    
    public LocalDateTime getApprovedAt() {
        return approvedAt;
    }
    
    public void setApprovedAt(LocalDateTime approvedAt) {
        this.approvedAt = approvedAt;
    }
    
    @Override
    public String toString() {
        return "Property{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", price=" + price +
                ", location='" + location + '\'' +
                ", ownerId=" + ownerId +
                '}';
    }
}
