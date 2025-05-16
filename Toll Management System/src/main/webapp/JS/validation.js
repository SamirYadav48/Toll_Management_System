// Function to validate individual form fields
function validateField(input) {
    const errorElement = input.nextElementSibling;
    if (!input.checkValidity()) {
        showError(input, input.title || 'This field is required');
        return false;
    } else {
        clearError(input);
        return true;
    }
}

// Function to validate password match
function validatePasswordMatch() {
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirm-password');
    const errorElement = confirmPassword.nextElementSibling;
    
    if (password.value !== confirmPassword.value) {
        showError(confirmPassword, "Passwords don't match");
        return false;
    } else {
        clearError(confirmPassword);
        return true;
    }
}

// Function to show error message
function showError(input, message) {
    const errorElement = input.nextElementSibling;
    if (errorElement && errorElement.classList.contains('error-message')) {
        errorElement.textContent = message;
        errorElement.style.display = 'block';
        input.style.borderColor = '#dc3545';
    }
}

// Function to clear error message
function clearError(input) {
    const errorElement = input.nextElementSibling;
    if (errorElement && errorElement.classList.contains('error-message')) {
        errorElement.textContent = '';
        errorElement.style.display = 'none';
        input.style.borderColor = '#28a745';
    }
}

// Form submission validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    if (form) {
        form.addEventListener('submit', function(event) {
            let isValid = true;
            
            // Validate all required fields
            const inputs = form.querySelectorAll('input[required]');
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });
            
            // Validate password match
            if (!validatePasswordMatch()) {
                isValid = false;
            }
            
            if (!isValid) {
                event.preventDefault();
            }
        });
    }
}); 