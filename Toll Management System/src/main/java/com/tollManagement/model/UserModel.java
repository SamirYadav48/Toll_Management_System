package com.tollManagement.model;

import java.time.LocalDateTime;
import com.tollManagement.util.*;

/**
 * Represents a user in the Toll Management System.
 */
public class UserModel {

    // Fields
    private String username;
    private String password;
    private String accountType;

    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String province;
    private String postalCode;
    private String citizenshipNumber;

    private boolean isActive;
    private int failedLoginAttempts;
    private LocalDateTime lastLogin;
    private LocalDateTime accountCreated;

    // Vehicle details
    private String vehicleType;
    private String vehicleNumber;

   

    // Constructors

    // Default constructor
    public UserModel() {
        this.accountCreated = LocalDateTime.now();
        this.isActive = true;
    }

    // Constructor for login (username and password)
    public UserModel(String username, String password) {
        this();
        this.username = username;
        this.password = password;
    }

    // Constructor for basic registration
    public UserModel(String username, String password, String accountType) {
        this(username, password);
        this.accountType = accountType;
    }

    // Constructor with full registration details
    public UserModel(String username, String password, String accountType, 
                     String firstName, String lastName, String email, 
                     String phone, String province, String postalCode, 
                     String vehicleType, String vehicleNumber, String citizenshipNumber) {
        this(username, password, accountType);
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.province = province;
        this.postalCode = postalCode;
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
        this.citizenshipNumber = citizenshipNumber;
    }

    // Constructor with key info (used in list view, search, etc.)
    public UserModel(String username, String accountType, String email, String phone, String citizenshipNumber) {
        this();
        this.username = username;
        this.accountType = accountType;
        this.email = email;
        this.phone = phone;
        this.citizenshipNumber = citizenshipNumber;
    }

    // Login/Security Methods
    public void resetFailedAttempts() {
        this.failedLoginAttempts = 0;
    }

    public void recordSuccessfulLogin() {
        this.lastLogin = LocalDateTime.now();
        this.resetFailedAttempts();
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getFailedLoginAttempts() {
        return failedLoginAttempts;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public LocalDateTime getAccountCreated() {
        return accountCreated;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    // Getter and Setter for Citizenship Number
    public String getCitizenshipNumber() {
        return citizenshipNumber;
    }

    public void setCitizenshipNumber(String citizenshipNumber) {
        this.citizenshipNumber = citizenshipNumber;
    }
}
