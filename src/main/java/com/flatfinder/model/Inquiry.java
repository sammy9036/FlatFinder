package com.flatfinder.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Inquiry Entity - Represents an inquiry/contact request for a property
 * When a seeker wants to contact an owner about a property
 */
@Entity
@Table(name = "inquiries")
public class Inquiry {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "user_id", nullable = false)
    private Long userId; // Seeker ID
    
    @Column(name = "property_id", nullable = false)
    private Long propertyId;
    
    @Column(columnDefinition = "LONGTEXT")
    private String message;
    
    private String inquirerName;
    
    private String inquirerEmail;
    
    private String inquirerPhone;
    
    private LocalDateTime createdAt;
    
    private String status = "PENDING"; // PENDING, CONTACTED, RESOLVED, REJECTED
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Constructors
    public Inquiry() {
    }
    
    public Inquiry(Long userId, Long propertyId, String message) {
        this.userId = userId;
        this.propertyId = propertyId;
        this.message = message;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getUserId() {
        return userId;
    }
    
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    public Long getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(Long propertyId) {
        this.propertyId = propertyId;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getInquirerName() {
        return inquirerName;
    }
    
    public void setInquirerName(String inquirerName) {
        this.inquirerName = inquirerName;
    }
    
    // Aliases for admin views
    public String getSeekerName() {
        return inquirerName;
    }
    
    public String getInquirerEmail() {
        return inquirerEmail;
    }
    
    public void setInquirerEmail(String inquirerEmail) {
        this.inquirerEmail = inquirerEmail;
    }
    
    // Alias for admin views
    public String getSeekerEmail() {
        return inquirerEmail;
    }
    
    public String getInquirerPhone() {
        return inquirerPhone;
    }
    
    public void setInquirerPhone(String inquirerPhone) {
        this.inquirerPhone = inquirerPhone;
    }
    
    // Alias for admin views
    public String getSeekerPhone() {
        return inquirerPhone;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "Inquiry{" +
                "id=" + id +
                ", userId=" + userId +
                ", propertyId=" + propertyId +
                ", status='" + status + '\'' +
                '}';
    }
}
