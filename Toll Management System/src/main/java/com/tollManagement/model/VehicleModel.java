package com.tollManagement.model;

import java.sql.Timestamp;
import java.util.Date;

public class VehicleModel {
    private int vehicleId;
    private String vehicleType;    // Type of vehicle (e.g., Car, Bus, Truck)
    private String vehicleNumber;  // Unique vehicle number (license plate)
    private String username;
    private String citizenshipNumber;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isActive;
    private Date lastTollDate;
    private double totalTollPaid;
    private Date monthlyPassExpiry;

    // Default constructor
    public VehicleModel() {
    }

    // Constructor for vehicle registration
    public VehicleModel(String vehicleType, String vehicleNumber, String username, String citizenshipNumber) {
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
        this.username = username;
        this.citizenshipNumber = citizenshipNumber;
        this.isActive = true;
    }

    // Full constructor
    public VehicleModel(int vehicleId, String vehicleType, String vehicleNumber, String username, 
                       String citizenshipNumber, Timestamp createdAt, Timestamp updatedAt, 
                       boolean isActive, Date lastTollDate, double totalTollPaid, Date monthlyPassExpiry) {
        this.vehicleId = vehicleId;
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
        this.username = username;
        this.citizenshipNumber = citizenshipNumber;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
        this.lastTollDate = lastTollDate;
        this.totalTollPaid = totalTollPaid;
        this.monthlyPassExpiry = monthlyPassExpiry;
    }

    // Getters and Setters
    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCitizenshipNumber() {
        return citizenshipNumber;
    }

    public void setCitizenshipNumber(String citizenshipNumber) {
        this.citizenshipNumber = citizenshipNumber;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Date getLastTollDate() {
        return lastTollDate;
    }

    public void setLastTollDate(Date lastTollDate) {
        this.lastTollDate = lastTollDate;
    }

    public double getTotalTollPaid() {
        return totalTollPaid;
    }

    public void setTotalTollPaid(double totalTollPaid) {
        this.totalTollPaid = totalTollPaid;
    }

    public Date getMonthlyPassExpiry() {
        return monthlyPassExpiry;
    }

    public void setMonthlyPassExpiry(Date monthlyPassExpiry) {
        this.monthlyPassExpiry = monthlyPassExpiry;
    }
}
