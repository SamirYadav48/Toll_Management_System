<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toll Management System - Help Center</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/help.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Nepal Toll System Logo" class="logo">
                <h1>Toll Management System</h1>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CustomerSettingsController" class="user-name-link">
                        <span class="user-name">Bina Karki</span>
                    </a>
                    <img src="user-avatar.jpg" alt="User Avatar" class="user-avatar">
                </div>
            </div>
        </header>

        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/CustomerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
                    <li><a href="${pageContext.request.contextPath}/TollLocationsController"><i class="fas fa-map-marked-alt"></i> Toll Locations</a></li>
                    <li><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>                    
                    <li><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <h2>Help Center</h2>
                <div class="search-help">
                    <input type="text" placeholder="Search help articles...">
                    <button><i class="fas fa-search"></i></button>
                </div>
            </div>

            <div class="help-container">
                <div class="help-categories">
                    <div class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-wallet"></i>
                        </div>
                        <h3>Payments & Billing</h3>
                        <p>Questions about toll payments, invoices, and account balance</p>
                        <a href="#" class="view-articles">View Articles <i class="fas fa-chevron-right"></i></a>
                    </div>
                    
                    <div class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <h3>Vehicle Management</h3>
                        <p>How to add, remove or update your registered vehicles</p>
                        <a href="#" class="view-articles">View Articles <i class="fas fa-chevron-right"></i></a>
                    </div>
                    
                    <div class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-road"></i>
                        </div>
                        <h3>Toll Passes</h3>
                        <p>Information about toll rates, passes and routes</p>
                        <a href="#" class="view-articles">View Articles <i class="fas fa-chevron-right"></i></a>
                    </div>
                    
                    <div class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Account Help</h3>
                        <p>Managing your profile, password and security settings</p>
                        <a href="#" class="view-articles">View Articles <i class="fas fa-chevron-right"></i></a>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-accordion">
                        <div class="faq-item">
                            <button class="faq-question">
                                How do I add a new vehicle to my account?
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="faq-answer">
                                <p>To add a new vehicle, go to your Dashboard and click on "Manage Vehicles". From there, click "Add New Vehicle" and enter your vehicle details including license plate number and vehicle type.</p>
                            </div>
                        </div>
                        <!-- More FAQ items would go here -->
                    </div>
                </div>

                <div class="contact-support">
                    <h3>Still Need Help?</h3>
                    <div class="contact-options">
                        <div class="contact-option">
                            <i class="fas fa-phone-alt"></i>
                            <h4>Call Us</h4>
                            <p>+977-1-4234567</p>
                            <p>9AM - 5PM, Sunday to Friday</p>
                        </div>
                        <div class="contact-option">
                            <i class="fas fa-envelope"></i>
                            <h4>Email Us</h4>
                            <p>support@tollmanagement.gov.np</p>
                            <p>Response within 24 hours</p>
                        </div>
                        <div class="contact-option">
                            <i class="fas fa-comment-dots"></i>
                            <h4>Live Chat</h4>
                            <p>Available 9AM - 5PM</p>
                            <button class="chat-btn">Start Chat</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="dashboard-footer">
            <p>&copy; 2025 Nepal Toll Management System. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Contact Us</a>
            </div>
        </footer>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // FAQ accordion functionality
        const faqQuestions = document.querySelectorAll('.faq-question');
        faqQuestions.forEach(question => {
            question.addEventListener('click', function() {
                this.classList.toggle('active');
                const answer = this.nextElementSibling;
                if (this.classList.contains('active')) {
                    answer.style.maxHeight = answer.scrollHeight + 'px';
                } else {
                    answer.style.maxHeight = '0';
                }
                
                // Close other open FAQs
                faqQuestions.forEach(q => {
                    if (q !== question && q.classList.contains('active')) {
                        q.classList.remove('active');
                        q.nextElementSibling.style.maxHeight = '0';
                    }
                });
            });
        });

        // Search functionality
        const searchInput = document.querySelector('.search-help input');
        const searchButton = document.querySelector('.search-help button');
        
        function performSearch() {
            const searchTerm = searchInput.value.toLowerCase();
            if (searchTerm.trim() === '') return;
            
            // In a real app, this would search through articles
            alert('Searching for: ' + searchTerm);
        }
        
        searchButton.addEventListener('click', performSearch);
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });

        // Contact option hover effects
        document.querySelectorAll('.contact-option').forEach(option => {
            option.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });
            option.addEventListener('mouseleave', function() {
                this.style.transform = 'none';
            });
        });

        // Live chat button
        document.querySelector('.chat-btn')?.addEventListener('click', function() {
            alert('Connecting you to a customer support representative...');
        });
    });
    </script>
</body>
</html>