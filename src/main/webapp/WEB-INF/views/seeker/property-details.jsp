<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
    <%
        Object property = request.getAttribute("property");
        String title = "";
        if (property != null) {
            try {
                title = (String) property.getClass().getMethod("getTitle").invoke(property);
            } catch (Exception e) {
                title = "Property Details";
            }
        }
    %>
    <%= title %> - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .property-detail-page {
            margin: 2.25rem 0 3.5rem;
        }

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

        .popup-card.error {
            border-top-color: #e53935;
        }

        .property-title-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .property-title-row h1 {
            font-size: 2.1rem;
            line-height: 1.25;
            margin: 0;
        }

        .property-price-tag {
            background: rgba(76, 175, 80, 0.12);
            color: var(--primary-color);
            font-size: 1.05rem;
            font-weight: 700;
            padding: 0.7rem 1rem;
            border-radius: 10px;
            white-space: nowrap;
        }

        .property-detail-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.35fr) minmax(0, 1fr);
            gap: 2rem;
            align-items: start;
        }

        .property-main {
            background: var(--bg-white);
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            padding: 1rem;
        }

        .main-image-container {
            width: 100%;
            height: 500px;
            background-color: var(--bg-light);
            border-radius: 14px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 14px;
        }
        
        .main-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .thumbnail-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(86px, 1fr));
            gap: 0.65rem;
        }

        .thumbnail {
            width: 100%;
            height: 86px;
            background-color: var(--bg-light);
            border: 2px solid transparent;
            border-radius: 8px;
            cursor: pointer;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        
        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .thumbnail:hover,
        .thumbnail.active {
            border-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .property-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            font-size: 18px;
            text-align: center;
            padding: 20px;
        }

        .property-sidebar {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .info-card,
        .owner-card {
            background: var(--bg-white);
            border-radius: 14px;
            padding: 1.25rem;
            box-shadow: var(--shadow-sm);
        }

        .info-card h2,
        .owner-card h3 {
            font-size: 1.1rem;
            margin-bottom: 0.85rem;
        }

        .property-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.7rem;
            margin-bottom: 0.75rem;
        }

        .meta-box {
            background: var(--bg-light);
            border-radius: 10px;
            padding: 0.7rem 0.85rem;
            border: 1px solid var(--border-color);
        }

        .meta-box span {
            display: block;
            color: var(--text-light);
            font-size: 12px;
            margin-bottom: 0.2rem;
        }

        .meta-box strong {
            color: var(--text-dark);
            font-size: 14px;
        }

        .property-location-line {
            font-size: 14px;
            color: var(--text-light);
            margin-bottom: 0.75rem;
        }

        .details-list {
            display: grid;
            gap: 0.6rem;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            padding: 0.65rem 0;
            border-bottom: 1px dashed var(--border-color);
            font-size: 14px;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-item .label {
            color: var(--text-light);
            font-weight: 500;
        }

        .detail-item .value {
            color: var(--text-dark);
            font-weight: 600;
            text-align: right;
        }

        .owner-line {
            margin-bottom: 0.45rem;
            color: var(--text-light);
            font-size: 14px;
        }

        .owner-line strong {
            color: var(--text-dark);
        }

        @media (max-width: 1024px) {
            .property-detail-grid {
                grid-template-columns: 1fr;
            }

            .main-image-container {
                height: 420px;
            }
        }

        @media (max-width: 768px) {
            .property-title-row {
                flex-direction: column;
                align-items: flex-start;
            }

            .property-title-row h1 {
                font-size: 1.65rem;
            }

            .main-image-container {
                height: 320px;
            }

            .property-meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <%
        String popupStatus = (String) request.getAttribute("popupStatus");
        String popupMessage = (String) request.getAttribute("popupMessage");
    %>

    <% if (popupStatus != null && popupMessage != null) { %>
        <div id="inquiryPopup" class="popup-overlay">
            <div class="popup-card <%= "error".equals(popupStatus) ? "error" : "" %>">
                <h3 style="margin-bottom: 0.75rem;"><%= "success".equals(popupStatus) ? "Inquiry Sent" : "Submission Error" %></h3>
                <p style="margin-bottom: 1rem;"><%= popupMessage %></p>
                <p style="font-size: 13px; color: #666; margin: 0;">Redirecting in 5 seconds...</p>
            </div>
        </div>
    <% } %>
    
    <div class="container">
        <div class="property-detail-page">
            <%
                Object price = null;
                Object location = null;
                try {
                    price = property.getClass().getMethod("getPrice").invoke(property);
                    location = property.getClass().getMethod("getLocation").invoke(property);
                } catch (Exception e) {}
            %>
            <div class="property-title-row">
                <div>
                    <h1><%= title %></h1>
                    <p class="property-location-line">📍 <%= (location != null) ? location : "Location not available" %></p>
                </div>
                <div class="property-price-tag">₹<%= (price != null) ? price : "--" %>/month</div>
            </div>
            
            <div class="property-detail-grid">
                <div class="property-main">
                    <!-- IMAGE GALLERY SECTION -->
                    <div class="property-image-gallery">
                        <!-- Main Image Display -->
                        <div class="main-image-container" id="mainImageContainer">
                            <%
                                List<?> images = (List<?>) request.getAttribute("images");
                                if (images != null && images.size() > 0) {
                                    Object firstImage = images.get(0);
                                    Object imageId = firstImage.getClass().getMethod("getId").invoke(firstImage);
                            %>
                                <img id="mainImage" src="/image/download/<%= imageId %>" alt="<%= title %>">
                            <%
                                } else {
                            %>
                                <div class="property-image-placeholder">
                                    📸 No Images Available
                                </div>
                            <%
                                }
                            %>
                        </div>
                        
                        <!-- Thumbnail Gallery -->
                        <%
                            if (images != null && images.size() > 1) {
                        %>
                            <div class="thumbnail-gallery" id="thumbnailGallery">
                            <%
                                for (int i = 0; i < images.size(); i++) {
                                    Object img = images.get(i);
                                    Object imgId = img.getClass().getMethod("getId").invoke(img);
                            %>
                                    <div class="thumbnail <%= (i == 0) ? "active" : "" %>" onclick="changeImage('<%= imgId %>', this)">
                                        <img src="/image/download/<%= imgId %>" alt="Thumbnail <%= (i + 1) %>">
                                    </div>
                            <%
                                }
                            %>
                            </div>
                        <%
                            }
                        %>
                    </div>
                    
                </div>
                
                <div class="property-sidebar">
                    <%
                        Object desc = null;
                        Object bedrooms = null;
                        Object bathrooms = null;
                        Object area = null;
                        Object amenities = null;
                        try {
                            desc = property.getClass().getMethod("getDescription").invoke(property);
                            bedrooms = property.getClass().getMethod("getBedrooms").invoke(property);
                            bathrooms = property.getClass().getMethod("getBathrooms").invoke(property);
                            area = property.getClass().getMethod("getArea").invoke(property);
                            amenities = property.getClass().getMethod("getAmenities").invoke(property);
                        } catch (Exception e) {}
                    %>
                    <div class="info-card">
                        <h2>Property Overview</h2>
                        <div class="property-meta">
                            <div class="meta-box">
                                <span>Bedrooms</span>
                                <strong><%= (bedrooms != null && !bedrooms.toString().isEmpty()) ? bedrooms : "N/A" %></strong>
                            </div>
                            <div class="meta-box">
                                <span>Bathrooms</span>
                                <strong><%= (bathrooms != null && !bathrooms.toString().isEmpty()) ? bathrooms : "N/A" %></strong>
                            </div>
                            <div class="meta-box">
                                <span>Area</span>
                                <strong><%= (area != null && !area.toString().isEmpty()) ? area : "N/A" %></strong>
                            </div>
                            <div class="meta-box">
                                <span>Rent</span>
                                <strong>₹<%= (price != null) ? price : "--" %>/month</strong>
                            </div>
                        </div>
                        <div class="details-list">
                            <div class="detail-item">
                                <span class="label">Location</span>
                                <span class="value">📍 <%= (location != null) ? location : "N/A" %></span>
                            </div>
                            <div class="detail-item">
                                <span class="label">Amenities</span>
                                <span class="value"><%= (amenities != null && !amenities.toString().isEmpty()) ? amenities : "N/A" %></span>
                            </div>
                        </div>
                    </div>

                    <div class="info-card">
                        <h2>Description</h2>
                        <p class="text-muted" style="margin: 0; line-height: 1.75;">
                            <%= (desc != null && !desc.toString().isEmpty()) ? desc : "Description not available for this property." %>
                        </p>
                    </div>

                    <div class="owner-card">
                        <h3>Owner Details</h3>
                        <%
                            Object owner = request.getAttribute("owner");
                            String ownerName = "", ownerEmail = "", ownerPhone = "";
                            if (owner != null) {
                                try {
                                    ownerName = (String) owner.getClass().getMethod("getName").invoke(owner);
                                    ownerEmail = (String) owner.getClass().getMethod("getEmail").invoke(owner);
                                    ownerPhone = (String) owner.getClass().getMethod("getPhoneNumber").invoke(owner);
                                } catch (Exception e) {}
                            }
                        %>
                        <p class="owner-line"><strong><%= ownerName %></strong></p>
                        <p class="owner-line">📧 <%= ownerEmail %></p>
                        <p class="owner-line">📱 <%= ownerPhone %></p>
                        
                        <%
                            Object sessionUser = session.getAttribute("user");
                            if (sessionUser != null) {
                                Object propId = null;
                                try {
                                    propId = property.getClass().getMethod("getId").invoke(property);
                                } catch (Exception e) {}
                        %>
                            <a href="<%= request.getContextPath() %>/inquiry/contact/<%= propId %>" class="btn btn-primary btn-block" style="margin-top: 0.5rem;">
                                📞 Contact Owner
                            </a>
                        <%
                            } else {
                        %>
                            <p class="info-text">Please <a href="<%= request.getContextPath() %>/auth/login">login</a> to contact the owner.</p>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
    <script>
        (function () {
            var popup = document.getElementById("inquiryPopup");
            if (popup) {
                setTimeout(function () {
                    var currentPath = window.location.pathname;
                    window.location.href = currentPath;
                }, 5000);
            }
        })();

        function changeImage(imageId, thumbnailElement) {
            const mainImage = document.getElementById('mainImage');
            if (mainImage) {
                mainImage.src = '/image/download/' + imageId;
            }
            
            // Update thumbnail selection
            document.querySelectorAll('.thumbnail').forEach(thumb => {
                thumb.classList.remove('active');
            });
            if (thumbnailElement) {
                thumbnailElement.classList.add('active');
            }
        }
    </script>
</body>
</html>
