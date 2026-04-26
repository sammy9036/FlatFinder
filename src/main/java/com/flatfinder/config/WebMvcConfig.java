package com.flatfinder.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 * WebMvcConfig - Configure Spring to serve static resources (CSS, JS, images)
 * This is important for serving CSS, JavaScript, and image files from the static folders
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    
    /**
     * Configure view resolvers to handle JSP files properly
     */
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }
    
    /**
     * Register admin access interceptor
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AdminAccessInterceptor())
                .addPathPatterns("/admin/**");
    }
    
    /**
     * Register resource handlers to serve static content
     * Maps URLs to file system locations
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Handle CSS files
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/", "file:src/main/webapp/css/")
                .setCachePeriod(3600);
        
        // Handle JavaScript files
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/", "file:src/main/webapp/js/")
                .setCachePeriod(3600);
        
        // Handle images
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/", "file:src/main/webapp/images/")
                .setCachePeriod(3600);
        
        // Handle uploads folder (for user uploaded images) - property images stored on file system
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:src/main/webapp/uploads/")
                .setCachePeriod(0); // Don't cache uploads for fresh content
        
        // Handle admin dashboard CSS
        registry.addResourceHandler("/admin-css/**")
                .addResourceLocations("file:src/main/webapp/admin-css/")
                .setCachePeriod(3600);
        
        // Handle admin dashboard JS
        registry.addResourceHandler("/admin-js/**")
                .addResourceLocations("file:src/main/webapp/admin-js/")
                .setCachePeriod(3600);
        
        // Handle fonts
        registry.addResourceHandler("/fonts/**")
                .addResourceLocations("classpath:/static/fonts/", "file:src/main/webapp/fonts/")
                .setCachePeriod(3600);
    }
}
