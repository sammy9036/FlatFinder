package com.flatfinder.controller;

import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import com.flatfinder.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * AuthController - Handles user authentication (login, register, logout)
 * Uses HttpSession to maintain user sessions
 * Routes to appropriate JSP views for authentication
 */
@Controller
@RequestMapping("/auth")
public class AuthController {
    
    @Autowired
    private UserService userService;
    
    /**
     * Display login page
     */
    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }
    
    /**
     * Handle login form submission
     * @param email User email
     * @param password User password
     * @param session HTTP session to store user data
     * @param model Model for view
     */
    @PostMapping("/login")
    public String handleLogin(@RequestParam String email, 
                             @RequestParam String password,
                             HttpSession session,
                             Model model) {
        // Authenticate user
        User user = userService.authenticateUser(email, password);
        
        if (user == null) {
            model.addAttribute("error", "Invalid email or password");
            return "auth/login";
        }
        
        // Store user in session
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole().name());  // Store as String
        
        // Redirect based on user role
        if (user.getRole() == UserRole.OWNER) {
            return "redirect:/owner/dashboard";
        } else if (user.getRole() == UserRole.ADMIN) {
            return "redirect:/admin/dashboard";
        } else {
            return "redirect:/seeker/home";
        }
    }
    
    /**
     * Display registration page
     */
    @GetMapping("/register")
    public String registerPage() {
        return "auth/register";
    }
    
    /**
     * Handle registration form submission
     * @param name User name
     * @param email User email
     * @param password User password
     * @param role User role (SEEKER or OWNER)
     * @param phone Phone number
     * @param model Model for view
     */
    @PostMapping("/register")
    public String handleRegister(@RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String password,
                                @RequestParam String role,
                                @RequestParam(required = false) String phone,
                                @RequestParam(required = false) String address,
                                Model model) {
        
        // Validate email doesn't already exist
        if (userService.getUserByEmail(email) != null) {
            model.addAttribute("error", "Email already registered");
            return "auth/register";
        }
        
        // Create new user
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhoneNumber(phone);
        user.setAddress(address);
        user.setRole(UserRole.valueOf(role.toUpperCase()));
        
        // Register user
        User registeredUser = userService.registerUser(user);
        
        if (registeredUser == null) {
            model.addAttribute("error", "Registration failed. Please check your input.");
            return "auth/register";
        }
        
        model.addAttribute("success", "Registration successful! Check your email for OTP.");
        model.addAttribute("email", email);
        return "auth/otp";
    }
    
    /**
     * Display OTP verification page
     */
    @GetMapping("/otp")
    public String otpPage() {
        return "auth/otp";
    }
    
    /**
     * Handle OTP verification
     * @param email User email
     * @param otp OTP code to verify
     * @param session HTTP session
     * @param model Model for view
     */
    @PostMapping("/verify-otp")
    public String verifyOTP(@RequestParam String email,
                           @RequestParam String otp,
                           HttpSession session,
                           Model model) {
        
        // Verify OTP
        boolean verified = userService.verifyEmail(email, otp);
        
        if (!verified) {
            model.addAttribute("error", "Invalid OTP");
            model.addAttribute("email", email);
            return "auth/otp";
        }
        
        model.addAttribute("success", "Email verified successfully! You can now login.");
        return "auth/login";
    }
    
    /**
     * Handle logout
     * @param session HTTP session
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
