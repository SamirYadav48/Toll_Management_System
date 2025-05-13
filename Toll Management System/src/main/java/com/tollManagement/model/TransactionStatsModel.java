package com.tollManagement.model;

public class TransactionStatsModel {
    private int totalTransactions;
    private double totalAmount;
    private double averageAmount;

    // Default constructor
    public TransactionStatsModel() {
        this.totalTransactions = 0;
        this.totalAmount = 0.0;
        this.averageAmount = 0.0;
    }

    // Constructor with all fields
    public TransactionStatsModel(int totalTransactions, double totalAmount, double averageAmount) {
        this.totalTransactions = totalTransactions;
        this.totalAmount = totalAmount;
        this.averageAmount = averageAmount;
    }

    public int getTotalTransactions() {
        return totalTransactions;
    }

    public void setTotalTransactions(int totalTransactions) {
        this.totalTransactions = totalTransactions;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getAverageAmount() {
        return averageAmount;
    }

    public void setAverageAmount(double averageAmount) {
        this.averageAmount = averageAmount;
    }
} 