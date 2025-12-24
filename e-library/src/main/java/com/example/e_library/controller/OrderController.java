package com.example.e_library.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.e_library.model.Subscription;
import com.example.e_library.model.User;
import com.example.e_library.repository.SubscriptionRepository;
import com.example.e_library.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Transactional
    @GetMapping("/orderdetails")
    public String orderDetails(
            @RequestParam("payment_id") String paymentId,
            HttpSession session,
            Model model) {

        // Get logged-in user from session
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);

        // Get subscription details from session
        String subscriptionType = (String) session.getAttribute("subscriptionType");
        Integer amount = (Integer) session.getAttribute("subscriptionAmount");

        if (subscriptionType == null) {
            return "redirect:/subscription";
        }

        // Fetch fresh user data from database
        user = userRepository
                .findById(user.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        LocalDate start = LocalDate.now();
        LocalDate end;

        // Calculate end date based on plan
        if ("MONTHLY".equalsIgnoreCase(subscriptionType)) {
            end = start.plusMonths(1);
        } else if ("ANNUAL".equalsIgnoreCase(subscriptionType)) {
            end = start.plusYears(1);
        } else {
            return "redirect:/subscription";
        }

        // Expire old active subscription
        subscriptionRepository
                .findByUserAndStatus(user, "ACTIVE")
                .ifPresent(sub -> {
                    sub.setStatus("EXPIRED");
                    subscriptionRepository.save(sub);
                });

        // ✅ Create new subscription
        Subscription sub = new Subscription();
        sub.setUser(user);
        sub.setType(subscriptionType);
        sub.setStartDate(start);
        sub.setEndDate(end);
        sub.setStatus("ACTIVE");

        subscriptionRepository.save(sub);

        // ✅ Update user flag
        user.setSubscribed(true);
        userRepository.save(user);
        
        // Update user in session with the latest data
        session.setAttribute("loggedInUser", user);

        // Clear session
        session.removeAttribute("subscriptionType");
        session.removeAttribute("subscriptionAmount");

        // Add success details to model
        model.addAttribute("paymentId", paymentId);
        model.addAttribute("planType", subscriptionType);
        model.addAttribute("amount", amount);
        model.addAttribute("startDate", start);
        model.addAttribute("endDate", end);

        return "reader/order-success";
    }
}
