package com.example.e_library.config;

import com.example.e_library.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthenticationInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        
        String uri = request.getRequestURI();
        
        // Check if accessing reader pages
        if (uri.startsWith("/home") || uri.startsWith("/book") || uri.startsWith("/category") 
            || uri.startsWith("/checkout") || uri.startsWith("/orderdetails") 
            || uri.startsWith("/order") || uri.startsWith("/subscription")) {
            
            if (loggedInUser == null) {
                // Not logged in, redirect to login page
                response.sendRedirect("/login?error=Please login to access this page");
                return false;
            }
            
            // Check if user is a reader (not admin)
            if ("admin".equals(loggedInUser.getRole())) {
                response.sendRedirect("/admin");
                return false;
            }
        }
        
        // Check if accessing admin pages
        if (uri.startsWith("/admin")) {
            if (loggedInUser == null) {
                response.sendRedirect("/login?error=Please login to access admin panel");
                return false;
            }
            
            // Check if user is an admin
            if (!"admin".equals(loggedInUser.getRole())) {
                response.sendRedirect("/home");
                return false;
            }
        }
        
        return true;
    }
}
