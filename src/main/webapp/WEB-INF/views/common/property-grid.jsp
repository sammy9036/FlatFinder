<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%-- 
    Reusable Property Grid Component
    Usage: <jsp:include page="/WEB-INF/views/common/property-grid.jsp">
               <jsp:param name="properties" value="${properties}"/>
               <jsp:param name="maxDisplay" value="6"/>
               <jsp:param name="showBadge" value="true"/>
               <jsp:param name="badgeText" value="Featured"/>
           </jsp:include>
    
    Parameters:
    - properties: List of properties to display
    - maxDisplay: Maximum number of properties to show (optional, defaults to all)
    - showBadge: Whether to show badge on cards (optional, defaults to false)
    - badgeText: Text for the badge (optional, defaults to "Featured")
--%>

<%
    List<?> properties = (List<?>) request.getAttribute("properties");
    String maxDisplayStr = request.getParameter("maxDisplay");
    String showBadgeStr = request.getParameter("showBadge");
    String badgeText = request.getParameter("badgeText");
    
    int maxDisplay = properties != null ? properties.size() : 0;
    if (maxDisplayStr != null && !maxDisplayStr.isEmpty()) {
        try {
            maxDisplay = Math.min(Integer.parseInt(maxDisplayStr), maxDisplay);
        } catch (NumberFormatException e) {
            // Use default
        }
    }
    
    boolean showBadge = false;
    if (showBadgeStr != null && showBadgeStr.equals("true")) {
        showBadge = true;
    }
    
    if (badgeText == null || badgeText.isEmpty()) {
        badgeText = "Featured";
    }
%>

<div class="properties-grid">
<%
    if (properties == null || properties.isEmpty()) {
%>
    <div class="no-data">
        <i class="fas fa-home"></i>
        <p>No properties available right now. Check back soon!</p>
    </div>
<%
    } else {
        for (int i = 0; i < maxDisplay; i++) {
            Object prop = properties.get(i);
            Object title = null, location = null, price = null, desc = null, bedrooms = null, bathrooms = null, area = null, imageUrl = null, id = null;
            
            try {
                title = prop.getClass().getMethod("getTitle").invoke(prop);
                location = prop.getClass().getMethod("getLocation").invoke(prop);
                price = prop.getClass().getMethod("getPrice").invoke(prop);
                desc = prop.getClass().getMethod("getDescription").invoke(prop);
                bedrooms = prop.getClass().getMethod("getBedrooms").invoke(prop);
                bathrooms = prop.getClass().getMethod("getBathrooms").invoke(prop);
                area = prop.getClass().getMethod("getArea").invoke(prop);
                imageUrl = prop.getClass().getMethod("getImageUrl").invoke(prop);
                id = prop.getClass().getMethod("getId").invoke(prop);
            } catch (Exception e) {
                // Skip this property if reflection fails
                continue;
            }
%>
    <div class="property-card">
        <div class="property-image-wrapper">
            <img src="<%= request.getContextPath() %>/image/primary/<%= id %>" 
                 alt="<%= title %>" 
                 loading="lazy" 
                 style="width:100%; height:100%; object-fit:cover;"
                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
            <div class="property-image-placeholder" style="display: none;">
                <i class="fas fa-image"></i>
            </div>
            <% if (showBadge) { %>
                <span class="property-badge"><%= badgeText %></span>
            <% } %>
        </div>


        <div class="property-info">
            <h3><%= title %></h3>
            <p class="property-location"><i class="fas fa-map-marker-alt"></i> <%= location %></p>
            <p class="property-price">₹<%= price %><span class="property-price-period">/month</span></p>
            
            <p class="property-desc"><%= desc %></p>
            
            <div class="property-details">
                <% if (bedrooms != null && !bedrooms.toString().isEmpty()) { %>
                    <div class="property-detail-item">
                        <i class="fas fa-bed"></i>
                        <span><%= bedrooms %> BHK</span>
                    </div>
                <% } %>
                <% if (bathrooms != null && !bathrooms.toString().isEmpty()) { %>
                    <div class="property-detail-item">
                        <i class="fas fa-bath"></i>
                        <span><%= bathrooms %> Bath</span>
                    </div>
                <% } %>
                <% if (area != null && !area.toString().isEmpty()) { %>
                    <div class="property-detail-item">
                        <i class="fas fa-ruler-combined"></i>
                        <span><%= area %> Sq.ft</span>
                    </div>
                <% } %>
            </div>
            
            <div class="property-actions">
                <a href="<%= request.getContextPath() %>/property/details/<%= id %>" class="btn btn-secondary">View Details</a>
            </div>
        </div>
    </div>
<%
        }
    }
%>
</div>

