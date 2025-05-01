package com.tollManagement.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Handles password hashing and verification using BCrypt
 * (compatible with existing $2a$ hashes in your database)
 */
public class PasswordUtil {
    // The log rounds parameter determines the computational complexity
    // (4-31, default is 10). Higher = more secure but slower
    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Hashes a password using BCrypt
     * @param plainPassword The plain text password to hash
     * @return The hashed password (starting with $2a$...)
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Verifies a plain password against a stored BCrypt hash
     * @param plainPassword The password to check
     * @param hashedPassword The stored hash (from database)
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            // Handle cases where hashedPassword is malformed
            return false;
        }
    }

    /**
     * Helper method to check if a string looks like a BCrypt hash
     * (Useful for migration scenarios)
     */
    public static boolean isBCryptHash(String potentialHash) {
        return potentialHash != null && potentialHash.startsWith("$2a$");
    }
}