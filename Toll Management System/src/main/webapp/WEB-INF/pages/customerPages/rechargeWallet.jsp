<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recharge Wallet | Toll Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerPagesCss/rechargeWallet.css">
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
                    <li>
                        <a href="${pageContext.request.contextPath}/GetCardController">
                            <i class="fas fa-credit-card"></i>
                            <span>Get RFID Card</span>
                        </a>
                    </li>
                    <li class="active">
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
                <h2>Recharge Wallet</h2>
                <div class="wallet-balance">
                    <span>Current Balance:</span>
                    <span class="amount">NPR ${balance}</span>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert success">
                    <i class="fas fa-check-circle"></i>
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errorMessage}
                </div>
            </c:if>

            <div class="recharge-container">
                <div class="recharge-options">
                    <div class="quick-amounts">
                        <h3>Quick Recharge</h3>
                        <div class="amount-buttons">
                            <button class="amount-btn" data-amount="500">NPR 500</button>
                            <button class="amount-btn" data-amount="1000">NPR 1,000</button>
                            <button class="amount-btn" data-amount="2000">NPR 2,000</button>
                            <button class="amount-btn" data-amount="5000">NPR 5,000</button>
                        </div>
                    </div>

                    <div class="custom-amount">
                        <h3>Custom Amount</h3>
                        <div class="input-group">
                            <span class="input-prefix">NPR</span>
                            <input type="number" id="customAmount" placeholder="Enter amount" min="100" step="100">
                        </div>
                    </div>

                    <div class="payment-methods">
                        <h3>Payment Method</h3>
                        <div class="method-options">
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="ONLINE" checked>
                                <div class="option-content">
                                    <img src="${pageContext.request.contextPath}/resources/esewa-logo.png" alt="eSewa">
                                    <span>eSewa</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="ONLINE">
                                <div class="option-content">
                                    <img src="${pageContext.request.contextPath}/resources/khalti-logo.png" alt="Khalti">
                                    <span>Khalti</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="CARD">
                                <div class="option-content">
                                    <i class="fas fa-credit-card"></i>
                                    <span>Credit/Debit Card</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="ONLINE">
                                <div class="option-content">
                                    <img src="${pageContext.request.contextPath}/resources/connectips-logo.png" alt="Connect IPS">
                                    <span>Connect IPS</span>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="recharge-summary">
                    <div class="summary-card">
                        <h3>Recharge Summary</h3>
                        <div class="summary-details">
                            <div class="detail-row">
                                <span>Amount:</span>
                                <span id="summaryAmount">NPR 0</span>
                            </div>
                            <div class="detail-row">
                                <span>Payment Method:</span>
                                <span id="summaryMethod">Not selected</span>
                            </div>
                            <div class="detail-row fee">
                                <span>Service Fee:</span>
                                <span id="serviceFee">NPR 0</span>
                            </div>
                            <div class="detail-row total">
                                <span>Total:</span>
                                <span id="summaryTotal">NPR 0</span>
                            </div>
                        </div>
                        <button id="rechargeBtn" class="primary-btn" disabled>
                            <i class="fas fa-bolt"></i> Recharge Now
                        </button>
                    </div>
                </div>
            </div>
        </main>

        
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // DOM Elements
        const amountButtons = document.querySelectorAll('.amount-btn');
        const customAmountInput = document.getElementById('customAmount');
        const paymentMethodRadios = document.querySelectorAll('input[name="paymentMethod"]');
        const rechargeBtn = document.getElementById('rechargeBtn');
        
        // Summary elements
        const summaryAmount = document.getElementById('summaryAmount');
        const summaryMethod = document.getElementById('summaryMethod');
        const serviceFee = document.getElementById('serviceFee');
        const summaryTotal = document.getElementById('summaryTotal');
        
        // State
        let selectedAmount = 0;
        let selectedMethod = 'ONLINE';
        
        // Quick amount buttons
        amountButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                amountButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Set selected amount and update custom amount input
                selectedAmount = parseInt(this.dataset.amount);
                console.log('Quick Amount Selected:', selectedAmount);
                customAmountInput.value = selectedAmount;
                
                // Enable recharge button and update summary
                rechargeBtn.disabled = false;
                updateSummary();
            });
        });
        
        // Custom amount input
        customAmountInput.addEventListener('input', function() {
            // Remove active class from quick amount buttons
            amountButtons.forEach(btn => btn.classList.remove('active'));
            
            // Parse the input value and ensure it's a valid number
            selectedAmount = parseInt(this.value) || 0;
            console.log('Custom Amount Entered:', selectedAmount);
            
            // Enable/disable recharge button based on amount
            rechargeBtn.disabled = selectedAmount < 100; // Minimum amount of 100
            
            updateSummary();
        });
        
        // Payment method selection
        paymentMethodRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                selectedMethod = this.value;
                console.log('Payment Method Selected:', selectedMethod);
                updateSummary();
            });
        });
        
        // Update summary function
        function updateSummary() {
            console.log('Updating Summary - Amount:', selectedAmount);
            
            // Ensure selectedAmount is a number
            selectedAmount = Number(selectedAmount);
            
            if (selectedAmount > 0) {
                // Calculate service fee (2% for all payment methods)
                let fee = Math.round(selectedAmount * 0.02);
                const total = selectedAmount + fee;
                
                console.log('Calculated Total:', total);
                
                // Format payment method text for display
                let methodText = '';
                switch(selectedMethod) {
                    case 'ONLINE':
                        methodText = document.querySelector('input[name="paymentMethod"]:checked').closest('.method-option').querySelector('span').textContent;
                        break;
                    case 'CARD':
                        methodText = 'Credit/Debit Card';
                        break;
                    default:
                        methodText = 'Not selected';
                }
                
                // Update summary display with formatted numbers
                summaryAmount.textContent = `NPR ${selectedAmount.toLocaleString()}`;
                summaryMethod.textContent = methodText;
                serviceFee.textContent = `NPR ${fee.toLocaleString()}`;
                summaryTotal.textContent = `NPR ${total.toLocaleString()}`;
                
                // Enable recharge button if amount is valid
                rechargeBtn.disabled = selectedAmount < 100;
            } else {
                // Reset summary display
                summaryAmount.textContent = 'NPR 0';
                summaryMethod.textContent = 'Not selected';
                serviceFee.textContent = 'NPR 0';
                summaryTotal.textContent = 'NPR 0';
                
                // Disable recharge button
                rechargeBtn.disabled = true;
            }
        }
        
        // Initialize with default values
        selectedMethod = 'ONLINE'; // Set default payment method
        document.querySelector('input[name="paymentMethod"][value="ONLINE"]').checked = true;
        updateSummary();
        
        // Handle recharge button click
        rechargeBtn.addEventListener('click', function() {
            const amount = parseInt(customAmountInput.value) || selectedAmount;
            console.log('Recharge Button Clicked - Amount:', amount);
            
            if (amount >= 100) { // Minimum amount check
                console.log('Initiating recharge process...');
                console.log('Amount:', amount);
                console.log('Payment Method:', selectedMethod);
                
                // Create URL-encoded form data
                const formData = new URLSearchParams();
                formData.append('amount', amount.toString());
                formData.append('paymentMethod', selectedMethod);
                formData.append('status', 'SUCCESS'); // Add status field with SUCCESS value
                
                console.log('Form data being sent:', formData.toString());
                
                // Submit form
                fetch('${pageContext.request.contextPath}/RechargeWalletController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: formData.toString()
                })
                .then(response => {
                    console.log('Server response:', response);
                    if (response.redirected) {
                        console.log('Redirecting to:', response.url);
                        window.location.href = response.url;
                    } else {
                        return response.text().then(text => {
                            console.log('Response text:', text);
                            if (text.includes('success')) {
                                window.location.reload();
                            } else {
                                const errorMsg = text.includes('error=') ? 
                                    decodeURIComponent(text.split('error=')[1]) : 
                                    'Failed to recharge wallet. Please try again.';
                                console.error('Error message:', errorMsg);
                                alert(errorMsg);
                            }
                        });
                    }
                })
                .catch(error => {
                    console.error('Network error:', error);
                    alert('Network error occurred. Please check your connection and try again.');
                });
            } else {
                alert('Please enter an amount of at least NPR 100');
            }
        });
    });
    </script>
</body>
</html>