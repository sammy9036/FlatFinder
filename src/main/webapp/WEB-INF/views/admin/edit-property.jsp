<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Property - FlatFinder Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    String error = (String) request.getAttribute("error");

    Object propertyObj = request.getAttribute("property");
    String title = "", price = "", location = "", city = "", bedrooms = "", bathrooms = "", area = "", amenities = "", description = "", propId = "";

    if (propertyObj != null) {
        try {
            com.flatfinder.model.Property prop = (com.flatfinder.model.Property) propertyObj;
            title = prop.getTitle() != null ? prop.getTitle() : "";
            price = prop.getPrice() != null ? prop.getPrice().toString() : "";
            location = prop.getLocation() != null ? prop.getLocation() : "";
            city = prop.getCity() != null ? prop.getCity() : "";
            bedrooms = prop.getBedrooms() != null ? prop.getBedrooms() : "";
            bathrooms = prop.getBathrooms() != null ? prop.getBathrooms() : "";
            area = prop.getArea() != null ? prop.getArea() : "";
            amenities = prop.getAmenities() != null ? prop.getAmenities() : "";
            description = prop.getDescription() != null ? prop.getDescription() : "";
            propId = prop.getId() != null ? prop.getId().toString() : "";
        } catch (Exception e) {
            // Keep defaults when property binding fails.
        }
    }
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item active"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>
        <div class="sidebar-footer"><a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Edit Property</h1>
                    <p>Update listing information and save changes</p>
                </div>
            </div>
            <div class="admin-user">
                <span><%= adminUser != null ? adminUser.getName() : "Admin" %></span>
                <div class="user-avatar"><%= adminUser != null ? adminUser.getName().substring(0, 1).toUpperCase() : "A" %></div>
            </div>
        </header>

        <section class="admin-page">
            <div class="form-panel">
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert-inline alert-error"><%= error %></div>
                <% } %>

                <form method="POST" action="<%= request.getContextPath() %>/admin/update-property/<%= propId %>" id="propertyForm">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="title">Property Title *</label>
                            <input type="text" id="title" name="title" required value="<%= title %>">
                        </div>
                        <div class="form-group">
                            <label for="price">Monthly Rent (INR) *</label>
                            <input type="number" id="price" name="price" required min="1000" value="<%= price %>">
                        </div>
                        <div class="form-group">
                            <label for="location">Location *</label>
                            <input type="text" id="location" name="location" required value="<%= location %>">
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" value="<%= city %>">
                        </div>
                        <div class="form-group">
                            <label for="bedrooms">Bedrooms</label>
                            <input type="text" id="bedrooms" name="bedrooms" value="<%= bedrooms %>">
                        </div>
                        <div class="form-group">
                            <label for="bathrooms">Bathrooms</label>
                            <input type="text" id="bathrooms" name="bathrooms" value="<%= bathrooms %>">
                        </div>
                        <div class="form-group">
                            <label for="area">Area (sq ft)</label>
                            <input type="text" id="area" name="area" value="<%= area %>">
                        </div>
                        <div class="form-group">
                            <label for="amenities">Amenities</label>
                            <input type="text" id="amenities" name="amenities" value="<%= amenities %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" required><%= description %></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-action btn-primary"><i class="fas fa-save"></i> Update Property</button>
                        <a href="<%= request.getContextPath() %>/admin/properties" class="btn-action btn-neutral"><i class="fas fa-arrow-left"></i> Cancel</a>
                    </div>
                </form>
            </div>
        </section>
    </main>
</div>

<script src="<%= request.getContextPath() %>/admin-js/admin-dashboard.js"></script>
</body>
</html>