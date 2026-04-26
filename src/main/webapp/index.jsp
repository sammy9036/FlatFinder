<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FlatFinder - Broker-Free Room Rental for Students</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1>Find Your Perfect Room Today</h1>
                <p>Broker-free, transparent, and hassle-free room rental platform for students & newcomers</p>
                
                <form method="GET" action="<%= request.getContextPath() %>/seeker/search" class="search-form">
                    <input type="text" name="keyword" placeholder="Search by location or property name..." required>
                    <input type="number" name="minPrice" placeholder="Min Price" min="0">
                    <input type="number" name="maxPrice" placeholder="Max Price" min="0">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="container section-padding">
        <!-- Featured Properties Section -->
        <section class="featured-section">
            <h2>Featured Properties</h2>
            
            <jsp:include page="/WEB-INF/views/common/property-grid.jsp">
                <jsp:param name="maxDisplay" value="6"/>
                <jsp:param name="showBadge" value="true"/>
                <jsp:param name="badgeText" value="Featured"/>
            </jsp:include>
            
            <div class="center">
                <a href="<%= request.getContextPath() %>/property/all" class="btn btn-primary btn-lg">View All Properties <i class="fas fa-arrow-right"></i></a>
            </div>
        </section>
        
        <!-- Why Choose FlatFinder Section -->
        <section class="features-section">
            <h2>Why Choose FlatFinder?</h2>
            <div class="features-grid">
                <div class="feature">
                    <i class="fas fa-ban"></i>
                    <h3>No Brokers</h3>
                    <p>Direct contact with property owners. Save money on broker fees and hidden charges.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-check-circle"></i>
                    <h3>Verified Properties</h3>
                    <p>All properties are verified for authenticity, safety, and legal compliance.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-comments"></i>
                    <h3>Easy Communication</h3>
                    <p>Contact property owners directly through our secure messaging platform.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-lock"></i>
                    <h3>Safe & Secure</h3>
                    <p>Your personal data is protected with industry-standard security measures.</p>
                </div>
                 
            </div>
        </section>

        <!-- How It Works Section -->
        <section class="featured-section">
            <h2>How It Works</h2>
            <div class="features-grid">
                <div class="feature">
                    <div style="font-size: 48px; margin-bottom: 1rem;">
                        <i class="fas fa-user-plus" style="color: var(--primary-color);"></i>
                    </div>
                    <h3>Step 1: Create Account</h3>
                    <p>Register as a seeker or property owner in just a few minutes.</p>
                </div>
                <div class="feature">
                    <div style="font-size: 48px; margin-bottom: 1rem;">
                        <i class="fas fa-search" style="color: var(--primary-color);"></i>
                    </div>
                    <h3>Step 2: Search Properties</h3>
                    <p>Browse through verified listings with detailed information and images.</p>
                </div>
                <div class="feature">
                    <div style="font-size: 48px; margin-bottom: 1rem;">
                        <i class="fas fa-handshake" style="color: var(--primary-color);"></i>
                    </div>
                    <h3>Step 3: Connect & Rent</h3>
                    <p>Get in touch with owners and finalize your rental agreement directly.</p>
                </div>
                
                <div class="feature">
   					 <div style="font-size: 48px; margin-bottom: 1rem;">
        				<i class="fas fa-heart" style="color: var(--primary-color);"></i>
    				</div>
   					 <h3>Step 4: Shortlist & Compare</h3>
    				 <p>Save your favorite properties, compare options, and choose the best fit before contacting owners.</p>
				</div>
                
            </div>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>
