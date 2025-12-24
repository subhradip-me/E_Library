package com.example.e_library.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "books")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 512)
    private String title;

    @Column(nullable = false, length = 256)
    private String author;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    // Use Integer to allow null (no year provided)
    private Integer year;

    private Integer pages;

    @Lob
    @Column(length = 8192)
    private String summary; // long description

    @Column(length = 1024)
    private String cover;   // path/URL to cover image

    @Column(length = 1024)
    private String pdfUrl;  // path/URL to PDF file

    @Column(length = 512)
    private String tags;    // comma-separated tags (or change to ElementCollection for normalized design)

    @Column(length = 50)
    private String status;  // draft / published / archived

    @Column(length = 50)
    private String availability; // available / restricted
    
    @Column(nullable = false)
    private boolean premium = false; // premium content requiring subscription
    
    @Column(nullable = false)
    private Long clickCount = 0L;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Book() {}

    // convenience constructor (omit files/long fields if not needed)
    public Book(Integer id, String title, String author, Category category,
                Integer year, Integer pages, String summary, String cover,
                String pdfUrl, String tags, String status, String availability, boolean premium, Long clickCount) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.year = year;
        this.pages = pages;
        this.summary = summary;
        this.cover = cover;
        this.pdfUrl = pdfUrl;
        this.tags = tags;
        this.status = status;
        this.availability = availability;
        this.premium = premium;
        this.clickCount = clickCount;
        
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = createdAt;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // --- getters & setters ---

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }

    public Integer getYear() { return year; }
    public void setYear(Integer year) { this.year = year; }

    public Integer getPages() { return pages; }
    public void setPages(Integer pages) { this.pages = pages; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getCover() { return cover; }
    public void setCover(String cover) { this.cover = cover; }

    public String getPdfUrl() { return pdfUrl; }
    public void setPdfUrl(String pdfUrl) { this.pdfUrl = pdfUrl; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
    
    public boolean isPremium() { return premium; }
    public void setPremium(boolean premium) { this.premium = premium; }
    
    public Long getClickCount() { return clickCount; }
    public void setClickCount(Long clickCount) { this.clickCount = clickCount; }
    
    

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

}
