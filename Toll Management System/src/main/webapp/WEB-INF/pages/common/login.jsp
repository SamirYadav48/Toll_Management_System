<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/login.css" />
</head>
<body 
style="background-image: url('${pageContext.request.contextPath}/resources/login-background.jpg'); 
background-size: cover; 
background-position: center; 
display: flex; 
justify-content: center; 
align-items: center; 
min-height: 100vh;">

    <!-- Login Form -->
    <div class="wrapper">
        <form action="${pageContext.request.contextPath}/login" method="post">
            <h1>Login</h1>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <div class="input-box">
                <input type="text" name="username" placeholder="Username" required>
                <i class='bx bxs-user'></i>
            </div>

            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>

            <div class="remember-forget">
                <label><input type="checkbox" name="rememberMe"> Remember me</label>
                <a href="#">Forgot password?</a>
            </div>

            <button type="submit" class="btn">Login</button>

            <div class="register-link">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>
            </div>
        </form>
    </div>

</body>
</html>
