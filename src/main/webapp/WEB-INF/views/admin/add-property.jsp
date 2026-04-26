<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Property - FlatFinder Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin-css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-context-path="<%= request.getContextPath() %>">
<%
    com.flatfinder.model.User adminUser = (com.flatfinder.model.User) session.getAttribute("user");
    String error = (String) request.getAttribute("error");
%>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand"><i class="fas fa-shield-alt"></i><div><h2>FlatFinder Admin</h2><p>Control Center</p></div></div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="menu-item"><i class="fas fa-gauge"></i> Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Manage Users</a>
            <a href="<%= request.getContextPath() %>/admin/properties" class="menu-item"><i class="fas fa-building"></i> Properties</a>
            <a href="<%= request.getContextPath() %>/admin/pending-properties" class="menu-item"><i class="fas fa-clock"></i> Pending Approval</a>
            <a href="<%= request.getContextPath() %>/admin/add-property" class="menu-item active"><i class="fas fa-plus"></i> Add Property</a>
            <a href="<%= request.getContextPath() %>/admin/inquiries" class="menu-item"><i class="fas fa-envelope"></i> Inquiries</a>
        </nav>
        <div class="sidebar-footer"><a href="<%= request.getContextPath() %>/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div class="topbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <div class="page-title">
                    <h1>Add Property</h1>
                    <p>Create a new property listing (auto-approved for admin)</p>
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

                <form method="POST" action="<%= request.getContextPath() %>/admin/add-property" enctype="multipart/form-data" id="propertyForm">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="title">Property Title *</label>
                            <input type="text" id="title" name="title" required placeholder="e.g., 2 BHK Apartment">
                        </div>
                        <div class="form-group">
                            <label for="price">Monthly Rent (INR) *</label>
                            <input type="number" id="price" name="price" required min="1000" placeholder="25000">
                        </div>
                        <div class="form-group">
                            <label for="location">Location *</label>
                            <input type="text" id="location" name="location" required placeholder="Street address">
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" placeholder="City name">
                        </div>
                        <div class="form-group">
                            <label for="bedrooms">Bedrooms</label>
                            <input type="text" id="bedrooms" name="bedrooms" placeholder="1, 2, 3+">
                        </div>
                        <div class="form-group">
                            <label for="bathrooms">Bathrooms</label>
                            <input type="text" id="bathrooms" name="bathrooms" placeholder="1, 2">
                        </div>
                        <div class="form-group">
                            <label for="area">Area (sq ft)</label>
                            <input type="text" id="area" name="area" placeholder="650">
                        </div>
                        <div class="form-group">
                            <label for="amenities">Amenities</label>
                            <input type="text" id="amenities" name="amenities" placeholder="WiFi, AC, Parking">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" required placeholder="Describe the property, neighborhood, and highlights"></textarea>
                    </div>

                    <div class="file-upload-box">
                        <label for="imageFiles" class="btn-action btn-primary" style="display:inline-flex;">Choose Images</label>
                        <input type="file" id="imageFiles" name="imageFiles" accept="image/jpeg,image/png,image/webp" multiple style="display:none;">
                        <p>Upload up to 4 images. The first image becomes the primary image.</p>
                        <div id="imagePreviewContainer" class="preview-grid"></div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-action btn-primary"><i class="fas fa-plus"></i> Add Property</button>
                        <a href="<%= request.getContextPath() %>/admin/properties" class="btn-action btn-neutral"><i class="fas fa-arrow-left"></i> Cancel</a>
                    </div>
                </form>
            </div>
        </section>
    </main>
</div>

<script src="<%= request.getContextPath() %>/admin-js/admin-dashboard.js"></script>
<script>
    document.getElementById('imageFiles').addEventListener('change', function(e) {
        const files = Array.from(e.target.files || []);
        if (files.length > 4) {
            alert('Maximum 4 images allowed');
            e.target.value = '';
            return;
        }
        displayImagePreviews(files);
    });

    function displayImagePreviews(files) {
        const container = document.getElementById('imagePreviewContainer');
        container.innerHTML = '';

        files.forEach(function(file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                const div = document.createElement('div');
                div.className = 'preview-item';
                div.innerHTML = '<img src="' + event.target.result + '" alt="Preview">';
                container.appendChild(div);
            };
            reader.readAsDataURL(file);
        });
    }
</script>
</body>
</html>