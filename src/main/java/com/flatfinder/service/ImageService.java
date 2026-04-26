package com.flatfinder.service;

import com.flatfinder.model.Image;
import com.flatfinder.model.Property;
import com.flatfinder.repository.ImageRepository;
import com.flatfinder.repository.PropertyRepository;
import com.flatfinder.util.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * ImageService - Handles image upload, storage, and retrieval
 * Images are stored on the file system in uploads/properties/{propertyId}/ folder
 * AND also stored in database as binary data for backup/retrieval
 */
@Service
public class ImageService {
    
    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private PropertyRepository propertyRepository;
    
    /**
     * Upload and save image to file system AND database
     * @param propertyId The property ID this image belongs to
     * @param file The multipart file to upload
     * @param isPrimary Whether this should be the primary/thumbnail image
     * @return Saved Image object
     */
    @Transactional
    public Image uploadImage(Long propertyId, MultipartFile file, boolean isPrimary) throws IOException {
        // Validate file
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File cannot be empty");
        }
        
        // Save file to file system
        String imagePath = FileUploadUtil.savePropertyImage(propertyId, file);
        
        // Get sequence number
        int sequenceNumber = FileUploadUtil.getNextSequenceNumber(propertyId);
        
        // Create image object
        Image image = new Image();
        image.setPropertyId(propertyId);
        image.setFileName(file.getOriginalFilename());
        image.setFileType(file.getContentType());
        image.setImageUrl(imagePath);
        image.setSequenceNumber(sequenceNumber);
        image.setPrimary(isPrimary);
        image.setUploadedAt(LocalDateTime.now());
        
        // Store binary image data in database
        image.setImageData(file.getBytes());
        
        // If this is primary, mark other images as non-primary
        if (isPrimary) {
            List<Image> existingImages = imageRepository.findByPropertyId(propertyId);
            for (Image img : existingImages) {
                img.setPrimary(false);
                imageRepository.save(img);
            }
        }
        
        Image savedImage = imageRepository.save(image);

        // Keep Property.imageUrl in sync so the properties table has a usable thumbnail reference.
        Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
        if (propertyOpt.isPresent()) {
            Property property = propertyOpt.get();
            String generatedImageUrl = "/image/download/" + savedImage.getId();
            if (isPrimary || property.getImageUrl() == null || property.getImageUrl().trim().isEmpty()) {
                property.setImageUrl(generatedImageUrl);
                propertyRepository.save(property);
            }
        }

        return savedImage;
    }
    
    /**
     * Get all images for a property
     */
    public List<Image> getImagesByProperty(Long propertyId) {
        return imageRepository.findByPropertyId(propertyId);
    }
    
    /**
     * Get primary/thumbnail image for a property
     */
    public Optional<Image> getPrimaryImage(Long propertyId) {
        List<Image> images = getImagesByProperty(propertyId);
        if (images.isEmpty()) {
            return Optional.empty();
        }
        
        // Return primary image if exists
        for (Image img : images) {
            if (img.isPrimary()) {
                return Optional.of(img);
            }
        }
        
        // Return first image if no primary found
        return Optional.of(images.get(0));
    }
    
    /**
     * Get single image by ID
     */
    public Optional<Image> getImageById(Long imageId) {
        return imageRepository.findById(imageId);
    }
    
    /**
     * Delete image by ID
     */
    @Transactional
    public void deleteImage(Long imageId) {
        Optional<Image> imageOpt = imageRepository.findById(imageId);
        if (imageOpt.isPresent()) {
            Image image = imageOpt.get();
            // Delete file from file system
            FileUploadUtil.deletePropertyImage(image.getImageUrl());
            // Delete from database
            imageRepository.deleteById(imageId);
        }
    }
    
    /**
     * Delete all images for a property
     */
    @Transactional
    public void deleteImagesByProperty(Long propertyId) {
        List<Image> images = getImagesByProperty(propertyId);
        
        // Delete files from file system
        for (Image image : images) {
            FileUploadUtil.deletePropertyImage(image.getImageUrl());
        }
        
        // Delete from database
        imageRepository.deleteByPropertyId(propertyId);
    }
    
    /**
     * Set an image as primary for a property
     */
    @Transactional
    public void setPrimaryImage(Long propertyId, Long imageId) {
        // Set all images for property to non-primary
        List<Image> images = getImagesByProperty(propertyId);
        for (Image img : images) {
            img.setPrimary(false);
            imageRepository.save(img);
        }
        
        // Set specified image as primary
        Optional<Image> imageOpt = getImageById(imageId);
        if (imageOpt.isPresent()) {
            Image image = imageOpt.get();
            if (image.getPropertyId().equals(propertyId)) {
                image.setPrimary(true);
                Image savedPrimary = imageRepository.save(image);

                Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
                if (propertyOpt.isPresent()) {
                    Property property = propertyOpt.get();
                    property.setImageUrl("/image/download/" + savedPrimary.getId());
                    propertyRepository.save(property);
                }
            }
        }
    }
}
