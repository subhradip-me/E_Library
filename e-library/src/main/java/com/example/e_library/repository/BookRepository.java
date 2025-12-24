package com.example.e_library.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.e_library.model.Book;
import com.example.e_library.model.Category;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Integer> {
    
    // Find books by status with pagination
    Page<Book> findByStatus(String status, Pageable pageable);
    
    // Find books by title or author containing search term (case insensitive)
    Page<Book> findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCase(
        String title, String author, Pageable pageable);
    
    // Find books by category with pagination
    Page<Book> findByCategory(Category category, Pageable pageable);
    
    // Find books by category and status with pagination
    Page<Book> findByCategoryAndStatus(Category category, String status, Pageable pageable);
    
    // Find top 6 books by status ordered by creation date (featured books)
    List<Book> findTop6ByStatusOrderByCreatedAtDesc(String status);
    
    // Find top 6 related books by category excluding current book
    List<Book> findTop6ByCategoryAndIdNotAndStatusOrderByCreatedAtDesc(
        Category category, Integer excludeId, String status);
    
    // Count books by category and status
    long countByCategoryAndStatus(Category category, String status);
    
    // Top 10 most-read overall (published only)
    List<Book> findTop10ByStatusOrderByClickCountDesc(String status);

    // Top 10 most-read inside a category (published only)
    List<Book> findTop10ByCategoryAndStatusOrderByClickCountDesc(Category category, String status);

    // Find top 4 premium books by status
    List<Book> findTop4ByPremiumTrueAndStatusOrderByCreatedAtDesc(String status);
    
    // Find top 4 recently added books by status
    List<Book> findTop4ByStatusOrderByCreatedAtDesc(String status);

	List<Book> findTop6ByCategoryAndIdNotAndStatus(Category category, Integer id, String string);

}


