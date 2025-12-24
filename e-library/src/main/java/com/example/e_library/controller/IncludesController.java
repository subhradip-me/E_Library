package com.example.e_library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IncludesController {
	// Admin includes
	
	@GetMapping("/sidebar")
	public String Sidebar() {
		return "/includes/admin/sidebar";
	}
	
	
	
	
	// Reader includes
	@GetMapping("/header")
    public String Header() {
    	return "/includes/reader/header";
	}
}

