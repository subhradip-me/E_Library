package com.example.e_library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String index(Model model) {
	    model.addAttribute("pageName", "index");
	    return "index";
	}

	@GetMapping("/about")
	public String about(Model model) {
	    model.addAttribute("pageName", "about");
	    return "about";
	}

	
}
