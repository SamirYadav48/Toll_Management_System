<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PathPay - Smart Toll Management</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/index.css"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
 <!-- Navigation Bar -->
    <header>
        <div class="container">
            <nav>
                <!-- Logo on the left -->
                <div class="logo">
                    <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo">
                    <h1>PathPay</h1>
                </div>
    
                <!-- Navigation + Auth buttons on the right -->
                <div class="nav-right">
                    <ul class="nav-links">
                        <li><a href="${pageContext.request.contextPath}/HomeController">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/AboutUsController">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/ContactController">Contact</a></li>
                    </ul>
                    <div class="auth-buttons">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-register">Register</a>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h2>Seamless Toll Management Solutions</h2>
                <p>Experience faster, smarter toll payments with our automated system. Save time and money on your journeys.</p>
                <a href="#" class="btn-primary">Get Started</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <div class="section-title">
                <h2>Why Choose PathPay?</h2>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3>Fast Payments</h3>
                    <p>No more waiting in long queues. Our RFID system processes payments instantly.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>Real-Time Analytics</h3>
                    <p>Track your toll expenses and get detailed reports for better budgeting.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-road"></i>
                    </div>
                    <h3>Nationwide Coverage</h3>
                    <p>Works across all major highways and toll plazas in the country.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="footer-col">
                        <h4>About PathPay</h4>
                        <ul>
                            <li><a href="#">Our Mission</a></li>
                            <li><a href="#">How PathPay Works</a></li>
                            <li><a href="#">Terms and Policies</a></li>
                            <li><a href="#">Meet the Team</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h4>Get help</h4>
                        <ul>
                            <li><a href="#">FAQs</a></li>
                            <li><a href="#">Toll Recharge Help</a></li>
                            <li><a href="#">Report an Issue</a></li>
                            <li><a href="#">Contact Support</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h4>PathPay Services</h4>
                        <ul>
                            <li><a href="#">Buy PathPay Card</a></li>
                            <li><a href="#">Recharge Online</a></li>
                            <li><a href="#">Transaction History</a></li>
                            <li><a href="#">Linked Vehicles</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h4>Follow us</h4>
                        <div class="social-link">
                            <a href="#"><i class="fab fa-facebook -f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>


            <div class="copyright">
                <p>&copy; 2023 PathPay Toll Management. All rights reserved.</p>
            </div>
    </footer>
</body>
</html>