package com.tollManagement.model;

import java.sql.Timestamp;

public class TollBoothModel {
    private String boothId;
    private String location;
    private String status;       // Active, Inactive, Maintenance
    private String boothType;    // Standard, Express, etc.
    private String province;     // Province where the toll booth is located
    private double latitude;     // Latitude coordinate
    private double longitude;    // Longitude coordinate
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    private Timestamp lastActivity;     // Recent transaction time
    private int transactionsToday;      // Count of today's transactions
    private double revenueToday;        // Total revenue today

    // Constructors
    public TollBoothModel() {
    	
    }

    public TollBoothModel(String boothId, String location, String status, String boothType,
                     String province, double latitude, double longitude,
                     Timestamp lastActivity, Timestamp createdAt, Timestamp updatedAt, 
                     int transactionsToday, double revenueToday) {
        this.boothId = boothId;
        this.location = location;
        this.status = status;
        this.boothType = boothType;
        this.province = province;
        this.latitude = latitude;
        this.longitude = longitude;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.lastActivity = lastActivity;
        this.transactionsToday = transactionsToday;
        this.revenueToday = revenueToday;
    }

    // Getters and Setters
    public String getBoothId() {
        return boothId;
    }

    public void setBoothId(String boothId) {
        this.boothId = boothId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBoothType() {
        return boothType;
    }

    public void setBoothType(String boothType) {
        this.boothType = boothType;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public Timestamp getLastActivity() {
        return lastActivity;
    }

    public void setLastActivity(Timestamp lastActivity) {
        this.lastActivity = lastActivity;
    }

    public int getTransactionsToday() {
        return transactionsToday;
    }

    public void setTransactionsToday(int transactionsToday) {
        this.transactionsToday = transactionsToday;
    }

    public double getRevenueToday() {
        return revenueToday;
    }

    public void setRevenueToday(double revenueToday) {
        this.revenueToday = revenueToday;
    }
}

