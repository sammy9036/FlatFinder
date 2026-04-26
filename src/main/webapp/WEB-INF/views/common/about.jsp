<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <!-- About Hero Section -->
    <section class="hero-section" style="padding: 4rem 0;">
        <div class="container">
            <div class="hero-content">
                <h1>About FlatFinder</h1>
                <p>Revolutionizing the room rental experience for students and newcomers</p>
            </div>
        </div>
    </section>
    
    <div class="container section-padding">
        <!-- Our Story -->
        <section class="featured-section">
            <h2>Our Story</h2>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items: center; margin-top: 2rem;">
                <div>
                    <p style="font-size: 16px; line-height: 1.8; color: var(--text-light); margin-bottom: 1.5rem;">
                        FlatFinder was born from a simple idea: <strong style="color: var(--primary-color);">making room rental transparent and broker-free</strong> for everyone. 
                        We noticed students and newcomers were struggling with overpriced listings and unreliable brokers.
                    </p>
                    <p style="font-size: 16px; line-height: 1.8; color: var(--text-light); margin-bottom: 1.5rem;">
                        In 2024, we launched FlatFinder with a mission to connect property owners directly with seekers, eliminating unnecessary intermediaries and hidden charges. 
                        Today, we're proud to serve thousands of users across India.
                    </p>
                    <p style="font-size: 16px; line-height: 1.8; color: var(--text-light);">
                        Our platform ensures <strong style="color: var(--primary-color);">transparency, security, and affordability</strong> in every rental transaction.
                    </p>
                </div>
                <div style="border-radius: 12px; height: 400px; overflow: hidden;">
                    <img src="<%= request.getContextPath() %>/Images/about.jpg" alt="FlatFinder contact" style="width: 100%; height: 100%; object-fit: cover; display: block;">
                </div>
            </div>
        </section>
        
        <!-- Our Values -->
        <section class="featured-section">
            <h2>Our Core Values</h2>
            <div class="features-grid" style="margin-top: 2rem;">
                <div class="feature">
                    <i class="fas fa-shield-alt"></i>
                    <h3>Trust & Transparency</h3>
                    <p>We believe in complete transparency. No hidden charges, no surprises. All information is verified and authentic.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-hands-helping"></i>
                    <h3>Community First</h3>
                    <p>We're building a community where property owners and seekers interact respectfully and fairly.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-rocket"></i>
                    <h3>Innovation</h3>
                    <p>We continuously improve our platform with user feedback and the latest technology to serve you better.</p>
                </div>
                <div class="feature">
                    <i class="fas fa-heart"></i>
                    <h3>Social Responsibility</h3>
                    <p>We're committed to making housing accessible and affordable for all students and newcomers.</p>
                </div>
            </div>
        </section>
        
        <!-- Why Choose Us -->
        <section class="featured-section">
            <h2>Why Choose FlatFinder?</h2>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
                <div style="padding: 2rem; background: var(--bg-light); border-radius: 12px; border-left: 4px solid var(--primary-color);">
                    <h3><i class="fas fa-ban"></i> Broker-Free Platform</h3>
                    <p>Direct connection between owners and seekers. Save up to 50% on broker commissions.</p>
                </div>
                <div style="padding: 2rem; background: var(--bg-light); border-radius: 12px; border-left: 4px solid var(--primary-color);">
                    <h3><i class="fas fa-lock"></i> Verified Listings</h3>
                    <p>Every property is verified for authenticity, location accuracy, and legal compliance.</p>
                </div>
                <div style="padding: 2rem; background: var(--bg-light); border-radius: 12px; border-left: 4px solid var(--primary-color);">
                    <h3><i class="fas fa-user-check"></i> Verified Users</h3>
                    <p>All users undergo verification to ensure safety and reduce fraudulent activities.</p>
                </div>
                <div style="padding: 2rem; background: var(--bg-light); border-radius: 12px; border-left: 4px solid var(--primary-color);">
                    <h3><i class="fas fa-headset"></i> 24/7 Support</h3>
                    <p>Our dedicated support team is always ready to assist you with any queries.</p>
                </div>
            </div>
        </section>
        
        <!-- Team Section -->
        <section class="featured-section">
            <h2>Meet Our Team</h2>
            <p style="text-align: center; color: var(--text-light); margin-bottom: 2rem; font-size: 16px;">
                Passionate individuals working together to transform the rental housing experience
            </p>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; margin-top: 2rem;">
                <div style="text-align: center; padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm);">
                    <div style="width: 100px; height: 100px; background: var(--primary-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: white; font-size: 40px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3>Founder & CEO</h3>
                    <p class="text-muted">Visionary leader with passion for solving real-world problems</p>
                </div>
                <div style="text-align: center; padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm);">
                    <div style="width: 100px; height: 100px; background: var(--accent-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: white; font-size: 40px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3>Head of Technology</h3>
                    <p class="text-muted">Tech expert ensuring smooth platform operations</p>
                </div>
                <div style="text-align: center; padding: 2rem; background: var(--bg-white); border-radius: 12px; box-shadow: var(--shadow-sm);">
                    <div style="width: 100px; height: 100px; background: var(--success-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: white; font-size: 40px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3>Customer Support Lead</h3>
                    <p class="text-muted">Dedicated to ensuring customer satisfaction</p>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="featured-section" style="background: linear-gradient(135deg, var(--primary-color), #45a049); border-radius: 12px; padding: 3rem; text-align: center; color: white;">
            <h2 style="color: white; margin-bottom: 1rem;">Ready to Find Your Perfect Room?</h2>
            <p style="color: rgba(255,255,255,0.9); margin-bottom: 2rem; font-size: 16px;">
                Join thousands of satisfied users who found their dream room through FlatFinder
            </p>
            <a href="<%= request.getContextPath() %>/property/all" class="btn btn-outline" style="border-color: white; color: white; background: transparent;">
                Browse Properties <i class="fas fa-arrow-right"></i>
            </a>
        </section>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>
