package com.flatfinder.util;

import java.util.Random;

/**
 * OTPUtil - Utility class for generating and validating OTP (One Time Password)
 * Used for email verification during registration
 */
public class OTPUtil {
    
    private static final int OTP_LENGTH = 6;
    private static final String OTP_CHARACTERS = "0123456789";
    
    /**
     * Generate a random 6-digit OTP
     * @return OTP as String
     */
    public static String generateOTP() {
        StringBuilder otp = new StringBuilder();
        Random random = new Random();
        
        for (int i = 0; i < OTP_LENGTH; i++) {
            int index = random.nextInt(OTP_CHARACTERS.length());
            otp.append(OTP_CHARACTERS.charAt(index));
        }
        
        return otp.toString();
    }
    
    /**
     * Validate if OTP is in correct format (6 digits)
     * @param otp OTP to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidOTP(String otp) {
        if (otp == null || otp.length() != OTP_LENGTH) {
            return false;
        }
        return otp.matches("[0-9]{" + OTP_LENGTH + "}");
    }
    
    /**
     * Check if two OTPs match
     * @param otp1 First OTP
     * @param otp2 Second OTP
     * @return true if they match, false otherwise
     */
    public static boolean matchOTP(String otp1, String otp2) {
        return otp1 != null && otp1.equals(otp2);
    }
}
