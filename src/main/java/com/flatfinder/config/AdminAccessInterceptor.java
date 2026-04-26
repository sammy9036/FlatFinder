package com.flatfinder.config;

import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * AdminAccessInterceptor - Intercepts admin routes and validates admin access
 * Redirects non-admin users to login or home page
 */
public class AdminAccessInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Get session and user
        HttpSession session = request.getSession(false);
        User user = null;
        
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        // Check if user is logged in and is admin
        if (user == null || user.getRole() != UserRole.ADMIN) {
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/auth/login?message=admin_access_required");
            return false;
        }
        
        // User is admin, allow access
        return true;
    }
}
