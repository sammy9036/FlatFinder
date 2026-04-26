package com.flatfinder.util;

/**
 * ValidationUtil - Utility class for input validation
 * Provides methods to validate email, password, and other inputs
 */
public class ValidationUtil {
    
    /**
     * Validate email format
     * @param email Email to validate
     * @return true if email is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    /**
     * Validate password strength
     * Password must be at least 6 characters
     * @param password Password to validate
     * @return true if password is strong enough, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        return true;
    }
    
    /**
     * Validate phone number format (simple validation)
     * @param phone Phone number to validate
     * @return true if phone is valid, false otherwise
     */
    public static boolean isValidPhoneNumber(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return phone.matches("[0-9]{10}");
    }
    
    /**
     * Validate if string is not empty
     * @param str String to validate
     * @return true if not empty, false otherwise
     */
    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    /**
     * Validate if a double value is positive
     * @param value Value to validate
     * @return true if positive, false otherwise
     */
    public static boolean isPositiveNumber(Double value) {
        return value != null && value > 0;
    }
}
