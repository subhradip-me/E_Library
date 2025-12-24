package com.example.e_library.controller;

import com.example.e_library.model.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/subscription")
public class SubscriptionController {

    @Value("${razorpay.key.id}")
    private String razorpayKeyId;

    // Show subscription plans page
    @GetMapping
    public String showSubscriptionPlans(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        return "reader/subscription";
    }

    // Show checkout page with plan details
    @GetMapping("/checkout/{type}")
    public String showCheckout(
            @PathVariable String type,
            HttpSession session,
            Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);

        String planType = type.toUpperCase();
        int amount;

        if ("MONTHLY".equals(planType)) {
            amount = 199;
        } else if ("ANNUAL".equals(planType)) {
            amount = 1999;
        } else {
            return "redirect:/subscription";
        }

        model.addAttribute("planType", planType);
        model.addAttribute("amount", amount);

        return "reader/checkout";
    }

    // Process checkout and redirect to payment
    @PostMapping("/process")
    public String processCheckout(
            @RequestParam String planType,
            @RequestParam int amount,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String contact,
            HttpSession session,
            Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);

        // Store subscription details in session for after payment
        session.setAttribute("subscriptionType", planType);
        session.setAttribute("subscriptionAmount", amount);

        // Pass data to payment page
        model.addAttribute("custName", name);
        model.addAttribute("custEmail", email);
        model.addAttribute("custContact", contact);
        model.addAttribute("amount", amount);
        model.addAttribute("key", razorpayKeyId);

        return "reader/order";
    }
}
