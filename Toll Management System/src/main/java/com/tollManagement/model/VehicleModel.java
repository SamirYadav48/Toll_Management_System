package com.tollManagement.model;

public class VehicleModel {

    private String vehicleType;    // Type of vehicle (e.g., Car, Bus, Truck)
    private String vehicleNumber;  // Unique vehicle number (license plate)

    // Default constructor
    public VehicleModel() {
    	
    }

    // Constructor for vehicle registration
    public VehicleModel(String vehicleType, String vehicleNumber) {
    	super();
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
    }

    // Getters and Setters
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
}
