<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container">
        <h1>All Available Properties</h1>
        
        <%
            List<?> properties = (List<?>) request.getAttribute("properties");
            if (properties != null && !properties.isEmpty()) {
        %>
            <p>Total: <%= properties.size() %> properties available</p>
        <%
            }
        %>
        
        <jsp:include page="/WEB-INF/views/common/property-grid.jsp">
            <jsp:param name="showBadge" value="false"/>
        </jsp:include>
        
        <%
            if (properties == null || properties.isEmpty()) {
        %>
            <div style="text-align: center; margin-top: 2rem;">
                <a href="<%= request.getContextPath() %>/" class="btn btn-primary">Back to Home</a>
            </div>
        <%
            }
        %>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
