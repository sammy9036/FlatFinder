package com.flatfinder.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Image Entity - Represents images/photos for a property
 * Images are stored on the file system AND in database
 * Binary image data is stored in LONGBLOB column for backup
 */
@Entity
@Table(name = "images")
public class Image {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "property_id", nullable = false)
    private Long propertyId;
    
    @Column(nullable = false)
    private String imageUrl; // File path: /uploads/properties/{propertyId}/image_1.jpg
    
    @Column(nullable = false)
    private String fileName; // Original file name (e.g., image_1.jpg)
    
    @Column(nullable = false)
    private String fileType; // MIME type (e.g., image/jpeg)
    
    @Lob
    @Column(name = "image_data", columnDefinition = "LONGBLOB")
    private byte[] imageData; // Binary image data stored in database
    
    private String caption;
    
    private boolean isPrimary = false; // Mark as primary/thumbnail image
    
    private int sequenceNumber; // Sequence order: 1, 2, 3, etc.
    
    private LocalDateTime uploadedAt;
    
    @PrePersist
    protected void onCreate() {
        uploadedAt = LocalDateTime.now();
    }
    
    // Constructors
    public Image() {
    }
    
    public Image(Long propertyId, String imageUrl) {
        this.propertyId = propertyId;
        this.imageUrl = imageUrl;
    }
    
    public Image(Long propertyId, String fileName, String fileType) {
        this.propertyId = propertyId;
        this.fileName = fileName;
        this.fileType = fileType;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(Long propertyId) {
        this.propertyId = propertyId;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getFileType() {
        return fileType;
    }
    
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
    
    public String getCaption() {
        return caption;
    }
    
    public void setCaption(String caption) {
        this.caption = caption;
    }
    
    public LocalDateTime getUploadedAt() {
        return uploadedAt;
    }
    
    public void setUploadedAt(LocalDateTime uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
    
    public int getSequenceNumber() {
        return sequenceNumber;
    }
    
    public void setSequenceNumber(int sequenceNumber) {
        this.sequenceNumber = sequenceNumber;
    }
    
    public boolean isPrimary() {
        return isPrimary;
    }
    
    public void setPrimary(boolean primary) {
        isPrimary = primary;
    }
    
    public byte[] getImageData() {
        return imageData;
    }
    
    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
}