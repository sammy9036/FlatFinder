<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verification - FlatFinder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container">
        <div class="auth-form-container">
            <h2>Email Verification</h2>
            
            <%
                String success = (String) request.getAttribute("success");
                String error = (String) request.getAttribute("error");
                String email = (String) request.getAttribute("email");
            %>
            
            <% if (success != null && !success.isEmpty()) { %>
                <div class="alert alert-success"><%= success %></div>
            <% } %>
            
            <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-error"><%= error %></div>
            <% } %>
            
            <p>We've sent an OTP to your email. Please enter it below to verify your account.</p>
            
            <form method="POST" action="<%= request.getContextPath() %>/auth/verify-otp" class="auth-form">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= (email != null) ? email : "" %>" required placeholder="your@email.com">
                </div>
                
                <div class="form-group">
                    <label for="otp">OTP Code (6 digits):</label>
                    <input type="text" id="otp" name="otp" required placeholder="000000" maxlength="6" pattern="[0-9]{6}">
                </div>
                
                <button type="submit" class="btn btn-primary">Verify</button>
            </form>
            
            <p class="auth-link"><a href="<%= request.getContextPath() %>/auth/register">Go back to register</a></p>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
