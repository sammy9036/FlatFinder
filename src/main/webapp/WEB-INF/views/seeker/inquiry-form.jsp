<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Owner - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container">
        <div class="form-container">
            <%
                Object property = request.getAttribute("property");
                Object owner = request.getAttribute("owner");
                String propTitle = "", propId = "", ownerName = "", ownerEmail = "", ownerPhone = "";
                
                if (property != null) {
                    try {
                        propTitle = (String) property.getClass().getMethod("getTitle").invoke(property);
                        propId = property.getClass().getMethod("getId").invoke(property).toString();
                    } catch (Exception e) {}
                }
                
                if (owner != null) {
                    try {
                        ownerName = (String) owner.getClass().getMethod("getName").invoke(owner);
                        ownerEmail = (String) owner.getClass().getMethod("getEmail").invoke(owner);
                        ownerPhone = (String) owner.getClass().getMethod("getPhoneNumber").invoke(owner);
                    } catch (Exception e) {}
                }
            %>
            <h1>Contact Owner: <%= propTitle %></h1>
            
            <div class="inquiry-form-section">
                <div class="owner-info-box">
                    <h3>Owner Details</h3>
                    <p><strong>Name:</strong> <%= ownerName %></p>
                    <p><strong>Email:</strong> <%= ownerEmail %></p>
                    <p><strong>Phone:</strong> <%= ownerPhone %></p>
                </div>
                
                <form method="POST" action="<%= request.getContextPath() %>/inquiry/submit" class="inquiry-form">
                    <input type="hidden" name="propertyId" value="<%= propId %>">
                    
                    <div class="form-group">
                        <label for="message">Your Message:</label>
                        <textarea id="message" name="message" required placeholder="Tell the owner about your interest..." rows="6"></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Send Inquiry</button>
                    <a href="<%= request.getContextPath() %>/property/details/<%= propId %>" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
