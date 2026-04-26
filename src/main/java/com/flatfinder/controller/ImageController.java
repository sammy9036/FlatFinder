package com.flatfinder.controller;

import com.flatfinder.model.Image;
import com.flatfinder.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

/**
 * ImageController - Handles image upload and download endpoints
 */
@Controller
@RequestMapping("/image")
public class ImageController {
    
    @Autowired
    private ImageService imageService;
    
    /**
     * Upload image for a property
     * Used via AJAX or form submission
     */
    @PostMapping("/upload/{propertyId}")
    @ResponseBody
    public ResponseEntity<?> uploadImage(
            @PathVariable Long propertyId,
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "isPrimary", defaultValue = "false") boolean isPrimary) {
        
        try {
            Image image = imageService.uploadImage(propertyId, file, isPrimary);
            return ResponseEntity.ok(new ImageUploadResponse(
                    true,
                    "Image uploaded successfully",
                    image.getId(),
                    "/image/download/" + image.getId()
            ));
        } catch (IOException e) {
            return ResponseEntity.badRequest().body(new ImageUploadResponse(
                    false,
                    "Failed to upload image: " + e.getMessage(),
                    null,
                    null
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(new ImageUploadResponse(
                    false,
                    e.getMessage(),
                    null,
                    null
            ));
        }
    }
    
    /**
     * Download/Retrieve image by ID
     * Serves the binary image data with proper content type
     */
    @GetMapping("/download/{imageId}")
    public ResponseEntity<?> downloadImage(@PathVariable Long imageId) {
        Optional<Image> imageOpt = imageService.getImageById(imageId);
        
        if (!imageOpt.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        
        Image image = imageOpt.get();
        
        // Get file type, default to image/jpeg if empty or null
        String fileType = image.getFileType();
        if (fileType == null || fileType.trim().isEmpty()) {
            fileType = "image/jpeg";
        }
        
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(fileType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + image.getFileName() + "\"")
                .body(image.getImageData());
    }
    
    /**
     * Get primary image for a property
     * Useful for thumbnails in listings
     */
    @GetMapping("/primary/{propertyId}")
    public ResponseEntity<?> getPrimaryImage(@PathVariable Long propertyId) {
        Optional<Image> imageOpt = imageService.getPrimaryImage(propertyId);
        
        if (!imageOpt.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        
        Image image = imageOpt.get();
        
        // Get file type, default to image/jpeg if empty or null
        String fileType = image.getFileType();
        if (fileType == null || fileType.trim().isEmpty()) {
            fileType = "image/jpeg";
        }
        
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(fileType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + image.getFileName() + "\"")
                .body(image.getImageData());
    }
    
    /**
     * Set an image as primary for a property
     */
    @PostMapping("/set-primary/{propertyId}/{imageId}")
    @ResponseBody
    public ResponseEntity<?> setPrimaryImage(
            @PathVariable Long propertyId,
            @PathVariable Long imageId) {
        
        try {
            imageService.setPrimaryImage(propertyId, imageId);
            return ResponseEntity.ok(new ImageUploadResponse(
                    true,
                    "Primary image set successfully",
                    imageId,
                    null
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new ImageUploadResponse(
                    false,
                    "Failed to set primary image: " + e.getMessage(),
                    null,
                    null
            ));
        }
    }
    
    /**
     * Delete image
     */
    @DeleteMapping("/delete/{imageId}")
    @ResponseBody
    public ResponseEntity<?> deleteImage(@PathVariable Long imageId) {
        try {
            imageService.deleteImage(imageId);
            return ResponseEntity.ok(new ImageUploadResponse(
                    true,
                    "Image deleted successfully",
                    imageId,
                    null
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new ImageUploadResponse(
                    false,
                    "Failed to delete image: " + e.getMessage(),
                    null,
                    null
            ));
        }
    }
    
    /**
     * Inner class for JSON response
     */
    public static class ImageUploadResponse {
        public boolean success;
        public String message;
        public Long imageId;
        public String imageUrl;
        
        public ImageUploadResponse(boolean success, String message, Long imageId, String imageUrl) {
            this.success = success;
            this.message = message;
            this.imageId = imageId;
            this.imageUrl = imageUrl;
        }
    }
}
