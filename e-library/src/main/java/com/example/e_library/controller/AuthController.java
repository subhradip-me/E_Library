package com.example.e_library.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.e_library.model.User;
import com.example.e_library.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @PostMapping("/register")
    public String regProcess(
            @RequestParam String fullname,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam("confirm-password") String confirmPass,
            @RequestParam(value = "terms", required = false) String terms,
            ModelMap model) {

        try {
            // Validation
            if (fullname == null || fullname.trim().isEmpty()) {
                model.put("error", "Full name is required!");
                return "register";
            }

            if (email == null || email.trim().isEmpty()) {
                model.put("error", "Email is required!");
                return "register";
            }

            if (password == null || password.length() < 6) {
                model.put("error", "Password must be at least 6 characters!");
                return "register";
            }

            if (!password.equals(confirmPass)) {
                model.put("error", "Passwords do not match!");
                return "register";
            }

            // Check if terms checkbox is checked
            if (terms == null) {
                model.put("error", "You must accept the Terms of Service to register.");
                return "register";
            }

            // Check if email already exists
            if (userRepository.existsByEmail(email.trim().toLowerCase())) {
                model.put("error", "Email already exists!");
                return "register";
            }

            // Create new user
            User user = new User();
            user.setFullname(fullname.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPassword(password); // TODO: Hash password in production
            user.setRole("reader");
            user.setEnabled(true);

            userRepository.save(user);

            model.put("msg", "Successfully Registered! Please login to continue.");
            return "login";

        } catch (Exception e) {
            e.printStackTrace();
            model.put("error", "Registration failed. Please try again.");
            return "register";
        }
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginProcess(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam(value = "remember", required = false) String remember,
            HttpSession session,
            ModelMap model) {

        try {
            if (email == null || email.trim().isEmpty()) {
                model.put("error", "Email is required!");
                return "login";
            }

            if (password == null || password.trim().isEmpty()) {
                model.put("error", "Password is required!");
                return "login";
            }

            // Find user by email
            var userOptional = userRepository.findByEmail(email.trim().toLowerCase());
            
            if (userOptional.isEmpty()) {
                model.put("error", "Invalid email or password!");
                return "login";
            }

            User user = userOptional.get();

            // Check password (in production, compare hashed passwords)
            if (!user.getPassword().equals(password)) {
                model.put("error", "Invalid email or password!");
                return "login";
            }

            // Check if user is enabled
            if (!user.isEnabled()) {
                model.put("error", "Account is disabled. Please contact support.");
                return "login";
            }

            // Successful login - store user in session
            session.setAttribute("loggedInUser", user);
            
            if ("admin".equals(user.getRole())) {
                return "redirect:/admin";
            } else {
                return "redirect:/home";
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("error", "Login failed. Please try again.");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}