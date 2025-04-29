<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/contact.css" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header>
        <div class="container">
            <nav>
                <!-- Logo on the left -->
                <div class="logo">
                
                <a href=""><img src="${pageContext.request.contextPath}/resources/logo.png" /></a>
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

<!-- Contact Hero Section -->
<section class="contact-hero">
    <div class="container">
        <h2>Get in Touch</h2>
        <p>Have questions about our toll management solutions? Our team is ready to help.</p>
    </div>
</section>

<!-- Contact Content -->
<section class="contact-section">
    <div class="container">
        <div class="contact-grid">
            <!-- Contact Form -->
            <div class="contact-form">
                <h3>Send us a Message</h3>
                <form>
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" placeholder="Enter your name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" placeholder="What's this about?">
                    </div>
                    <div class="form-group">
                        <label for="message">Your Message</label>
                        <textarea id="message" rows="5" placeholder="How can we help you?" required></textarea>
                    </div>
                    <button type="submit" class="btn-submit">Send Message</button>
                </form>
            </div>

            <!-- Contact Info -->
            <div class="contact-info">
                <h3>Contact Information</h3>
                <div class="info-card">
                    <div class="icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="details">
                        <h4>Headquarters</h4>
                        <p>PathPay Tower, Kathmandu 44600, Nepal</p>
                    </div>
                </div>
                <div class="info-card">
                    <div class="icon">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <div class="details">
                        <h4>Phone</h4>
                        <p>+977-1-1234567</p>
                        <p>+977-9801234567 (Support)</p>
                    </div>
                </div>
                <div class="info-card">
                    <div class="icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="details">
                        <h4>Email</h4>
                        <p>info@pathpay.com</p>
                        <p>support@pathpay.com</p>
                    </div>
                </div>
                <div class="info-card">
                    <div class="icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="details">
                        <h4>Business Hours</h4>
                        <p>Sunday-Friday: 9AM - 5PM</p>
                        <p>Support: 24/7</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Map Section
<section class="map-section">
    <div class="container">
        <h3>Our Location</h3>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.456715477961!2d85.32047031506205!3d27.70520938279391!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1908434cb1c9%3A0x1a3b6c5e345a9a8c!2sKathmandu%2044600%2C%20Nepal!5e0!3m2!1sen!2sus!4v1620000000000!5m2!1sen!2sus" 
                    width="100%" 
                    height="450" 
                    style="border:0;" 
                    allowfullscreen="" 
                    loading="lazy">
            </iframe>
        </div>
    </div>
</section> -->


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