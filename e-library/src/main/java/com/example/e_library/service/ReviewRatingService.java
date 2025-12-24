package com.example.e_library.service;

import com.example.e_library.model.Review;
import com.example.e_library.model.Rating;
import com.example.e_library.repository.ReviewRepository;
import com.example.e_library.repository.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewRatingService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private RatingRepository ratingRepository;

    // Review methods
    public Review saveReview(Review review) {
        return reviewRepository.save(review);
    }

    public List<Review> getReviewsByBookId(Integer bookId) {
        return reviewRepository.findByBookIdOrderByCreatedAtDesc(bookId);
    }

    public Page<Review> getReviewsByBookId(Integer bookId, Pageable pageable) {
        return reviewRepository.findByBookIdOrderByCreatedAtDesc(bookId, pageable);
    }

    public List<Review> getRecentReviewsByBookId(Integer bookId) {
        return reviewRepository.findTop3ByBookIdOrderByCreatedAtDesc(bookId);
    }

    public long getReviewCountByBookId(Integer bookId) {
        return reviewRepository.countByBookId(bookId);
    }

    public Optional<Review> getReviewById(Integer id) {
        return reviewRepository.findById(id);
    }

    public void deleteReview(Integer id) {
        reviewRepository.deleteById(id);
    }

    // Rating methods
    public Rating saveRating(Rating rating) {
        // Check if user has already rated this book
        Optional<Rating> existingRating = ratingRepository.findByBookIdAndUserName(
            rating.getBookId(), rating.getUserName());
        
        if (existingRating.isPresent()) {
            // Update existing rating
            Rating existing = existingRating.get();
            existing.setRating(rating.getRating());
            return ratingRepository.save(existing);
        } else {
            // Create new rating
            return ratingRepository.save(rating);
        }
    }

    public List<Rating> getRatingsByBookId(Integer bookId) {
        return ratingRepository.findByBookId(bookId);
    }

    public Double getAverageRating(Integer bookId) {
        Double avg = ratingRepository.getAverageRatingByBookId(bookId);
        return avg != null ? avg : 0.0;
    }

    public long getRatingCountByBookId(Integer bookId) {
        return ratingRepository.countByBookId(bookId);
    }

    public List<Object[]> getRatingDistribution(Integer bookId) {
        return ratingRepository.getRatingDistributionByBookId(bookId);
    }

    public Optional<Rating> getUserRating(Integer bookId, String userName) {
        return ratingRepository.findByBookIdAndUserName(bookId, userName);
    }

    public boolean hasUserRated(Integer bookId, String userName) {
        return ratingRepository.findByBookIdAndUserName(bookId, userName).isPresent();
    }

    // Helper method to create and save a new review (using repository directly)
    public void saveNewReview(String content, String reviewerName, Integer bookId) {
        // Use native SQL or repository save to avoid constructor issues
        reviewRepository.saveReviewWithSQL(content, reviewerName, bookId);
    }

    // Helper method to create and save a new rating
    public Rating saveNewRating(Integer rating, String userName, Integer bookId) {
        // Check if user has already rated this book
        Optional<Rating> existingRating = ratingRepository.findByBookIdAndUserName(bookId, userName);
        
        if (existingRating.isPresent()) {
            // Update existing rating
            Rating existing = existingRating.get();
            existing.setRating(rating);
            return ratingRepository.save(existing);
        } else {
            // Use SQL insert to avoid constructor issues
            ratingRepository.saveRatingWithSQL(rating, userName, bookId);
            // Return a basic rating object for response (could be null if needed)
            return null;
        }
    }
}
