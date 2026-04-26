package com.flatfinder.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

/**
 * EmailService - Handles all email sending functionality
 * Sends verification emails, inquiries, and notifications
 */
@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender mailSender;

    @Value("${app.support.email:${spring.mail.username}}")
    private String supportEmail;
    
    /**
     * Send OTP verification email
     * @param toEmail Recipient email
     * @param otp OTP code to send
     * @return true if email sent successfully
     */
    public boolean sendOTPEmail(String toEmail, String otp) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("noreply@flatfinder.com");
            message.setTo(toEmail);
            message.setSubject("FlatFinder - Email Verification OTP");
            message.setText("Dear User,\n\n" +
                    "Your OTP for email verification is: " + otp + "\n\n" +
                    "This OTP is valid for 10 minutes.\n" +
                    "Do not share this OTP with anyone.\n\n" +
                    "Best Regards,\nFlatFinder Team");
            
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending OTP email: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Send welcome email after successful registration
     * @param toEmail Recipient email
     * @param userName User's name
     */
    public boolean sendWelcomeEmail(String toEmail, String userName) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("noreply@flatfinder.com");
            message.setTo(toEmail);
            message.setSubject("Welcome to FlatFinder!");
            message.setText("Dear " + userName + ",\n\n" +
                    "Welcome to FlatFinder - Your broker-free room rental platform!\n\n" +
                    "We're glad to have you on board.\n" +
                    "You can now login and start exploring properties or listing your own.\n\n" +
                    "Happy searching!\n\n" +
                    "Best Regards,\nFlatFinder Team");
            
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending welcome email: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Send inquiry notification to owner
     * @param ownerEmail Owner's email
     * @param ownerName Owner's name
     * @param propertyTitle Property title
     * @param seekerName Seeker's name
     * @param seekerEmail Seeker's email
     * @param seekerPhone Seeker's phone number
     * @param message Inquiry message
     */
    public boolean sendInquiryToOwner(String ownerEmail, String ownerName, 
                                      String propertyTitle, String seekerName, 
                                      String seekerEmail, String seekerPhone, String message) {
        try {
            SimpleMailMessage emailMessage = new SimpleMailMessage();
            emailMessage.setFrom("noreply@flatfinder.com");
            emailMessage.setTo(ownerEmail);
            emailMessage.setSubject("New Inquiry for your property: " + propertyTitle);
            emailMessage.setText("Dear " + ownerName + ",\n\n" +
                    "You have received a new inquiry for your property: " + propertyTitle + "\n\n" +
                    "Inquirer Details:\n" +
                    "Name: " + seekerName + "\n" +
                    "Email: " + seekerEmail + "\n" +
                    "Phone: " + seekerPhone + "\n\n" +
                    "Message:\n" + message + "\n\n" +
                    "Please contact them directly to proceed.\n\n" +
                    "Best Regards,\nFlatFinder Team");
            
            mailSender.send(emailMessage);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending inquiry email to owner: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Send inquiry confirmation to seeker
     * @param seekerEmail Seeker's email
     * @param seekerName Seeker's name
     * @param propertyTitle Property title
     * @param ownerName Owner's name
     * @param ownerEmail Owner's email
     * @param ownerPhone Owner's phone number
     */
    public boolean sendInquiryToSeeker(String seekerEmail, String seekerName, 
                                       String propertyTitle, String ownerName, 
                                       String ownerEmail, String ownerPhone) {
        try {
            SimpleMailMessage emailMessage = new SimpleMailMessage();
            emailMessage.setFrom("noreply@flatfinder.com");
            emailMessage.setTo(seekerEmail);
            emailMessage.setSubject("Inquiry Confirmation - " + propertyTitle);
            emailMessage.setText("Dear " + seekerName + ",\n\n" +
                    "Your inquiry for the property '" + propertyTitle + "' has been submitted successfully!\n\n" +
                    "Owner Details:\n" +
                    "Name: " + ownerName + "\n" +
                    "Email: " + ownerEmail + "\n" +
                    "Phone: " + ownerPhone + "\n\n" +
                    "The owner will contact you soon.\n" +
                    "Thank you for using FlatFinder!\n\n" +
                    "Best Regards,\nFlatFinder Team");
            
            mailSender.send(emailMessage);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending inquiry confirmation to seeker: " + e.getMessage());
            return false;
        }
    }

    public boolean sendContactToSupport(String userName, String userEmail, String userPhone,
                                        String subject, String message) {
        try {
            SimpleMailMessage emailMessage = new SimpleMailMessage();
            emailMessage.setFrom("noreply@flatfinder.com");
            emailMessage.setTo(supportEmail);
            emailMessage.setReplyTo(userEmail);
            emailMessage.setSubject("FlatFinder Contact: " + subject);
            emailMessage.setText("New contact form submission\n\n" +
                    "Name: " + userName + "\n" +
                    "Email: " + userEmail + "\n" +
                    "Phone: " + (userPhone == null || userPhone.isBlank() ? "N/A" : userPhone) + "\n" +
                    "Subject: " + subject + "\n\n" +
                    "Message:\n" + message);
            mailSender.send(emailMessage);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending contact email to support: " + e.getMessage());
            return false;
        }
    }

    public boolean sendContactConfirmationToUser(String userEmail, String userName,
                                                 String subject, String message) {
        try {
            SimpleMailMessage emailMessage = new SimpleMailMessage();
            emailMessage.setFrom("noreply@flatfinder.com");
            emailMessage.setTo(userEmail);
            emailMessage.setSubject("We received your message - FlatFinder");
            emailMessage.setText("Dear " + userName + ",\n\n" +
                    "Thanks for contacting FlatFinder. We have received your message and our team will respond soon.\n\n" +
                    "Subject: " + subject + "\n" +
                    "Your Message:\n" + message + "\n\n" +
                    "Best Regards,\nFlatFinder Team");
            mailSender.send(emailMessage);
            return true;
        } catch (Exception e) {
            System.err.println("Error sending contact confirmation to user: " + e.getMessage());
            return false;
        }
    }
}
