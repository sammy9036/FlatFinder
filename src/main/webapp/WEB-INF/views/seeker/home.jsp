<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Properties - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container section-padding">
        <!-- Welcome Header -->
        <div class="dashboard-header">
            <%
                Object user = session.getAttribute("user");
                String userName = "";
                if (user != null) {
                    try {
                        userName = (String) user.getClass().getMethod("getName").invoke(user);
                    } catch (Exception e) {
                        userName = "User";
                    }
                }
            %>
            <h1><i class="fas fa-wave-hand"></i> Welcome, <%= userName %>!</h1>
            <p>Find your perfect room from our verified listings below</p>
        </div>
        
        <!-- Search & Filter Section -->
        <section class="search-section">
            <form method="GET" action="<%= request.getContextPath() %>/seeker/search" class="filter-form">
                <h3><i class="fas fa-filter"></i> Search & Filter Properties</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="keyword"><i class="fas fa-search"></i> Search</label>
                        <input type="text" id="keyword" name="keyword" placeholder="Property name or location...">
                    </div>
                    <div class="form-group">
                        <label for="minPrice"><i class="fas fa-rupee-sign"></i> Min Price</label>
                        <input type="number" id="minPrice" name="minPrice" placeholder="0" min="0">
                    </div>
                    <div class="form-group">
                        <label for="maxPrice"><i class="fas fa-rupee-sign"></i> Max Price</label>
                        <input type="number" id="maxPrice" name="maxPrice" placeholder="100000" min="0">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
            </form>
        </section>
        
        <!-- Properties Grid Section -->
        <section class="properties-section">
            <div style="margin-bottom: 2rem;">
                <h2><i class="fas fa-home"></i> Available Properties</h2>
            </div>
            
            <jsp:include page="/WEB-INF/views/common/property-grid.jsp">
                <jsp:param name="showBadge" value="false"/>
            </jsp:include>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>
