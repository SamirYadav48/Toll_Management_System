package com.tollManagement.model;

import java.sql.Timestamp;

public class RFIDCardModel {
    private int cardId;
    private String cardNumber;
    private String username;
    private String vehicleNumber;
    private String cardType; // STANDARD or PREMIUM
    private String status; // ACTIVE, INACTIVE, PENDING
    private double balance;
    private Timestamp issueDate;
    private Timestamp expiryDate;
    private boolean isActive;

    // Default constructor
    public RFIDCardModel() {
    }

    // Constructor with all fields
    public RFIDCardModel(int cardId, String cardNumber, String username, String vehicleNumber, 
                        String cardType, String status, double balance, 
                        Timestamp issueDate, Timestamp expiryDate, boolean isActive) {
        this.cardId = cardId;
        this.cardNumber = cardNumber;
        this.username = username;
        this.vehicleNumber = vehicleNumber;
        this.cardType = cardType;
        this.status = status;
        this.balance = balance;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Timestamp getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }

    public Timestamp getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Timestamp expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
} 