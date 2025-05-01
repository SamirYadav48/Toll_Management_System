<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${user.name}'s Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert error">${error}</div>
        </c:if>

        <!-- Profile Update Form -->
        <form action="profile" method="post">
        <input type="hidden" name="action" value="updateProfile">
        
        <div class="form-group">
            <label>First Name:</label>
            <input type="text" name="firstName" value="${user.firstName}">
        </div>
        
        <div class="form-group">
            <label>Last Name:</label>
            <input type="text" name="lastName" value="${user.lastName}">
        </div>
        
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" value="${user.email}">
        </div>
        
        <div class="form-group">
            <label>Phone:</label>
            <input type="text" name="phone" value="${user.phone}">
        </div>
            
            <button type="submit" class="btn">Update Profile</button>
        </form>

        <!-- Password Change Form -->
        <form action="profile" method="post" class="password-form">
            <input type="hidden" name="action" value="changePassword">
            
            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required 
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}">
                <small>Must contain at least 8 characters with uppercase, lowercase and number</small>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            
            <button type="submit" class="btn">Change Password</button>
        </form>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/profile.js"></script>
</body>
</html>