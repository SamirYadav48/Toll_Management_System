<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/aboutUs.css" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
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
    <div class="container">
        <!-- Header Section -->
        <header class="header-section">
            <h1>About <span class="highlight">PathPay</span></h1>
            <p class="subtitle">Streamlining Toll Management with Precision and Ease</p>
        </header>

        <!-- Hero Image Placeholder -->
        <div class="image-placeholder">
            <img src="/chapter 1/hero page.com" alt="PathPay System Overview">
            <p class="image-caption"><!-- Replace with your caption --></p>
        </div>

        <!-- Who We Are Section -->
        <section class="section">
            <h2>Who We Are</h2>
            <p>PathPay is a cutting-edge <strong>toll management system</strong> designed to simplify 
                and automate toll collection, monitoring, and revenue management. Our mission is to provide 
                <strong>efficient, secure, and scalable solutions</strong> for toll operators, governments, and 
                transportation authorities.</p>
            <p>With advanced technology and a user-centric approach, we ensure seamless transactions, reduced 
                congestion, and enhanced accountability in toll operations.</p>
        </section>

        <!-- Technology Image Placeholder -->
        <div class="image-placeholder">
            <img src="assets/technology.jpg" alt="PathPay Technology">
            <p class="image-caption"><!-- Replace with your caption --></p>
        </div>

        <!-- Why Choose PathPay? Section -->
        <section class="section">
            <h2>Why Choose PathPay?</h2>
            <ul class="features">
                <li>✅ <strong>Smart Toll Collection</strong> – Automated, contactless payments for faster processing.</li>
                <li>✅ <strong>Real-Time Analytics</strong> – Track transactions, traffic flow, and revenue in real time.</li>
                <li>✅ <strong>Fraud Prevention</strong> – AI-powered detection to minimize revenue leakage.</li>
                <li>✅ <strong>Scalable Infrastructure</strong> – Adaptable for highways, bridges, and urban toll networks.</li>
                <li>✅ <strong>24/7 Support</strong> – Dedicated assistance to ensure smooth operations.</li>
            </ul>
        </section>

        <!-- Dashboard Image Placeholder -->
        <div class="image-placeholder">
            <img src="/chapter 1/dashboard image.png" alt="PathPay Dashboard">
            <p class="image-caption"><!-- Replace with your caption --></p>
        </div>

        <!-- Our Vision Section -->
        <section class="section">
            <h2>Our Vision</h2>
            <p>We envision a future where toll management is <strong>fully integrated, transparent, and hassle-free</strong>. By leveraging the latest advancements in <strong>IoT, AI, and cloud computing</strong>, PathPay is setting new standards in the transportation industry.</p>
            <p>Join us in revolutionizing toll collection—<strong>smarter, faster, and more reliable.</strong></p>
        </section>

        <!-- Future Image Placeholder -->
        <div class="image-placeholder">
            <img src="/chapter 1/future plan.png" alt="PathPay Future">
            <p class="image-caption"><!-- Replace with your caption --></p>
        </div>
    </div>

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