<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get RFID Card | Toll Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/getCard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Header (Same as other pages) -->
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

        <!-- Sidebar (Same as other pages) -->
        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/CustomerDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/PaymentHistoryController"><i class="fas fa-money-bill-wave"></i> Payment History</a></li>
                    <li><a href="${pageContext.request.contextPath}/TollLocationsController"><i class="fas fa-map-marked-alt"></i> Toll Locations</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>                    
                    <li><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-header">
                <h2>Get RFID Card</h2>
                <div class="card-status">
                    <span class="status-badge inactive">No Active Card</span>
                </div>
            </div>

            <div class="card-container">
                <div class="card-info">
                    <div class="card-visual">
                        <div class="rfid-card">
                            <div class="card-chip"></div>
                            <div class="card-logo">TollPay</div>
                            <div class="card-number">•••• •••• •••• ••••</div>
                            <div class="card-user">BINA KARKI</div>
                        </div>
                        <div class="card-illustration">
                            <img src="${pageContext.request.contextPath}/resources/rfid-illustration.png" alt="RFID Card Illustration">
                        </div>
                    </div>

                    <div class="card-form">
                        <form id="cardRegistrationForm">
                            <div class="form-group">
                                <label for="vehicle">Select Vehicle</label>
                                <select id="vehicle" required>
                                    <option value="">-- Select Vehicle --</option>
                                    <option value="1">Ba 1 Cha 1234 (Car)</option>
                                    <option value="2">Ba 5 Pa 5678 (Motorcycle)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="cardType">Card Type</label>
                                <div class="card-options">
                                    <label class="card-option">
                                        <input type="radio" name="cardType" value="standard" checked>
                                        <div class="option-content">
                                            <i class="fas fa-id-card"></i>
                                            <span>Standard Card (NPR 200)</span>
                                        </div>
                                    </label>
                                    <label class="card-option">
                                        <input type="radio" name="cardType" value="premium">
                                        <div class="option-content">
                                            <i class="fas fa-id-card-alt"></i>
                                            <span>Premium Card (NPR 500)</span>
                                        </div>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="delivery">Delivery Method</label>
                                <div class="delivery-options">
                                    <label class="delivery-option">
                                        <input type="radio" name="delivery" value="pickup" checked>
                                        <div class="option-content">
                                            <i class="fas fa-store"></i>
                                            <span>Pickup at Nearest Center</span>
                                        </div>
                                    </label>
                                    <label class="delivery-option">
                                        <input type="radio" name="delivery" value="home">
                                        <div class="option-content">
                                            <i class="fas fa-truck"></i>
                                            <span>Home Delivery (+NPR 100)</span>
                                        </div>
                                    </label>
                                </div>
                            </div>

                            <div class="price-summary">
                                <div class="price-row">
                                    <span>Card Price</span>
                                    <span id="cardPrice">NPR 200</span>
                                </div>
                                <div class="price-row">
                                    <span>Delivery Fee</span>
                                    <span id="deliveryFee">NPR 0</span>
                                </div>
                                <div class="price-row total">
                                    <span>Total</span>
                                    <span id="totalPrice">NPR 200</span>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="cancel-btn">Cancel</button>
                                <button type="submit" class="primary-btn">Proceed to Payment</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card-benefits">
                    <h3>Benefits of RFID Card</h3>
                    <ul>
                        <li><i class="fas fa-bolt"></i> Instant toll payments without stopping</li>
                        <li><i class="fas fa-percentage"></i> 5% discount on all toll payments</li>
                        <li><i class="fas fa-history"></i> Detailed payment history</li>
                        <li><i class="fas fa-rupee-sign"></i> Balance auto-recharge options</li>
                        <li><i class="fas fa-shield-alt"></i> Secure and contactless</li>
                    </ul>
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
        // Update prices based on selections
        const cardTypeRadios = document.querySelectorAll('input[name="cardType"]');
        const deliveryRadios = document.querySelectorAll('input[name="delivery"]');
        const cardPriceElement = document.getElementById('cardPrice');
        const deliveryFeeElement = document.getElementById('deliveryFee');
        const totalPriceElement = document.getElementById('totalPrice');

        function updatePrices() {
            const cardType = document.querySelector('input[name="cardType"]:checked').value;
            const deliveryMethod = document.querySelector('input[name="delivery"]:checked').value;
            
            let cardPrice = 200;
            if (cardType === 'premium') {
                cardPrice = 500;
            }
            
            let deliveryFee = 0;
            if (deliveryMethod === 'home') {
                deliveryFee = 100;
            }
            
            const total = cardPrice + deliveryFee;
            
            cardPriceElement.textContent = `NPR ${cardPrice}`;
            deliveryFeeElement.textContent = `NPR ${deliveryFee}`;
            totalPriceElement.textContent = `NPR ${total}`;
        }

        cardTypeRadios.forEach(radio => {
            radio.addEventListener('change', updatePrices);
        });

        deliveryRadios.forEach(radio => {
            radio.addEventListener('change', updatePrices);
        });

        // Form submission
        const cardForm = document.getElementById('cardRegistrationForm');
        cardForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const vehicle = document.getElementById('vehicle').value;
            if (!vehicle) {
                alert('Please select a vehicle');
                return;
            }
            
            // In a real app, this would process the payment
            alert('Redirecting to payment gateway...');
            
            // Simulate successful payment
            setTimeout(() => {
                document.querySelector('.status-badge').textContent = 'Active';
                document.querySelector('.status-badge').classList.remove('inactive');
                document.querySelector('.status-badge').classList.add('active');
                document.querySelector('.card-number').textContent = '1234 5678 9012 3456';
                alert('Card registration successful! Your RFID card will be delivered soon.');
            }, 1500);
        });

        // Cancel button
        document.querySelector('.cancel-btn').addEventListener('click', function() {
            if (confirm('Are you sure you want to cancel card registration?')) {
                window.location.href = '${pageContext.request.contextPath}/CustomerDashboard';
            }
        });
    });
    </script>
</body>
</html>