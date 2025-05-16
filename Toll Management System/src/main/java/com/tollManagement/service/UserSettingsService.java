package com.tollManagement.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.tollManagement.config.DbConfig;
import com.tollManagement.model.UserModel;
import com.tollManagement.model.TollRateModel;

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
                user.setCitizenshipNumber(rs.getString("citizenship_number"));
                user.setAccountType(rs.getString("account_type"));
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

    /**
     * Gets combined user and vehicle details for a given username.
     * This method joins the User and Vehicle tables to get all relevant information.
     * @param username The username to fetch details for
     * @return Map containing both user and vehicle details
     */
    public Map<String, Object> getCombinedUserDetails(String username) {
        Map<String, Object> details = new HashMap<>();
        
        String query = """
            SELECT u.*, v.vehicle_type, v.vehicle_number, v.total_toll_paid,
                   v.last_toll_date, v.monthly_pass_expiry, v.is_active as vehicle_active
            FROM User u
            LEFT JOIN vehicle v ON u.username = v.username AND v.is_active = true
            WHERE u.username = ?
        """;
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // User details
                UserModel user = new UserModel();
                user.setUsername(rs.getString("username"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setProvince(rs.getString("province"));
                user.setPostalCode(rs.getString("postal_code"));
                user.setCitizenshipNumber(rs.getString("citizenship_number"));
                user.setAccountType(rs.getString("account_type"));
                details.put("user", user);
                
                // Vehicle details (if any)
                if (rs.getString("vehicle_number") != null) {
                    Map<String, Object> vehicleDetails = new HashMap<>();
                    vehicleDetails.put("vehicleType", rs.getString("vehicle_type"));
                    vehicleDetails.put("vehicleNumber", rs.getString("vehicle_number"));
                    vehicleDetails.put("totalTollPaid", rs.getDouble("total_toll_paid"));
                    vehicleDetails.put("lastTollDate", rs.getTimestamp("last_toll_date"));
                    vehicleDetails.put("monthlyPassExpiry", rs.getDate("monthly_pass_expiry"));
                    vehicleDetails.put("isActive", rs.getBoolean("vehicle_active"));
                    details.put("vehicle", vehicleDetails);
                }
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return details;
    }

    public List<TollRateModel> getTollRates() {
        List<TollRateModel> tollRates = new ArrayList<>();
        String query = "SELECT * FROM toll_rates WHERE is_active = 1 ORDER BY vehicle_type";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                TollRateModel rate = new TollRateModel(
                    rs.getInt("rate_id"),
                    rs.getString("vehicle_type"),
                    rs.getDouble("single_pass_rate"),
                    rs.getDouble("monthly_pass_rate"),
                    rs.getString("description"),
                    rs.getBoolean("is_active")
                );
                tollRates.add(rate);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return tollRates;
    }
} 