package com.example.e_library.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.*;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.e_library.model.Book;
import com.example.e_library.model.Category;
import com.example.e_library.model.User;
import com.example.e_library.repository.BookRepository;
import com.example.e_library.repository.CategoryRepository;
import com.example.e_library.service.UserService;

@Controller
public class AdminController {

    private final BookRepository bookRepo;
    
    @Autowired
    private CategoryRepository categoryRepo;
    
    @Autowired
    private UserService userService;
    
    private final Path uploadBase;

    public AdminController(BookRepository bookRepo) {
        this.bookRepo = bookRepo;
        // Save to static/uploads within the application for web accessibility
        this.uploadBase = Paths.get("src/main/resources/static/uploads");
        try {
            Files.createDirectories(uploadBase);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory!", e);
        }
    }
    
    @GetMapping("/admin")
    public String Admin(HttpSession session, Model model){
        // Get logged-in admin from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);

        // Populate dashboard statistics
        populateDashboardStats(model);
        
        // Populate admin activities
        populateAdminActivities(model);
        
        // Populate recent user activities
        populateRecentActivities(model);
        
        // Populate system status
        populateSystemStatus(model);
        
        // Add maintenance message
        model.addAttribute("maintenanceMessage", "System backup scheduled for tonight at 2:00 AM EST");

    	return "admin/dashboard"; // Returns admin.jsp
    }

    private void populateDashboardStats(Model model) {
        // Replace these with actual service calls to get real data
        
        // Total Users
        model.addAttribute("totalUsers", getTotalUsers());
        model.addAttribute("userGrowthPercent", getUserGrowthPercent());
        
        // Total Books
        model.addAttribute("totalBooks", getTotalBooks());
        model.addAttribute("newBooksThisWeek", getNewBooksThisWeek());
        
        // Active Sessions
        model.addAttribute("activeSessions", getActiveSessions());
        
        // New Registrations Today
        model.addAttribute("newRegistrationsToday", getNewRegistrationsToday());
    }

    private void populateAdminActivities(Model model) {
        List<Map<String, Object>> adminActivities = new ArrayList<>();
        
        // Create sample admin activities
        Map<String, Object> activity1 = new HashMap<>();
        activity1.put("iconColor", "blue");
        activity1.put("iconPath", "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253\"/>");
        activity1.put("title", "Books Added");
        activity1.put("description", "245 new books added to the library");
        activity1.put("timeAgo", "Today");
        adminActivities.add(activity1);
        
        Map<String, Object> activity2 = new HashMap<>();
        activity2.put("iconColor", "green");
        activity2.put("iconPath", "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z\"/>");
        activity2.put("title", "User Management");
        activity2.put("description", "156 user accounts reviewed and updated");
        activity2.put("timeAgo", "Yesterday");
        adminActivities.add(activity2);
        
        Map<String, Object> activity3 = new HashMap<>();
        activity3.put("iconColor", "purple");
        activity3.put("iconPath", "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z\"/>");
        activity3.put("title", "System Analytics");
        activity3.put("description", "Generated monthly performance reports");
        activity3.put("timeAgo", "2 days ago");
        adminActivities.add(activity3);
        
        model.addAttribute("adminActivities", adminActivities);
    }

    private void populateRecentActivities(Model model) {
        List<Map<String, Object>> recentActivities = new ArrayList<>();
        
        // Create sample recent user activities
        Map<String, Object> activity1 = new HashMap<>();
        activity1.put("color", "blue");
        activity1.put("initials", "JD");
        activity1.put("description", "John Doe borrowed \"The Great Gatsby\"");
        activity1.put("timeAgo", "2 minutes ago");
        recentActivities.add(activity1);
        
        Map<String, Object> activity2 = new HashMap<>();
        activity2.put("color", "green");
        activity2.put("initials", "AS");
        activity2.put("description", "Alice Smith returned \"To Kill a Mockingbird\"");
        activity2.put("timeAgo", "5 minutes ago");
        recentActivities.add(activity2);
        
        Map<String, Object> activity3 = new HashMap<>();
        activity3.put("color", "purple");
        activity3.put("initials", "MB");
        activity3.put("description", "Mike Brown registered new account");
        activity3.put("timeAgo", "10 minutes ago");
        recentActivities.add(activity3);
        
        Map<String, Object> activity4 = new HashMap<>();
        activity4.put("color", "orange");
        activity4.put("initials", "EJ");
        activity4.put("description", "Emma Johnson rated \"1984\" 5 stars");
        activity4.put("timeAgo", "15 minutes ago");
        recentActivities.add(activity4);
        
        Map<String, Object> activity5 = new HashMap<>();
        activity5.put("color", "red");
        activity5.put("initials", "DW");
        activity5.put("description", "David Wilson requested book extension");
        activity5.put("timeAgo", "20 minutes ago");
        recentActivities.add(activity5);
        
        model.addAttribute("recentActivities", recentActivities);
    }

    private void populateSystemStatus(Model model) {
        Map<String, String> systemStatus = new HashMap<>();
        systemStatus.put("database", "Operational");
        systemStatus.put("apiServices", "Operational");
        systemStatus.put("fileStorage", "Maintenance");
        systemStatus.put("searchEngine", "Operational");
        
        model.addAttribute("systemStatus", systemStatus);
    }

    // Private methods to simulate data retrieval
    // Replace these with actual service calls
    
    private Integer getTotalUsers() {
        return (int) userService.getTotalUserCount();
    }
    
    private Double getUserGrowthPercent() {
        // Replace with: return userService.getGrowthPercentage();
        return 12.5;
    }
    
    private Integer getTotalBooks() {
        // Get actual count from your repository
        return (int) bookRepo.count();
    }
    
    private Integer getNewBooksThisWeek() {
        // Replace with actual logic to count books added this week
        return 245;
    }
    
    private Integer getActiveSessions() {
        // Replace with: return sessionService.getActiveSessionCount();
        return 1234;
    }
    
    private Integer getNewRegistrationsToday() {
        // Replace with: return userService.getNewRegistrationsToday();
        return 89;
    }

    // Book Management Methods

    @GetMapping("/admin/books/add")
    public String showBookAdd(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        model.addAttribute("categories", categoryRepo.findAll());
        return "admin/books/add-book";
    }

    @PostMapping(path = "/admin/books/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String bookAdd(
            @RequestParam String title,
            @RequestParam String author,
            @RequestParam Integer categoryId,
            @RequestParam(value = "publication_year", required = false) Integer publicationYear,
            @RequestParam(required = false) Integer pages,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String availability,
            @RequestParam(required = false) String tags,
            @RequestParam(value = "premium", required = false, defaultValue = "false") boolean premium,
            @RequestParam(value = "pdf-upload", required = false) MultipartFile pdfFile,
            @RequestParam(value = "cover-upload", required = false) MultipartFile coverFile
    ) throws IOException {

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        Category cat = categoryRepo.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        book.setCategory(cat);

        book.setYear(publicationYear); // Integer allows null
        book.setPages(pages != null ? pages : 0);
        book.setSummary(description != null ? description : "");
        book.setStatus(status != null ? status : "draft");
        book.setAvailability(availability != null ? availability : "available");
        book.setTags(tags != null ? tags : "");
        book.setPremium(premium);

        if (pdfFile != null && !pdfFile.isEmpty()) {
            String pdfUrl = saveFile(pdfFile, "pdfs");
            book.setPdfUrl(pdfUrl);
        }
        if (coverFile != null && !coverFile.isEmpty()) {
            String coverUrl = saveFile(coverFile, "covers");
            book.setCover(coverUrl);
        }

        bookRepo.save(book);
        return "redirect:/admin/books/add";
    }

    private String saveFile(MultipartFile file, String subfolder) throws IOException {
        Files.createDirectories(uploadBase.resolve(subfolder));
        String original = Paths.get(file.getOriginalFilename()).getFileName().toString();
        String filename = System.currentTimeMillis() + "_" + original.replaceAll("\\s+", "_");
        Path target = uploadBase.resolve(subfolder).resolve(filename);
        try (InputStream in = file.getInputStream()) {
            Files.copy(in, target, StandardCopyOption.REPLACE_EXISTING);
        }
        // Return web-accessible path
        return subfolder + "/" + filename;
    }

    @GetMapping("/admin/books/edit/{id}")
    public String showEdit(@PathVariable int id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        Book book = bookRepo.findById(id).orElse(null);

        if (book == null) {
            return "redirect:/admin/books"; // safety redirect
        }

        model.addAttribute("book", book);
        model.addAttribute("categories", categoryRepo.findAll());
        return "admin/books/edit-book";   // JSP file name
    }

    @PostMapping("/admin/books/edit/{id}")
    public String updateBook(
            @PathVariable int id,
            @RequestParam String title,
            @RequestParam String author,
            @RequestParam Integer categoryId,
            @RequestParam(name="publication_year", required=false) Integer year,
            @RequestParam(required=false) Integer pages,
            @RequestParam(required=false) String description,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String availability,
            @RequestParam(required = false) String tags,
            @RequestParam(value = "premium", required = false, defaultValue = "false") boolean premium,
            @RequestParam(name="pdf-upload", required=false) MultipartFile pdf,
            @RequestParam(name="cover-upload", required=false) MultipartFile cover
    ) throws IOException {

        Book book = bookRepo.findById(id).orElse(null);

        book.setTitle(title);
        book.setAuthor(author);
        Category cat = categoryRepo.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        book.setCategory(cat);

        book.setYear(year);
        book.setPages(pages);
        book.setSummary(description);
        book.setStatus(status);
        book.setAvailability(availability);
        book.setTags(tags);
        book.setPremium(premium);

        if (pdf != null && !pdf.isEmpty()) {
            book.setPdfUrl(saveFile(pdf, "pdfs"));
        }

        if (cover != null && !cover.isEmpty()) {
            book.setCover(saveFile(cover, "covers"));
        }

        bookRepo.save(book);
        return "redirect:/admin/books";
    }

    @GetMapping("/admin/books")
    public String bookManage(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        List<Book> book = bookRepo.findAll();
        model.addAttribute("bookdata", book);
        return "admin/books/manage-books";
    }

    @GetMapping("/admin/books/delete/{id}")
    public String deleteBook(@PathVariable int id) {
        bookRepo.deleteById(id);
        return "redirect:/admin/books";
    }
    
    
    // User Management Endpoints
    
    @GetMapping("/admin/users")
    public String manageUsers(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String role,
            @RequestParam(required = false) String status,
            HttpSession session,
            Model model) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        
        List<User> users;
        
        // Apply filters
        if (search != null && !search.isEmpty()) {
            users = userService.searchUsers(search);
        } else if (role != null && !role.isEmpty() && !"all".equals(role)) {
            users = userService.filterUsersByRole(role);
        } else if (status != null && !status.isEmpty() && !"all".equals(status)) {
            users = userService.filterUsersByStatus(status);
        } else {
            users = userService.getAllUsers();
        }
        
        // Add statistics
        model.addAttribute("users", users);
        model.addAttribute("totalUsers", userService.getTotalUserCount());
        model.addAttribute("activeUsers", userService.getActiveUsersCount());
        model.addAttribute("inactiveUsers", userService.getInactiveUsersCount());
        model.addAttribute("adminCount", userService.getUsersCountByRole("admin"));
        model.addAttribute("readerCount", userService.getUsersCountByRole("reader"));
        
        // Keep filter values
        model.addAttribute("searchQuery", search);
        model.addAttribute("selectedRole", role);
        model.addAttribute("selectedStatus", status);
        
        return "admin/manage-user";
    }
    
    @PostMapping("/admin/users/toggle-status/{id}")
    public String toggleUserStatus(@PathVariable int id) {
        userService.toggleUserStatus(id);
        return "redirect:/admin/users";
    }
    
    @PostMapping("/admin/users/update-role/{id}")
    public String updateUserRole(@PathVariable int id, @RequestParam String role) {
        userService.updateUserRole(id, role);
        return "redirect:/admin/users";
    }
    
    @PostMapping("/admin/users/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        userService.deleteUser(id);
        return "redirect:/admin/users";
    }
    
    @GetMapping("/admin/users/edit/{id}")
    public String editUser(@PathVariable int id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        Optional<User> userOpt = userService.getUserById(id);
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            return "admin/edit-user";
        }
        return "redirect:/admin/users";
    }
    
    @PostMapping("/admin/users/edit/{id}")
    public String updateUser(
            @PathVariable int id,
            @RequestParam String fullname,
            @RequestParam String email,
            @RequestParam String role,
            @RequestParam(required = false) boolean enabled) {
        
        Optional<User> userOpt = userService.getUserById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setFullname(fullname);
            user.setEmail(email);
            user.setRole(role);
            user.setEnabled(enabled);
            userService.saveUser(user);
        }
        
        return "redirect:/admin/users";
    }
    
    // Settings Endpoints
    
    @GetMapping("/admin/settings")
    public String adminSettings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", loggedInUser);
        // Add current settings data
        model.addAttribute("totalBooks", bookRepo.count());
        model.addAttribute("totalUsers", userService.getTotalUserCount());
        model.addAttribute("totalCategories", categoryRepo.count());
        
        return "admin/settings";
    }
    
    @PostMapping("/admin/settings/update")
    public String updateSettings(
            @RequestParam(required = false) String siteName,
            @RequestParam(required = false) String siteDescription,
            @RequestParam(required = false) String adminEmail,
            @RequestParam(required = false) Integer booksPerPage,
            @RequestParam(required = false) boolean maintenanceMode,
            @RequestParam(required = false) boolean userRegistration,
            HttpSession session,
            Model model) {
        
        // In a real application, you would save these settings to a database
        // For now, we'll just add a success message
        model.addAttribute("successMessage", "Settings updated successfully!");
        
        // Reload settings page with updated data
        return adminSettings(session, model);
    }
}
