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
        <header class="dashboard-header">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="PathPay Logo" class="logo">
                <h1>PathPay</h1>
            </div>
            <div class="header-right">
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
                            <span class="status-badge active">
                                Active Card: ${activeCard.cardNumber}
                            </span>
                        </c:when>
                        <c:when test="${not empty pendingCard}">
                            <span class="status-badge pending">
                                Pending Card Request: ${pendingCard.cardNumber}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge inactive">
                                No Active Card
                            </span>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- Add error message if there's a pending card -->
                    <c:if test="${not empty pendingCard}">
                        <div class="status-message">
                            You have a pending card request. Please wait for your current request to be processed.
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="messages">
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>
            </div>

            <div class="card-container">
                <div class="card-info">
                    <div class="card-visual">
                        <div class="rfid-card">
                            <div class="card-chip"></div>
                            <div class="card-logo">TollPay</div>
                            <div class="card-number">•••• •••• •••• ••••</div>
                            <div class="card-user">${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}</div>
                        </div>
                        
                    </div>

                    <div class="card-form">
                        <form id="cardRegistrationForm" action="${pageContext.request.contextPath}/GetCardController" method="POST">
                            <div class="form-group">
                                <label for="vehicle">Select Vehicle</label>
                                <select id="vehicle" name="vehicle" required>
                                    <option value="">-- Select Vehicle --</option>
                                    <c:forEach items="${vehicles}" var="vehicle">
                                        <option value="${vehicle.number}" 
                                                <c:if test="${vehicle.number == selectedVehicle}">selected</c:if>>
                                            ${vehicle.number} (${vehicle.type})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="cardType">Card Type</label>
                                <div class="card-options">
                                    <c:forEach items="${cardTypes}" var="cardType">
                                        <label class="card-option">
                                            <input type="radio" name="cardType" value="${cardType.id}" 
                                                   <c:if test="${cardType.id == selectedCardType}">checked</c:if>>
                                            <div class="option-content">
                                                <i class="fas fa-${cardType.id == 'standard' ? 'id-card' : 'id-card-alt'}"></i>
                                                <span>${cardType.name} (NPR ${cardType.price})</span>
                                            </div>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="delivery">Delivery Method</label>
                                <div class="delivery-options">
                                    <label class="delivery-option">
                                        <input type="radio" name="delivery" value="pickup" 
                                               <c:if test="${selectedDelivery == 'pickup'}">checked</c:if>>
                                        <div class="option-content">
                                            <i class="fas fa-store"></i>
                                            <span>Pickup at Nearest Center</span>
                                        </div>
                                    </label>
                                    <label class="delivery-option">
                                        <input type="radio" name="delivery" value="home" 
                                               <c:if test="${selectedDelivery == 'home'}">checked</c:if>>
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

        // Initialize prices
        updatePrices();

        // Add event listeners for price updates
        cardTypeRadios.forEach(radio => {
            radio.addEventListener('change', updatePrices);
        });

        deliveryRadios.forEach(radio => {
            radio.addEventListener('change', updatePrices);
        });

        // Show success/error messages
        const success = '${success}';
        const error = '${error}';

        if (success) {
            const successMsg = document.getElementById('successMsg');
            if (successMsg) {
                successMsg.textContent = success;
                successMsg.style.display = 'block';
                
                // If we have a card number, show it prominently
                const cardNumber = '${cardNumber}';
                if (cardNumber) {
                    const cardNumberElement = document.createElement('div');
                    cardNumberElement.className = 'card-number-info';
                    cardNumberElement.innerHTML = `<strong>Your Card Number:</strong> ${cardNumber}`;
                    successMsg.appendChild(cardNumberElement);
                }
            }
        }

        if (error) {
            const errorMsg = document.getElementById('errorMsg');
            if (errorMsg) {
                errorMsg.textContent = error;
                errorMsg.style.display = 'block';
            }
        }
    });
    </script>
</body>
</html>