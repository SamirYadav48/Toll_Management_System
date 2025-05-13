document.addEventListener('DOMContentLoaded', function() {
    // Tab switching functionality
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    function switchTab(tabId) {
        // Hide all tab contents
        tabContents.forEach(content => {
            content.style.display = 'none';
            content.classList.remove('active');
        });
        
        // Remove active class from all buttons
        tabButtons.forEach(btn => {
            btn.classList.remove('active');
        });
        
        // Show selected tab content and activate button
        const selectedContent = document.getElementById(tabId);
        const selectedButton = document.querySelector(`[data-tab="${tabId}"]`);
        
        if (selectedContent && selectedButton) {
            selectedContent.style.display = 'block';
            selectedContent.classList.add('active');
            selectedButton.classList.add('active');
        }
    }

    // Add click event listeners to all tab buttons
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const tabId = button.getAttribute('data-tab');
            if (tabId) {
                switchTab(tabId);
            }
        });
    });

    // Initialize the first tab as active
    const firstTab = tabButtons[0];
    if (firstTab) {
        const firstTabId = firstTab.getAttribute('data-tab');
        switchTab(firstTabId);
    }

    // Display current date
    function updateCurrentDate() {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const today = new Date();
        document.getElementById('current-date').textContent = today.toLocaleDateString('en-US', options);
    }
    updateCurrentDate();

    // Password strength indicator
    const newPasswordInput = document.getElementById('newPassword');
    if (newPasswordInput) {
        newPasswordInput.addEventListener('input', function() {
            const password = this.value;
            const strengthBars = document.querySelectorAll('.strength-bar');
            const strengthText = document.querySelector('.strength-text');
            
            // Reset all bars
            strengthBars.forEach(bar => bar.style.width = '0%');
            
            if (password.length === 0) {
                strengthText.textContent = 'Password strength';
                return;
            }
            
            // Strength calculation
            let strength = 0;
            if (password.length > 6) strength++;
            if (password.length > 10) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            // Update UI based on strength
            const width = Math.min(100, strength * 25);
            strengthBars[0].style.width = width + '%';
            strengthBars[1].style.width = width >= 50 ? (width - 50) + '%' : '0%';
            strengthBars[2].style.width = width >= 75 ? (width - 75) + '%' : '0%';
            
            // Update text
            if (strength < 2) {
                strengthText.textContent = 'Weak';
                strengthBars[0].style.backgroundColor = '#ff4d4d';
            } else if (strength < 4) {
                strengthText.textContent = 'Medium';
                strengthBars[0].style.backgroundColor = '#ffa64d';
            } else {
                strengthText.textContent = 'Strong';
                strengthBars[0].style.backgroundColor = '#4CAF50';
            }
        });
    }

    // Form submission handling
    document.querySelectorAll('.settings-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Basic form validation
            let isValid = true;
            const currentForm = this;
            
            // Check if it's the password change form
            if (currentForm.querySelector('#newPassword')) {
                const newPassword = currentForm.querySelector('#newPassword').value;
                const confirmPassword = currentForm.querySelector('#confirmPassword').value;
                
                if (newPassword !== confirmPassword) {
                    alert('Passwords do not match!');
                    isValid = false;
                }
            }
            
            if (isValid) {
                // Show loading indicator
                const submitBtn = currentForm.querySelector('.save-btn');
                const originalText = submitBtn.textContent;
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
                
                // Submit the form
                currentForm.submit();
            }
        });
    });

    // Cancel button functionality
    document.querySelectorAll('.cancel-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            // Reset form to initial state
            const form = this.closest('form');
            if (form) {
                form.reset();
                
                // For password form, clear the strength indicator
                if (form.querySelector('#newPassword')) {
                    document.querySelectorAll('.strength-bar').forEach(bar => {
                        bar.style.width = '0%';
                        bar.style.backgroundColor = '';
                    });
                    document.querySelector('.strength-text').textContent = 'Password strength';
                }
            }
        });
    });

    // Toggle switches functionality
    document.querySelectorAll('.switch input').forEach(toggle => {
        toggle.addEventListener('change', function() {
            const status = this.checked ? 'on' : 'off';
            console.log('Toggle switched ' + status);
            // You could add specific logic for each toggle here
        });
    });

    // Profile picture upload simulation
    const profilePic = document.querySelector('.profile-pic');
    if (profilePic) {
        profilePic.addEventListener('click', function() {
            // This would normally trigger a file input, but we'll simulate it
            alert('Profile picture upload dialog would appear here');
        });
    }
});