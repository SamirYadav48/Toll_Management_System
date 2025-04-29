package com.tollManagement.util;

import java.util.regex.Pattern;


public class ValidationUtil {

    // 1. Validate if a field is null or empty
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // 2. Validate if a string contains only letters
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z]+$");
    }

    // 3. Validate if a string starts with a letter and is composed of letters and numbers
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    // 4. Validate if a string is a valid email address
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // 5. Validate if a number is of 10 digits and starts with 98
    public static boolean isValidPhoneNumber(String number) {
        return number != null && number.matches("^98\\d{8}$");
    }
    
    public static boolean isValidCitizenshipNumber(String citizenshipNumber) {
        // Regular expression: Starts with 3 digits (district code), a dash, followed by 9 digits
        String regex = "^[0-9]{3}-[0-9]{9}$";
        return citizenshipNumber.matches(regex);
    }

    // 6. Validate if a password is composed of at least 1 capital letter, 1 number, and 1 symbol
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    // 7. Validate if the password and retype password match
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    // 8. Validate if a string contains a valid vehicle number (assuming alphanumeric)
    public static boolean isValidVehicleNumber(String vehicleNumber) {
        return vehicleNumber != null && vehicleNumber.matches("^[a-zA-Z0-9]+$");
    }

    // 9. Validate if the province is valid (example: length should be at least 3 characters)
    public static boolean isValidProvince(String province) {
        return province != null && province.length() >= 3;
    }

    // 10. Validate if the postal code is valid (alphanumeric in this case, modify pattern if needed)
    public static boolean isValidPostalCode(String postalCode) {
        return postalCode != null && postalCode.matches("^[A-Za-z0-9]+$");
    }

    // 11. Validate if the first name contains only alphabetic characters
    public static boolean isValidFirstName(String firstName) {
        return firstName != null && firstName.matches("^[a-zA-Z]+$");
    }

    // 12. Validate if the last name contains only alphabetic characters
    public static boolean isValidLastName(String lastName) {
        return lastName != null && lastName.matches("^[a-zA-Z]+$");
    }
}
