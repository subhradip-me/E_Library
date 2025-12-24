package com.example.e_library.controller;

import com.example.e_library.model.Book;
import com.example.e_library.model.Category;
import com.example.e_library.model.Review;
import com.example.e_library.model.User;
import com.example.e_library.repository.BookRepository;
import com.example.e_library.repository.CategoryRepository;
import com.example.e_library.service.ReviewRatingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
public class ReaderController {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ReviewRatingService reviewRatingService;

    @GetMapping("/home")
    public String home(HttpSession session, Model model, 
                      @RequestParam(defaultValue = "0") int page,
                      @RequestParam(defaultValue = "12") int size,
                      @RequestParam(required = false) String search,
                      @RequestParam(required = false) String categoryFilter) {
        
        // Get logged-in user from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        // Get all categories for the filter dropdown
        List<Category> categories = categoryRepository.findAll();
        model.addAttribute("categories", categories);
        
        // Create pageable object
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        
     // Most Read — Top 10 published
        List<Book> mostReadBooks = bookRepository.findTop10ByStatusOrderByClickCountDesc("published");
        model.addAttribute("mostReadBooks", mostReadBooks);
        
        // Get books based on filters
        Page<Book> booksPage;
        if (search != null && !search.trim().isEmpty()) {
            // If there's a search term, filter by it
            booksPage = bookRepository.findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCase(
                search.trim(), search.trim(), pageable);
            model.addAttribute("searchTerm", search);
        } else if (categoryFilter != null && !categoryFilter.isEmpty()) {
            // If there's a category filter, filter by category
            Optional<Category> category = categoryRepository.findById(Integer.parseInt(categoryFilter));
            if (category.isPresent()) {
                booksPage = bookRepository.findByCategory(category.get(), pageable);
                model.addAttribute("selectedCategory", category.get());
            } else {
                booksPage = bookRepository.findByStatus("published", pageable);
            }
        } else {
            // Get all published books
            booksPage = bookRepository.findByStatus("published", pageable);
        }
        
        model.addAttribute("books", booksPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", booksPage.getTotalPages());
        model.addAttribute("totalElements", booksPage.getTotalElements());
        model.addAttribute("hasNext", booksPage.hasNext());
        model.addAttribute("hasPrevious", booksPage.hasPrevious());
        
        // Get featured books (latest 6 books)
        List<Book> featuredBooks = bookRepository.findTop6ByStatusOrderByCreatedAtDesc("published");
        model.addAttribute("featuredBooks", featuredBooks);
        
        // Get premium books (top 4 premium books)
        List<Book> premiumBooks = bookRepository.findTop4ByPremiumTrueAndStatusOrderByCreatedAtDesc("published");
        model.addAttribute("premiumBooks", premiumBooks);
        
        // Get recently added books (top 4 recently added books)
        List<Book> recentlyAddedBooks = bookRepository.findTop4ByStatusOrderByCreatedAtDesc("published");
        model.addAttribute("recentlyAddedBooks", recentlyAddedBooks);
        
        return "reader/home";
    }
	
    @GetMapping("/book/{id}")
    public String book(@PathVariable Integer id, HttpSession session, Model model) {
        // Get logged-in user from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        Optional<Book> bookOptional = bookRepository.findById(id);
        if (bookOptional.isPresent()) {
            Book book = bookOptional.get();

            book.setClickCount(book.getClickCount() + 1);
            bookRepository.save(book);

            model.addAttribute("book", book);

            // Get reviews for this book
            List<Review> reviews = reviewRatingService.getRecentReviewsByBookId(id);
            model.addAttribute("reviews", reviews);
            
            // Get review count
            long reviewCount = reviewRatingService.getReviewCountByBookId(id);
            model.addAttribute("reviewCount", reviewCount);
            
            // Get rating information
            Double averageRating = reviewRatingService.getAverageRating(id);
            long ratingCount = reviewRatingService.getRatingCountByBookId(id);
            model.addAttribute("averageRating", averageRating);
            model.addAttribute("ratingCount", ratingCount);
            
            // Get rating distribution
            List<Object[]> ratingDistribution = reviewRatingService.getRatingDistribution(id);
            model.addAttribute("ratingDistribution", ratingDistribution);

            // related books
            if (book.getCategory() != null) {
                List<Book> relatedBooks = bookRepository.findTop6ByCategoryAndIdNotAndStatus(
                        book.getCategory(), id, "published");

                model.addAttribute("relatedBooks", relatedBooks);
            }

            return "reader/book";
        } else {
            return "redirect:/error";
        }
    }
    
    @GetMapping("/book")
    public String bookRedirect() {
        return "redirect:/home";
    }
	
    @GetMapping("/category")
    public String categoryList(HttpSession session, Model model) {
        // Get logged-in user from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        List<Category> categories = categoryRepository.findAll();
        model.addAttribute("categories", categories);
        
        // Get book count for each category
        for (Category category : categories) {
            long bookCount = bookRepository.countByCategoryAndStatus(category, "published");
            category.setDescription(category.getDescription() + " (" + bookCount + " books)");
        }
        
        return "reader/category";
    }
    
    @GetMapping("/category/{id}")
    public String categoryBooks(@PathVariable Integer id, HttpSession session, Model model,
                               @RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "12") int size) {
        
        // Get logged-in user from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        Optional<Category> categoryOptional = categoryRepository.findById(id);
        if (categoryOptional.isPresent()) {
            Category category = categoryOptional.get();
            model.addAttribute("category", category);
            
            // Get books in this category with pagination
            Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
            Page<Book> booksPage = bookRepository.findByCategoryAndStatus(category, "published", pageable);
            
            model.addAttribute("books", booksPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", booksPage.getTotalPages());
            model.addAttribute("totalElements", booksPage.getTotalElements());
            model.addAttribute("hasNext", booksPage.hasNext());
            model.addAttribute("hasPrevious", booksPage.hasPrevious());
            
            return "reader/category";
        } else {
            return "redirect:/category";
        }
    }

    @PostMapping("/book/{id}/review")
    public String submitReview(@PathVariable Integer id, 
                             @RequestParam String content,
                             @RequestParam String reviewerName,
                             RedirectAttributes redirectAttributes) {
        try {
            // Use service to create and save review
            reviewRatingService.saveNewReview(content, reviewerName, id);
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/book/" + id;
    }

    @PostMapping("/book/{id}/rating")
    public String submitRating(@PathVariable Integer id,
                              @RequestParam Integer rating,
                              @RequestParam String userName,
                              RedirectAttributes redirectAttributes) {
        try {
            if (rating >= 1 && rating <= 5) {
                reviewRatingService.saveNewRating(rating, userName, id);
                redirectAttributes.addFlashAttribute("success", "Rating submitted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5 stars.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit rating: " + e.getMessage());
        }
        return "redirect:/book/" + id;
    }

    @GetMapping("/book/{id}/reviews")
    public String getAllReviews(@PathVariable Integer id, 
                               @RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "10") int size,
                               Model model) {
        
        Optional<Book> bookOptional = bookRepository.findById(id);
        if (bookOptional.isPresent()) {
            Book book = bookOptional.get();
            model.addAttribute("book", book);

            // Get paginated reviews
            Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
            Page<Review> reviewsPage = reviewRatingService.getReviewsByBookId(id, pageable);
            
            model.addAttribute("reviews", reviewsPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", reviewsPage.getTotalPages());
            model.addAttribute("totalElements", reviewsPage.getTotalElements());
            model.addAttribute("hasNext", reviewsPage.hasNext());
            model.addAttribute("hasPrevious", reviewsPage.hasPrevious());

            return "reader/reviews";
        } else {
            return "redirect:/error";
        }
    }
}
