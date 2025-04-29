document.addEventListener('DOMContentLoaded', function() {
    // Tab switching functionality
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons and contents
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked button
            btn.classList.add('active');
            
            // Show corresponding content
            const tabId = btn.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Display current date
    function updateCurrentDate() {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const today = new Date();
        document.getElementById('current-date').textContent = today.toLocaleDateString('en-US', options);
    }
    updateCurrentDate();

    // Password strength indicator
    const newPasswordInput = document.getElementById('new-password');
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
            if (currentForm.querySelector('#new-password')) {
                const newPassword = currentForm.querySelector('#new-password').value;
                const confirmPassword = currentForm.querySelector('#confirm-password').value;
                
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
                
                // Simulate API call (replace with actual fetch() in production)
                setTimeout(() => {
                    alert('Settings saved successfully!');
                    submitBtn.disabled = false;
                    submitBtn.textContent = originalText;
                }, 1500);
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
                if (form.querySelector('#new-password')) {
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