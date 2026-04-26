package com.flatfinder.repository;

import com.flatfinder.model.User;
import com.flatfinder.model.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

/**
 * UserRepository - Handles all database operations for User entity
 * Provides CRUD operations and custom query methods
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);
    
    /**
     * Find all users with a specific role (SEEKER, OWNER, ADMIN)
     */
    List<User> findByRole(UserRole role);
    
    /**
     * Check if email already exists
     */
    boolean existsByEmail(String email);
    
    /**
     * Find user by OTP code (for verification)
     */
    Optional<User> findByOtpCode(String otpCode);
}
