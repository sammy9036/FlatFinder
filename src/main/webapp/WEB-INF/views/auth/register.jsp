<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container section-padding">
        <div class="auth-form-container" style="max-width: 600px;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <i class="fas fa-user-plus" style="font-size: 40px; color: var(--primary-color); margin-bottom: 1rem; display: block;"></i>
                <h2>Join FlatFinder Today</h2>
                <p class="text-muted">Create your account to get started</p>
            </div>
            
            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
            %>
            
            <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= error %></span>
                </div>
            <% } %>
            
            <% if (success != null && !success.isEmpty()) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span><%= success %></span>
                </div>
            <% } %>
            
            <form method="POST" action="<%= request.getContextPath() %>/auth/register">
                <div class="form-row-2">
                    <div class="form-group">
                        <label for="name"><i class="fas fa-user"></i> Full Name</label>
                        <input type="text" id="name" name="name" required placeholder="Your full name">
                    </div>
                    
                    <div class="form-group">
                        <label for="role"><i class="fas fa-id-badge"></i> I am a</label>
                        <select id="role" name="role" required>
                            <option value="">-- Select --</option>
                            <option value="SEEKER">Property Seeker</option>
                            <option value="OWNER">Property Owner</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="your@email.com">
                </div>
                
                <div class="form-row-2">
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" id="password" name="password" required placeholder="Min 6 characters" minlength="6">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone"><i class="fas fa-phone"></i> Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="10-digit number">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address"><i class="fas fa-map-marker-alt"></i> Address</label>
                    <textarea id="address" name="address" placeholder="Your full address" rows="2"></textarea>
                </div>
                
                <div style="display: flex; gap: 0.5rem; margin-bottom: 1.5rem; font-size: 13px;">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms" style="margin: 0;">I agree to the <a href="#" style="color: var(--primary-color);">Terms & Conditions</a> and <a href="#" style="color: var(--primary-color);">Privacy Policy</a></label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block" style="padding: 1rem; font-size: 15px;">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>
            
            <div class="auth-link">
                Already have an account? <a href="<%= request.getContextPath() %>/auth/login">Sign in here</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>
