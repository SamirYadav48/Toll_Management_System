package com.tollManagement.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;

public class UserSettingsService {
    
    public UserModel getUserDetails(String username) {
        String query = "SELECT * FROM User WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                UserModel user = new UserModel();
                user.setUsername(rs.getString("username"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setProvince(rs.getString("province"));
                user.setPostalCode(rs.getString("postal_code"));
                user.setVehicleType(rs.getString("vehicle_type"));
                user.setVehicleNumber(rs.getString("vehicle_number"));
                user.setCitizenshipNumber(rs.getString("citizenship_number"));
                return user;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateUserProfile(String username, String firstName, String lastName, 
                                   String email, String phone, String province, 
                                   String postalCode) {
        String query = "UPDATE User SET first_name = ?, last_name = ?, email = ?, " +
                      "phone = ?, province = ?, postal_code = ? WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, province);
            pstmt.setString(6, postalCode);
            pstmt.setString(7, username);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updatePassword(String username, String currentPassword, String newPassword) {
        // First verify current password
        String verifyQuery = "SELECT password FROM User WHERE username = ? AND password = ?";
        String updateQuery = "UPDATE User SET password = ? WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection()) {
            // Verify current password
            try (PreparedStatement pstmt = conn.prepareStatement(verifyQuery)) {
                pstmt.setString(1, username);
                pstmt.setString(2, currentPassword);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    // Current password is correct, update to new password
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, newPassword);
                        updateStmt.setString(2, username);
                        int rows = updateStmt.executeUpdate();
                        return rows > 0;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean updatePreferences(String username, String language, String currency, 
                                   String theme, String defaultPaymentMethod) {
        String query = "UPDATE User SET language = ?, currency = ?, theme = ?, " +
                      "default_payment_method = ? WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, language);
            pstmt.setString(2, currency);
            pstmt.setString(3, theme);
            pstmt.setString(4, defaultPaymentMethod);
            pstmt.setString(5, username);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateNotifications(String username, boolean emailNotifications, 
                                     boolean smsNotifications, boolean pushNotifications,
                                     boolean lowBalanceAlerts, boolean paymentReceipts,
                                     boolean promotionalOffers) {
        String query = "UPDATE User SET email_notifications = ?, sms_notifications = ?, " +
                      "push_notifications = ?, low_balance_alerts = ?, payment_receipts = ?, " +
                      "promotional_offers = ? WHERE username = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setBoolean(1, emailNotifications);
            pstmt.setBoolean(2, smsNotifications);
            pstmt.setBoolean(3, pushNotifications);
            pstmt.setBoolean(4, lowBalanceAlerts);
            pstmt.setBoolean(5, paymentReceipts);
            pstmt.setBoolean(6, promotionalOffers);
            pstmt.setString(7, username);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
} 