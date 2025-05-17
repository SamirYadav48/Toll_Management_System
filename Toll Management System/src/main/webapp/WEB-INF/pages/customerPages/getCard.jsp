<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!-- Header -->
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
                <h1>PathPay</h1>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search transactions...">
                    <i class="fas fa-search"></i>
                </div>
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CustomerSettingsController" class="user-name-link">
                        <span class="user-name">${user.firstName} ${user.lastName}</span>
                    </a>
                    <div class="user-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </header>

        <aside class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/CustomerDashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/PaymentHistoryController">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>Payment History</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/TollLocationsController">
                            <i class="fas fa-map-marked-alt"></i>
                            <span>Toll Locations</span>
                        </a>
                    </li>
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/GetCardController">
                            <i class="fas fa-credit-card"></i>
                            <span>Get RFID Card</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/RechargeWalletController">
                            <i class="fas fa-wallet"></i>
                            <span>Recharge Wallet</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/CustomerSettingsController">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/HelpController">
                            <i class="fas fa-question-circle"></i>
                            <span>Help</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-header">
                <h2>Get RFID Card</h2>
                <div class="card-status">
                    <c:choose>
                        <c:when test="${not empty activeCard}">
                            <span class="status-badge active">Active Card</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge inactive">No Active Card</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <div class="card-container">
                <c:choose>
                    <c:when test="${not empty activeCard}">
                        <!-- Display active card information -->
                        <div class="card-info">
                            <div class="card-visual">
                                <div class="rfid-card">
                                    <div class="card-chip"></div>
                                    <div class="card-logo">TollPay</div>
                                    <div class="card-number">${activeCard.card_number}</div>
                                    <div class="card-user">${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}</div>
                                </div>
                                <div class="card-details">
                                    <h3>Card Details</h3>
                                    <p><strong>Type:</strong> ${activeCard.card_type}</p>
                                    <p><strong>Status:</strong> ${activeCard.status}</p>
                                    <p><strong>Balance:</strong> NPR ${activeCard.balance}</p>
                                    <p><strong>Issued On:</strong> ${activeCard.issue_date}</p>
                                    <p><strong>Expires On:</strong> ${activeCard.expiry_date}</p>
                                    <p><strong>Linked Vehicle:</strong> ${activeCard.vehicle_number}</p>
                                    <button class="primary-btn" onclick="window.location.href='${pageContext.request.contextPath}/RFIDTransactionsController?cardId=${activeCard.card_id}'">
                                        View Transaction History
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Display card registration form -->
                        <div class="card-info">
                            <div class="card-visual">
                                <div class="rfid-card">
                                    <div class="card-chip"></div>
                                    <div class="card-logo">TollPay</div>
                                    <div class="card-number">•••• •••• •••• ••••</div>
                                    <div class="card-user">${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}</div>
                                </div>
                                <div class="card-illustration">
                                    <img src="${pageContext.request.contextPath}/resources/rfid-illustration.png" alt="RFID Card Illustration">
                                </div>
                            </div>

                            <div class="card-form">
                                <form id="cardRegistrationForm" action="${pageContext.request.contextPath}/GetCardController" method="POST">
                                    <div class="form-group">
                                        <label for="vehicle">Select Vehicle</label>
                                        <select id="vehicle" name="vehicleId" required>
                                            <option value="">-- Select Vehicle --</option>
                                            <c:forEach items="${userVehicles}" var="vehicle">
                                                <c:if test="${empty vehicle.rfid_card_id}">
                                                    <option value="${vehicle.vehicle_id}">
                                                        ${vehicle.vehicle_number} (${vehicle.vehicle_type})
                                                    </option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="cardType">Card Type</label>
                                        <div class="card-options">
                                            <label class="card-option">
                                                <input type="radio" name="cardType" value="STANDARD" checked>
                                                <div class="option-content">
                                                    <i class="fas fa-id-card"></i>
                                                    <span>Standard Card (NPR 200)</span>
                                                </div>
                                            </label>
                                            <label class="card-option">
                                                <input type="radio" name="cardType" value="PREMIUM">
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
                                                <input type="radio" name="deliveryMethod" value="PICKUP" checked>
                                                <div class="option-content">
                                                    <i class="fas fa-store"></i>
                                                    <span>Pickup at Nearest Center</span>
                                                </div>
                                            </label>
                                            <label class="delivery-option">
                                                <input type="radio" name="deliveryMethod" value="HOME_DELIVERY">
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
                                        <button type="button" class="cancel-btn" onclick="window.location.href='${pageContext.request.contextPath}/CustomerDashboard'">Cancel</button>
                                        <button type="submit" class="primary-btn">Proceed to Payment</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

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
        // Only run price calculations if we're on the registration form
        if (document.getElementById('cardRegistrationForm')) {
            // Update prices based on selections
            const cardTypeRadios = document.querySelectorAll('input[name="cardType"]');
            const deliveryRadios = document.querySelectorAll('input[name="deliveryMethod"]');
            const cardPriceElement = document.getElementById('cardPrice');
            const deliveryFeeElement = document.getElementById('deliveryFee');
            const totalPriceElement = document.getElementById('totalPrice');

            function updatePrices() {
                const cardType = document.querySelector('input[name="cardType"]:checked').value;
                const deliveryMethod = document.querySelector('input[name="deliveryMethod"]:checked').value;
                
                let cardPrice = 200;
                if (cardType === 'PREMIUM') {
                    cardPrice = 500;
                }
                
                let deliveryFee = 0;
                if (deliveryMethod === 'HOME_DELIVERY') {
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

            // Initialize prices
            updatePrices();
        }
    });
    </script>
</body>
</html>