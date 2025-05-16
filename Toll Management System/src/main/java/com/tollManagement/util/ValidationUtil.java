package com.tollManagement.util;

import java.util.regex.Pattern;


public class ValidationUtil {

    // 1. Validate if a field is null or empty
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // 2. Validate if a string contains only letters
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z]{2,30}$");
    }

    // 3. Validate username (alphanumeric with underscore, 4-20 chars)
    public static boolean isValidUsername(String username) {
        return username != null && username.matches("^[a-zA-Z0-9_]{4,20}$");
    }

    // 4. Validate email address
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // 5. Validate phone number (starts with 9, followed by 9 digits)
    public static boolean isValidPhoneNumber(String number) {
        return number != null && number.matches("^[9][0-9]{9}$");
    }
    
    // 6. Validate citizenship number (10 digits)
    public static boolean isValidCitizenshipNumber(String citizenshipNumber) {
        return citizenshipNumber != null && citizenshipNumber.matches("^[0-9]{10}$");
    }

    // 7. Validate password (at least 8 chars, must contain letters and numbers)
    public static boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");
    }

    // 8. Validate if passwords match
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    // 9. Validate vehicle number (2 letters followed by 4 numbers, e.g., BA0998)
    public static boolean isValidVehicleNumber(String vehicleNumber) {
        return vehicleNumber != null && vehicleNumber.matches("^[A-Z]{2}[0-9]{4}$");
    }

    // 10. Validate first name (2-30 letters)
    public static boolean isValidFirstName(String firstName) {
        return firstName != null && firstName.matches("^[a-zA-Z]{2,30}$");
    }

    // 11. Validate last name (2-30 letters)
    public static boolean isValidLastName(String lastName) {
        return lastName != null && lastName.matches("^[a-zA-Z]{2,30}$");
    }

    // 12. Validate account type
    public static boolean isValidAccountType(String accountType) {
        return accountType != null && 
               (accountType.equalsIgnoreCase("customer") || 
                accountType.equalsIgnoreCase("commercial") || 
                accountType.equalsIgnoreCase("admin"));
    }
}
