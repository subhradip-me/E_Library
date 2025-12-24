package com.example.e_library.repository;

import com.example.e_library.model.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    
    // Find reviews by book ID
    List<Review> findByBookIdOrderByCreatedAtDesc(Integer bookId);
    
    // Find reviews by book ID with pagination
    Page<Review> findByBookIdOrderByCreatedAtDesc(Integer bookId, Pageable pageable);
    
    // Count reviews by book ID
    long countByBookId(Integer bookId);
    
    // Find recent reviews for a book
    List<Review> findTop3ByBookIdOrderByCreatedAtDesc(Integer bookId);
    
    // Find reviews by reviewer name
    List<Review> findByReviewerNameOrderByCreatedAtDesc(String reviewerName);
    
    // Save review using native SQL to avoid constructor issues
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO reviews (content, reviewer_name, book_reference_id, created_at, updated_at) VALUES (?1, ?2, ?3, NOW(), NOW())", nativeQuery = true)
    void saveReviewWithSQL(String content, String reviewerName, Integer bookId);
}
