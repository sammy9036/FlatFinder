/**
 * FlatFinder - Modern UI JavaScript
 * Handles animations, interactivity, and form validations
 */

// ============================================
// Document Ready - Initialize Features
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    initializeAnimations();
    initializeFormValidation();
    initializePropertyFilters();
    initializeToasts();
});

// ============================================
// ANIMATIONS
// ============================================

function initializeAnimations() {
    // Fade in animation for cards
    observeElements('.property-card', {
        rootMargin: '0px 0px -100px 0px'
    });
    
    observeElements('.stat-card', {
        rootMargin: '0px 0px -100px 0px'
    });
    
    observeElements('.feature', {
        rootMargin: '0px 0px -100px 0px'
    });
}

function observeElements(selector, options = {}) {
    const defaultOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px',
        ...options
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animation = 'fadeInUp 0.6s ease forwards';
                observer.unobserve(entry.target);
            }
        });
    }, defaultOptions);

    document.querySelectorAll(selector).forEach(el => observer.observe(el));
}

// ============================================
// FORM VALIDATION
// ============================================

function initializeFormValidation() {
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(this)) {
                e.preventDefault();
            }
        });
    });

    // Real-time validation
    const inputs = document.querySelectorAll('input[type="email"], input[type="password"], input[type="tel"]');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
    });
}

function validateForm(form) {
    let isValid = true;
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');

    inputs.forEach(input => {
        if (!validateField(input)) {
            isValid = false;
        }
    });

    return isValid;
}

function validateField(field) {
    let isValid = true;
    const errorMsg = field.parentElement.querySelector('.error-message');

    // Clear previous error
    if (errorMsg) {
        errorMsg.remove();
    }

    field.classList.remove('input-error');

    // Email validation
    if (field.type === 'email') {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(field.value)) {
            showFieldError(field, 'Please enter a valid email address');
            isValid = false;
        }
    }

    // Password validation
    if (field.type === 'password' && field.hasAttribute('minlength')) {
        const minLength = parseInt(field.getAttribute('minlength'));
        if (field.value.length < minLength) {
            showFieldError(field, `Password must be at least ${minLength} characters`);
            isValid = false;
        }
    }

    // Phone validation
    if (field.type === 'tel' && field.value) {
        const phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(field.value.replace(/\D/g, ''))) {
            showFieldError(field, 'Please enter a valid 10-digit phone number');
            isValid = false;
        }
    }

    // Required field validation
    if (field.hasAttribute('required') && !field.value.trim()) {
        showFieldError(field, 'This field is required');
        isValid = false;
    }

    return isValid;
}

function showFieldError(field, message) {
    field.classList.add('input-error');
    const errorElement = document.createElement('div');
    errorElement.className = 'error-message';
    errorElement.textContent = message;
    field.parentElement.appendChild(errorElement);
}

// ============================================
// PROPERTY FILTERS
// ============================================

function initializePropertyFilters() {
    const filterForm = document.querySelector('.filter-form');
    if (filterForm) {
        const inputs = filterForm.querySelectorAll('input, select');
        inputs.forEach(input => {
            input.addEventListener('change', function() {
                // Auto-submit on filter change (optional)
                // filterForm.submit();
            });
        });
    }
}

// ============================================
// TOAST NOTIFICATIONS
// ============================================

function initializeToasts() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        // Auto-close success messages after 5 seconds
        if (alert.classList.contains('alert-success')) {
            setTimeout(() => {
                alert.style.animation = 'slideUp 0.4s ease forwards';
                setTimeout(() => alert.remove(), 400);
            }, 5000);
        }

        // Add close button
        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '<i class="fas fa-times"></i>';
        closeBtn.className = 'alert-close';
        closeBtn.onclick = function() {
            alert.style.animation = 'slideUp 0.4s ease forwards';
            setTimeout(() => alert.remove(), 400);
        };
        alert.appendChild(closeBtn);
    });
}

// ============================================
// UTILITY FUNCTIONS
// ============================================

/**
 * Format currency
 */
function formatCurrency(value) {
    return new Intl.NumberFormat('en-IN', {
        style: 'currency',
        currency: 'INR',
        minimumFractionDigits: 0
    }).format(value);
}

/**
 * Smooth scroll to element
 */
function smoothScroll(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

/**
 * Debounce function for search
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Format date
 */
function formatDate(date) {
    return new Intl.DateTimeFormat('en-IN', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    }).format(new Date(date));
}

// ============================================
// KEYBOARD SHORTCUTS
// ============================================

document.addEventListener('keydown', function(event) {
    // Ctrl/Cmd + / = Focus search
    if ((event.ctrlKey || event.metaKey) && event.key === '/') {
        event.preventDefault();
        const searchInput = document.querySelector('input[placeholder*="Search"]');
        if (searchInput) searchInput.focus();
    }

    // Escape = Close dropdowns
    if (event.key === 'Escape') {
        document.querySelectorAll('.dropdown').forEach(dropdown => {
            dropdown.style.display = 'none';
        });
    }
});

// ============================================
// LAZY LOADING IMAGES
// ============================================

function initializeLazyLoad() {
    const images = document.querySelectorAll('img[loading="lazy"]');
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.removeAttribute('loading');
                    imageObserver.unobserve(img);
                }
            });
        });
        images.forEach(img => imageObserver.observe(img));
    }
}

// ============================================
// EXPORT FUNCTIONS FOR GLOBAL USE
// ============================================

window.flatfinder = {
    formatCurrency,
    smoothScroll,
    debounce,
    formatDate,
    validateField,
    validateForm
};
