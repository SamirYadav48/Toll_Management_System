package com.tollManagement.model;

import java.sql.Timestamp;

public class TransactionModel {
    private int transactionId;
    private String vehicleNo;
    private String boothId;
    private Timestamp transactionDate;
    private double amount;
    private String paymentMode;

    // Default constructor
    public TransactionModel() {
        // This constructor can be used to create an empty object.
    }

    // Constructor with parameters
    public TransactionModel(String vehicleNo, String boothId, double amount, String paymentMode) {
        this.vehicleNo = vehicleNo;
        this.boothId = boothId;
        this.amount = amount;
        this.paymentMode = paymentMode;
    }

    // Constructor with all fields (including transactionId)
    public TransactionModel(int transactionId, String vehicleNo, String boothId, Timestamp transactionDate, double amount, String paymentMode) {
        this.transactionId = transactionId;
        this.vehicleNo = vehicleNo;
        this.boothId = boothId;
        this.transactionDate = transactionDate;
        this.amount = amount;
        this.paymentMode = paymentMode;
    }

    // Getters and Setters
    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getVehicleNo() {
        return vehicleNo;
    }

    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }

    public String getBoothId() {
        return boothId;
    }

    public void setBoothId(String boothId) {
        this.boothId = boothId;
    }

    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }
}
