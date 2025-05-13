package com.tollManagement.model;

public class TollRateModel {
    private int rateId;
    private String vehicleType;
    private double singlePassRate;
    private double monthlyPassRate;
    private String description;
    private boolean isActive;

    // Default constructor
    public TollRateModel() {
    }

    // Constructor with all fields
    public TollRateModel(int rateId, String vehicleType, double singlePassRate, double monthlyPassRate, String description, boolean isActive) {
        this.rateId = rateId;
        this.vehicleType = vehicleType;
        this.singlePassRate = singlePassRate;
        this.monthlyPassRate = monthlyPassRate;
        this.description = description;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public double getSinglePassRate() {
        return singlePassRate;
    }

    public void setSinglePassRate(double singlePassRate) {
        this.singlePassRate = singlePassRate;
    }

    public double getMonthlyPassRate() {
        return monthlyPassRate;
    }

    public void setMonthlyPassRate(double monthlyPassRate) {
        this.monthlyPassRate = monthlyPassRate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
} 