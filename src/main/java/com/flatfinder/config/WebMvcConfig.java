package com.flatfinder.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(
            org.springframework.web.servlet.config.annotation.ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AdminAccessInterceptor())
                .addPathPatterns("/admin/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/", "classpath:/static/css/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/admin-css/**")
                .addResourceLocations("/admin-css/", "classpath:/static/admin-css/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/", "classpath:/static/js/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/admin-js/**")
                .addResourceLocations("/admin-js/", "classpath:/static/admin-js/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/Images/**")
                .addResourceLocations("/Images/", "classpath:/static/Images/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/", "classpath:/static/images/")
                .setCachePeriod(3600);

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("/uploads/", "classpath:/static/uploads/")
                .setCachePeriod(0);

        registry.addResourceHandler("/fonts/**")
                .addResourceLocations("/fonts/", "classpath:/static/fonts/")
                .setCachePeriod(3600);
    }
}
