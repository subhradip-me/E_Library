package com.example.e_library.repository;

import com.example.e_library.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Integer> {
    
    // Find ratings by book ID
    List<Rating> findByBookId(Integer bookId);
    
    // Find rating by book ID and user name (to check if user already rated)
    Optional<Rating> findByBookIdAndUserName(Integer bookId, String userName);
    
    // Calculate average rating for a book
    @Query("SELECT AVG(r.rating) FROM Rating r WHERE r.bookId = :bookId")
    Double getAverageRatingByBookId(@Param("bookId") Integer bookId);
    
    // Count total ratings for a book
    long countByBookId(Integer bookId);
    
    // Get rating distribution for a book
    @Query("SELECT r.rating, COUNT(r) FROM Rating r WHERE r.bookId = :bookId GROUP BY r.rating ORDER BY r.rating DESC")
    List<Object[]> getRatingDistributionByBookId(@Param("bookId") Integer bookId);
    
    // Save rating using native SQL to avoid constructor issues
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO ratings (rating, user_name, book_reference_id, created_at, updated_at) VALUES (?1, ?2, ?3, NOW(), NOW())", nativeQuery = true)
    void saveRatingWithSQL(Integer rating, String userName, Integer bookId);
}
