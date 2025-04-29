<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    <li><a href="${pageContext.request.contextPath}/GetCardController"><i class="fas fa-credit-card"></i> Get RFID Card</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/RechargeWalletController"><i class="fas fa-wallet"></i> Recharge Wallet</a></li>
                    <li><a href="${pageContext.request.contextPath}/CustomerSettingsController"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="${pageContext.request.contextPath}/HelpController"><i class="fas fa-question-circle"></i> Help</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-header">
                <h2>Recharge Wallet</h2>
                <div class="wallet-balance">
                    <span>Current Balance:</span>
                    <span class="amount">NPR 1,250.00</span>
                </div>
            </div>

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
                                <input type="radio" name="paymentMethod" value="esewa" checked>
                                <div class="option-content">
                                    <img src="${pageContext.request.contextPath}/resources/esewa-logo.png" alt="eSewa">
                                    <span>eSewa</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="khalti">
                                <div class="option-content">
                                    <img src="${pageContext.request.contextPath}/resources/khalti-logo.png" alt="Khalti">
                                    <span>Khalti</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="card">
                                <div class="option-content">
                                    <i class="fas fa-credit-card"></i>
                                    <span>Credit/Debit Card</span>
                                </div>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="paymentMethod" value="connectips">
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

                    <div class="auto-recharge">
                        <h3>Auto Recharge Settings</h3>
                        <div class="auto-toggle">
                            <label class="switch">
                                <input type="checkbox" id="autoRechargeToggle">
                                <span class="slider round"></span>
                            </label>
                            <span>Enable Auto Recharge</span>
                        </div>
                        <div class="auto-settings" id="autoSettings" style="display: none;">
                            <div class="form-group">
                                <label>When balance falls below:</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="thresholdAmount" value="500" min="100" step="100">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Recharge Amount:</label>
                                <div class="input-group">
                                    <span class="input-prefix">NPR</span>
                                    <input type="number" id="autoRechargeAmount" value="1000" min="100" step="100">
                                </div>
                            </div>
                            <button class="secondary-btn">Save Settings</button>
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
        // DOM Elements
        const amountButtons = document.querySelectorAll('.amount-btn');
        const customAmountInput = document.getElementById('customAmount');
        const paymentMethodRadios = document.querySelectorAll('input[name="paymentMethod"]');
        const rechargeBtn = document.getElementById('rechargeBtn');
        const autoRechargeToggle = document.getElementById('autoRechargeToggle');
        const autoSettings = document.getElementById('autoSettings');
        
        // Summary elements
        const summaryAmount = document.getElementById('summaryAmount');
        const summaryMethod = document.getElementById('summaryMethod');
        const serviceFee = document.getElementById('serviceFee');
        const summaryTotal = document.getElementById('summaryTotal');
        
        // State
        let selectedAmount = 0;
        let selectedMethod = 'esewa';
        
        // Quick amount buttons
        amountButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                amountButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Set selected amount
                selectedAmount = parseInt(this.dataset.amount);
                customAmountInput.value = '';
                
                updateSummary();
            });
        });
        
        // Custom amount input
        customAmountInput.addEventListener('input', function() {
            if (this.value) {
                // Remove active class from quick amount buttons
                amountButtons.forEach(btn => btn.classList.remove('active'));
                
                selectedAmount = parseInt(this.value) || 0;
                updateSummary();
            }
        });
        
        // Payment method selection
        paymentMethodRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                selectedMethod = this.value;
                updateSummary();
            });
        });
        
        // Auto recharge toggle
        autoRechargeToggle.addEventListener('change', function() {
            if (this.checked) {
                autoSettings.style.display = 'block';
            } else {
                autoSettings.style.display = 'none';
            }
        });
        
        // Update summary function
        function updateSummary() {
            if (selectedAmount > 0) {
                // Calculate service fee (2% for card payments)
                let fee = 0;
                if (selectedMethod === 'card') {
                    fee = Math.round(selectedAmount * 0.02);
                }
                
                const total = selectedAmount + fee;
                
                // Update summary
                summaryAmount.textContent = `NPR ${selectedAmount.toLocaleString()}`;
                summaryMethod.textContent = getMethodName(selectedMethod);
                serviceFee.textContent = `NPR ${fee.toLocaleString()}`;
                summaryTotal.textContent = `NPR ${total.toLocaleString()}`;
                
                // Enable recharge button
                rechargeBtn.disabled = false;
            } else {
                // Reset summary
                summaryAmount.textContent = 'NPR 0';
                summaryMethod.textContent = 'Not selected';
                serviceFee.textContent = 'NPR 0';
                summaryTotal.textContent = 'NPR 0';
                
                // Disable recharge button
                rechargeBtn.disabled = true;
            }
        }
        
        // Helper function to get payment method name
        function getMethodName(method) {
            switch(method) {
                case 'esewa': return 'eSewa';
                case 'khalti': return 'Khalti';
                case 'card': return 'Credit/Debit Card';
                case 'connectips': return 'Connect IPS';
                default: return 'Unknown';
            }
        }
        
        // Recharge button click
        rechargeBtn.addEventListener('click', function() {
            if (selectedAmount < 100) {
                alert('Minimum recharge amount is NPR 100');
                return;
            }
            
            // In a real app, this would redirect to payment gateway
            const paymentUrl = getPaymentUrl(selectedMethod, selectedAmount);
            alert(`Redirecting to ${getMethodName(selectedMethod)} payment page...`);
            
            // Simulate successful payment after delay
            setTimeout(() => {
                const currentBalance = 1250; // This would come from server in real app
                const newBalance = currentBalance + selectedAmount;
                document.querySelector('.wallet-balance .amount').textContent = 
                    `NPR ${newBalance.toLocaleString()}`;
                alert(`Recharge successful! Your new balance is NPR ${newBalance.toLocaleString()}`);
            }, 2000);
        });
        
        // Helper function to get payment URL (simulated)
        function getPaymentUrl(method, amount) {
            // In a real app, these would be actual payment gateway URLs
            return `#${method}-payment?amount=${amount}`;
        }
    });
    </script>
</body>
</html>