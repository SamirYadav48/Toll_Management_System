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
        <form action="profile" method="post" class="profile-form">
            <input type="hidden" name="action" value="updateProfile">
            
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" value="${user.name}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="${user.phone}">
            </div>
            
            <div class="form-group">
                <label for="position">Position</label>
                <input type="text" id="position" name="position" value="${user.position}">
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