<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <!-- Modern Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <!-- About Section -->
                <div class="footer-section">
                    <h3><i class="fas fa-home"></i> FlatFinder</h3>
                    <p>FlatFinder is a broker-free room rental platform connecting students and newcomers directly with property owners. Save time, money, and find your perfect space easily.</p>
                    <div class="social-links">
                        <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/">Home</a></li>
                        <li><a href="<%= request.getContextPath() %>/property/all">Browse Properties</a></li>
                        <li><a href="<%= request.getContextPath() %>/about">About Us</a></li>
                        <li><a href="<%= request.getContextPath() %>/contact">Contact Us</a></li>
                    </ul>
                </div>

                <!-- Legal -->
                <div class="footer-section">
                    <h3>Legal</h3>
                    <ul>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                        <li><a href="#">Disclaimer</a></li>
                        <li><a href="#">Cookie Policy</a></li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div class="footer-section">
                    <h3>Get in Touch</h3>
                    <p><i class="fas fa-map-marker-alt"></i> Pune, Maharashtra, India</p>
                    <p><i class="fas fa-phone"></i> +91 8788655768</p>
                    <p><i class="fas fa-envelope"></i> support@flatfinder.com</p>
                </div>
            </div>

            <!-- Footer Bottom -->
            <div class="footer-bottom">
                <p>&copy; 2024 FlatFinder - All Rights Reserved. | Built with <i class="fas fa-heart" style="color: #e74c3c;"></i> for Students</p>
            </div>
        </div>
    </footer>
