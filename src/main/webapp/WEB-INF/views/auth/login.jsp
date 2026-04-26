<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container section-padding">
        <div class="auth-form-container">
            <div style="text-align: center; margin-bottom: 2rem;">
                <i class="fas fa-sign-in-alt" style="font-size: 40px; color: var(--primary-color); margin-bottom: 1rem; display: block;"></i>
                <h2>Welcome Back!</h2>
                <p class="text-muted">Sign in to your FlatFinder account</p>
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
            
            <form method="POST" action="<%= request.getContextPath() %>/auth/login">
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="your@email.com">
                </div>
                
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>
                
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <label style="display: flex; align-items: center; font-weight: 400;">
                        <input type="checkbox" name="remember" style="margin-right: 0.5rem;">
                        Remember me
                    </label>
                    <a href="#" style="color: var(--primary-color); text-decoration: none; font-size: 13px;">Forgot password?</a>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block" style="padding: 1rem; font-size: 15px;">
                    <i class="fas fa-sign-in-alt"></i> Sign In
                </button>
            </form>
            
            <div class="auth-link">
                Don't have an account? <a href="<%= request.getContextPath() %>/auth/register">Create one now</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>
