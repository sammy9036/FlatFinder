package com.flatfinder.service;

import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import com.flatfinder.repository.UserRepository;
import com.flatfinder.util.OTPUtil;
import com.flatfinder.util.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

/**
 * UserService - Business logic for user operations
 * Handles registration, login, verification, and user management
 */
@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private EmailService emailService;
    
    /**
     * Register a new user
     * @param user User object with name, email, password, role
     * @return User object if successful, null if email already exists or validation fails
     */
    public User registerUser(User user) {
        // Validate inputs
        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            return null;
        }
        
        if (!ValidationUtil.isValidPassword(user.getPassword())) {
            return null;
        }
        
        // Check if email already exists
        if (userRepository.existsByEmail(user.getEmail())) {
            return null;
        }
        
        // Generate OTP for email verification
        String otp = OTPUtil.generateOTP();
        user.setOtpCode(otp);
        user.setVerified(false);
        
        // Save user to database
        User savedUser = userRepository.save(user);
        
        // Send OTP email
        emailService.sendOTPEmail(user.getEmail(), otp);
        
        return savedUser;
    }
    
    /**
     * Verify user email with OTP
     * @param email User's email
     * @param otp OTP code to verify
     * @return true if verification successful, false otherwise
     */
    public boolean verifyEmail(String email, String otp) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isEmpty()) {
            return false;
        }
        
        User user = userOpt.get();
        
        // Check if OTP matches
        if (!OTPUtil.matchOTP(user.getOtpCode(), otp)) {
            return false;
        }
        
        // Mark user as verified
        user.setVerified(true);
        user.setOtpCode(null); // Clear OTP after verification
        userRepository.save(user);
        
        // Send welcome email
        emailService.sendWelcomeEmail(email, user.getName());
        
        return true;
    }
    
    /**
     * Authenticate user (login)
     * @param email User's email
     * @param password User's password
     * @return User object if credentials are correct, null otherwise
     */
    public User authenticateUser(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isEmpty()) {
            return null;
        }
        
        User user = userOpt.get();
        
        // Simple password comparison (in production, use bcrypt)
        if (!user.getPassword().equals(password)) {
            return null;
        }
        
        // Check if user is verified
        if (!user.isVerified()) {
            return null;
        }
        
        return user;
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object if found, null otherwise
     */
    public User getUserById(Long userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        return userOpt.orElse(null);
    }
    
    /**
     * Get user by email
     * @param email User's email
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        return userOpt.orElse(null);
    }
    
    /**
     * Update user profile
     * @param user User object with updated information
     * @return Updated user object
     */
    public User updateUserProfile(User user) {
        if (userRepository.existsById(user.getId())) {
            return userRepository.save(user);
        }
        return null;
    }
    
    /**
     * Get all users with specific role
     * @param role UserRole (SEEKER, OWNER, ADMIN)
     * @return List of users with that role
     */
    public List<User> getUsersByRole(UserRole role) {
        return userRepository.findByRole(role);
    }
    
    /**
     * Get all users (for admin)
     * @return List of all users
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    /**
     * Delete user by ID
     * @param userId User ID
     */
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }
}
