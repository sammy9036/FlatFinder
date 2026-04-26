<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .popup-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        .popup-card {
            width: min(460px, 92%);
            background: #fff;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            border-top: 5px solid #4caf50;
        }
        .popup-card.error { border-top-color: #e53935; }
        .popup-card.warning { border-top-color: #ff9800; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <%
        com.flatfinder.model.User loggedInUser = (com.flatfinder.model.User) request.getAttribute("loggedInUser");
        String popupStatus = (String) request.getAttribute("popupStatus");
        String popupMessage = (String) request.getAttribute("popupMessage");
    %>

    <% if (popupStatus != null && popupMessage != null) { %>
        <div id="contactPopup" class="popup-overlay">
            <div class="popup-card <%= "error".equals(popupStatus) ? "error" : ("warning".equals(popupStatus) ? "warning" : "") %>">
                <h3 style="margin-bottom: 0.75rem;"><%= "success".equals(popupStatus) ? "Message Sent" : ("warning".equals(popupStatus) ? "Mail Warning" : "Submission Error") %></h3>
                <p style="margin-bottom: 1rem;"><%= popupMessage %></p>
                <p style="font-size: 13px; color: #666; margin: 0;">Redirecting to contact page in 5 seconds...</p>
            </div>
        </div>
    <% } %>
    
    <!-- Contact Hero Section -->
    <section class="hero-section" style="padding: 4rem 0;">
        <div class="container">
            <div class="hero-content">
                <h1>Get In Touch With Us</h1>
                <p>We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
            </div>
        </div>
    </section>
    
    <div class="container section-padding">
        <!-- Contact Information -->
        <section class="featured-section">
            <h2>Contact Information</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem; margin-top: 2rem;">
                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--primary-color);">
                    <i class="fas fa-map-marker-alt" style="font-size: 40px; color: var(--primary-color); margin-bottom: 1rem; display: block;"></i>
                    <h3>Our Office</h3>
                    <p class="text-muted">
                        Pune, Maharashtra<br>
                        India 411001
                    </p>
                </div>
                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--accent-color);">
                    <i class="fas fa-phone" style="font-size: 40px; color: var(--accent-color); margin-bottom: 1rem; display: block;"></i>
                    <h3>Phone Number</h3>
                    <p class="text-muted">
                        +91-8788655768<br>
                        Available 9 AM - 6 PM IST
                    </p>
                </div>
                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--success-color);">
                    <i class="fas fa-envelope" style="font-size: 40px; color: var(--success-color); margin-bottom: 1rem; display: block;"></i>
                    <h3>Email Address</h3>
                    <p class="text-muted">
                        support@flatfinder.com<br>
                        We respond within 24 hours
                    </p>
                </div>
            </div>
        </section>
        
        <!-- Contact Form -->
        <section class="featured-section">
            <h2 style="text-align: center;">Send Us A Message</h2>
            
            <div style="max-width: 700px; margin: 2rem auto;">
                <% if (loggedInUser == null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-lock"></i>
                        <span>Please login to submit the contact form.</span>
                    </div>
                    <div style="text-align: center; margin-top: 1rem;">
                        <a href="<%= request.getContextPath() %>/auth/login" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Login to Continue
                        </a>
                    </div>
                <% } else { %>
                <form method="POST" action="<%= request.getContextPath() %>/contact/submit" class="property-form" style="max-width: 100%;">
                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="name"><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" id="name" name="name" value="<%= loggedInUser.getName() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                            <input type="email" id="email" name="email" value="<%= loggedInUser.getEmail() %>" readonly>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone"><i class="fas fa-phone"></i> Phone Number (Optional)</label>
                        <input type="tel" id="phone" name="phone" value="<%= loggedInUser.getPhoneNumber() != null ? loggedInUser.getPhoneNumber() : "" %>" placeholder="Your phone number">
                    </div>
                    
                    <div class="form-group">
                        <label for="subject"><i class="fas fa-heading"></i> Subject</label>
                        <select id="subject" name="subject" required>
                            <option value="">-- Select Subject --</option>
                            <option value="GENERAL_INQUIRY">General Inquiry</option>
                            <option value="BUG_REPORT">Bug Report</option>
                            <option value="FEATURE_REQUEST">Feature Request</option>
                            <option value="PARTNERSHIP">Partnership Opportunity</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="message"><i class="fas fa-message"></i> Message</label>
                        <textarea id="message" name="message" placeholder="Your message here..." rows="6" required></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-block">
                        <i class="fas fa-paper-plane"></i> Send Message
                    </button>
                </form>
                <% } %>
            </div>
        </section>
        
        <!-- FAQ Section -->
        <section class="featured-section">
            <h2 style="text-align: center;">Frequently Asked Questions</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem; margin-top: 2rem;">
                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--primary-color);">
                    <i class="fas fa-question-circle" style="font-size: 40px; color: var(--primary-color); margin-bottom: 1rem; display: block;"></i>
                    <h3 style="margin-bottom: 0.75rem; color: var(--text-dark);">How do I register on FlatFinder?</h3>
                    <p class="text-muted">Click on the "Register" button, choose your role (Seeker or Owner), fill in your details, and verify your email. That's it!</p>
                </div>

                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--accent-color);">
                    <i class="fas fa-question-circle" style="font-size: 40px; color: var(--accent-color); margin-bottom: 1rem; display: block;"></i>
                    <h3 style="margin-bottom: 0.75rem; color: var(--text-dark);">Are there any charges for using FlatFinder?</h3>
                    <p class="text-muted">No! FlatFinder is completely free for both seekers and property owners. We make money through optional premium features.</p>
                </div>

                <div style="padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm); text-align: center; border-top: 4px solid var(--success-color);">
                    <i class="fas fa-question-circle" style="font-size: 40px; color: var(--success-color); margin-bottom: 1rem; display: block;"></i>
                    <h3 style="margin-bottom: 0.75rem; color: var(--text-dark);">How do I contact a property owner?</h3>
                    <p class="text-muted">Once you find a property you're interested in, click "View Details" and then "Contact Owner" to send an inquiry message.</p>
                </div>

            </div>
        </section>
        
        <!-- CTA Section -->
        <section style="background: linear-gradient(135deg, var(--primary-color), #45a049); border-radius: 12px; padding: 3rem; text-align: center; color: white; margin-top: 2rem;">
            <h2 style="color: white; margin-bottom: 1rem;">Still Have Questions?</h2>
            <p style="color: rgba(255,255,255,0.9); margin-bottom: 2rem; font-size: 16px;">
                Check our help center or reach out to our support team
            </p>
            <a href="mailto:support@flatfinder.com" class="btn" style="background: white; color: var(--primary-color); padding: 0.75rem 2rem; font-weight: 600;">
                <i class="fas fa-envelope"></i> Email Us Now
            </a>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
    <script>
        function closeContactPopup() {
            var popup = document.getElementById("contactPopup");
            if (popup) {
                popup.style.display = "none";
            }
        }

        (function () {
            var popup = document.getElementById("contactPopup");
            if (popup) {
                setTimeout(function () {
                    window.location.href = "<%= request.getContextPath() %>/contact";
                }, 5000);
            }
        })();
    </script>
</body>
</html>
