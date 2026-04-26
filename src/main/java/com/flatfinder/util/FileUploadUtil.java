package com.flatfinder.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * FileUploadUtil - Handles file upload operations to file system
 * Stores property images in uploads/properties/{propertyId}/ folder
 * Supports .jpg, .jpeg, .png, .gif, .webp file types
 */
public class FileUploadUtil {
    
    private static final String UPLOADS_DIR = "src/main/webapp/uploads";
    private static final String PROPERTIES_DIR = "properties";
    private static final long MAX_FILE_SIZE = 50 * 1024 * 1024; // 50MB per file
    private static final int MAX_IMAGES_PER_PROPERTY = 4;  // Max 4 images per property
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp"};
    
    /**
     * Save uploaded file to file system
     * @param propertyId Property ID
     * @param file MultipartFile to save
     * @return Relative file path (e.g., /uploads/properties/1/image_1.jpg)
     */
    public static String savePropertyImage(Long propertyId, MultipartFile file) throws IOException {
        // Validate file
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File cannot be empty");
        }
        
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("File size exceeds 50MB limit");
        }
        
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IllegalArgumentException("File must be an image (jpg, png, gif, webp)");
        }
        
        // Create property folder if not exists
        Path propertyPath = Paths.get(UPLOADS_DIR, PROPERTIES_DIR, propertyId.toString());
        Files.createDirectories(propertyPath);
        
        // Get file extension
        String originalFilename = file.getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);
        
        // Validate extension
        boolean isValidExtension = false;
        for (String ext : ALLOWED_EXTENSIONS) {
            if (fileExtension.equalsIgnoreCase(ext)) {
                isValidExtension = true;
                break;
            }
        }
        
        if (!isValidExtension) {
            throw new IllegalArgumentException("File type not allowed. Supported: .jpg, .png, .webp, .gif");
        }
        
        // Get next sequence number
        int sequenceNumber = getNextSequenceNumber(propertyId);
        
        if (sequenceNumber > MAX_IMAGES_PER_PROPERTY) {
            throw new IllegalArgumentException("Maximum " + MAX_IMAGES_PER_PROPERTY + " images per property allowed");
        }
        
        // Create filename: image_1.jpg, image_2.jpg, etc.
        String newFileName = "image_" + sequenceNumber + fileExtension;
        Path filePath = propertyPath.resolve(newFileName);
        
        // Save file
        Files.write(filePath, file.getBytes());
        
        // Return relative path for database storage
        return "/uploads/" + PROPERTIES_DIR + "/" + propertyId + "/" + newFileName;
    }
    
    /**
     * Get next sequence number for property images
     */
    public static int getNextSequenceNumber(Long propertyId) throws IOException {
        Path propertyPath = Paths.get(UPLOADS_DIR, PROPERTIES_DIR, propertyId.toString());
        
        if (!Files.exists(propertyPath)) {
            return 1;
        }
        
        return (int) Files.list(propertyPath)
                .filter(path -> Files.isRegularFile(path) && path.toString().endsWith(".jpg") || 
                        path.toString().endsWith(".jpeg") || path.toString().endsWith(".png") || 
                        path.toString().endsWith(".gif") || path.toString().endsWith(".webp"))
                .count() + 1;
    }
    
    /**
     * Get file extension with dot (e.g., .jpg, .png)
     */
    public static String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return ".jpg";
        }
        return filename.substring(filename.lastIndexOf(".")).toLowerCase();
    }
    
    /**
     * Delete image file from file system
     */
    public static boolean deletePropertyImage(String imagePath) {
        try {
            if (imagePath == null || imagePath.isEmpty()) {
                return false;
            }
            
            // Convert relative path to absolute path
            String relativePath = imagePath.startsWith("/uploads/") ? 
                    imagePath.substring(1) : imagePath;
            Path filePath = Paths.get(relativePath);
            
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                return true;
            }
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete all images for a property
     */
    public static boolean deletePropertyImages(Long propertyId) {
        try {
            Path propertyPath = Paths.get(UPLOADS_DIR, PROPERTIES_DIR, propertyId.toString());
            
            if (!Files.exists(propertyPath)) {
                return true; // Already deleted
            }
            
            // Delete all files in the directory
            Files.list(propertyPath)
                    .forEach(path -> {
                        try {
                            Files.delete(path);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    });
            
            // Delete the directory itself
            Files.delete(propertyPath);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Check if image exists
     */
    public static boolean imageExists(String imagePath) {
        try {
            if (imagePath == null || imagePath.isEmpty()) {
                return false;
            }
            
            String relativePath = imagePath.startsWith("/uploads/") ? 
                    imagePath.substring(1) : imagePath;
            Path filePath = Paths.get(relativePath);
            
            return Files.exists(filePath) && Files.isRegularFile(filePath);
        } catch (Exception e) {
            return false;
        }
    }
}
