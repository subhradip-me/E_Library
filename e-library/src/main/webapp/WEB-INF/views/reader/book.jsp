<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.e_library.model.Book" %>
<%@ page import="com.example.e_library.model.Category" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • <%= ((Book) request.getAttribute("book")).getTitle() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
        .playfair {
            font-family: 'Playfair Display', serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-orange-50 via-orange-50 to-white min-h-screen">
    
    <!-- Navigation Header -->
    <%@ include file="/WEB-INF/views/includes/reader/header.jsp" %>

    <!-- Breadcrumb -->
    <div class="bg-white border-b border-orange-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center gap-2 text-sm">
                <a href="/home" class="text-amber-600 hover:text-amber-700">Home</a>
                <span class="text-stone-400">/</span>
                <%
                    Book book = (Book) request.getAttribute("book");
                    if (book.getCategory() != null) {
                %>
                    <a href="/category/<%= book.getCategory().getId() %>" class="text-amber-600 hover:text-amber-700"><%= book.getCategory().getName() %></a>
                    <span class="text-stone-400">/</span>
                <%
                    } else {
                %>
                    <a href="/home" class="text-amber-600 hover:text-amber-700">Contemporary Fiction</a>
                    <span class="text-stone-400">/</span>
                <%
                    }
                %>
                <span class="text-stone-600">
                    <%= book.getTitle().length() > 30 ? book.getTitle().substring(0, 30) + "..." : book.getTitle() %>
                </span>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
            
            <!-- Book Cover & Actions (Left) -->
            <div class="md:col-span-1">
                <!-- Book Cover -->
                <%
                    if (book.getCover() != null && !book.getCover().trim().isEmpty()) {
                %>
                    <div class="bg-gradient-to-br from-amber-100 to-orange-100 aspect-[2/3] rounded-sm mb-6 shadow-lg overflow-hidden">
                        <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" alt="<%= book.getTitle() %>" class="w-full h-full object-cover">
                    </div>
                <%
                    } else {
                %>
                    <div class="bg-gradient-to-br from-amber-100 to-orange-100 aspect-[2/3] rounded-sm mb-6 flex items-center justify-center shadow-lg overflow-hidden">
                        <span class="text-8xl">📖</span>
                    </div>
                <%
                    }
                %>

                <!-- Action Buttons -->
                <div class="space-y-3 mb-8">
                    <%
                        if (book.getPdfUrl() != null && !book.getPdfUrl().trim().isEmpty()) {
                    %>
                        <a href="<%= book.getPdfUrl() %>" target="_blank" class="w-full py-3 bg-amber-600 hover:bg-amber-700 text-white font-semibold rounded-sm transition-colors duration-300 text-center block">
                            📖 Read Online
                        </a>
                        <a href="<%= book.getPdfUrl() %>" download class="w-full py-3 border-2 border-amber-600 text-amber-600 hover:bg-amber-50 font-semibold rounded-sm transition-colors duration-300 text-center block">
                            📥 Download PDF
                        </a>
                    <%
                        } else {
                    %>
                        <button class="w-full py-3 bg-amber-600 hover:bg-amber-700 text-white font-semibold rounded-sm transition-colors duration-300">
                            + Add to Library
                        </button>
                        <button class="w-full py-3 border-2 border-amber-600 text-amber-600 hover:bg-amber-50 font-semibold rounded-sm transition-colors duration-300">
                            ❤️ Add to Wishlist
                        </button>
                    <%
                        }
                    %>
                    <button class="w-full py-3 border border-orange-200 text-stone-700 hover:bg-orange-50 font-semibold rounded-sm transition-colors duration-300">
                        Share
                    </button>
                </div>

            </div>

            <!-- Book Details (Right) -->
            <div class="md:col-span-2">
                <!-- Title & Author -->
                <div class="mb-8">
                    <%
                        if (book.getCategory() != null) {
                    %>
                        <p class="text-sm font-semibold text-amber-600 uppercase tracking-widest mb-2"><%= book.getCategory().getName() %></p>
                    <%
                        } else {
                    %>
                        <p class="text-sm font-semibold text-amber-600 uppercase tracking-widest mb-2">Contemporary Fiction</p>
                    <%
                        }
                    %>
                    <h1 class="text-4xl md:text-5xl font-light text-stone-900 playfair mb-3"><%= book.getTitle() %></h1>
                    <p class="text-xl text-stone-600 mb-4">by <span class="font-semibold text-stone-900"><%= book.getAuthor() %></span></p>
                    <div class="w-12 h-px bg-amber-600 mb-6"></div>

                    <!-- Book Info Card -->
                    <div class="flex items-center gap-4 bg-gradient-to-r from-stone-50 to-orange-50 rounded-lg px-4 py-3 mb-6 border-l-4 border-amber-600">
                        <%
                            if (book.getPages() != null) {
                        %>
                            <div class="flex items-center gap-2">
                                <div class="w-2 h-2 bg-amber-600 rounded-full"></div>
                                <span class="text-sm font-medium text-stone-700"><%= book.getPages() %> pages</span>
                            </div>
                        <%
                            } else {
                        %>
                            <div class="flex items-center gap-2">
                                <div class="w-2 h-2 bg-amber-600 rounded-full"></div>
                                <span class="text-sm font-medium text-stone-700">304 pages</span>
                            </div>
                        <%
                            }
                        %>
                        <%
                            if (book.getYear() != null) {
                        %>
                            <div class="flex items-center gap-2">
                                <div class="w-2 h-2 bg-blue-600 rounded-full"></div>
                                <span class="text-sm font-medium text-stone-700">Published <%= book.getYear() %></span>
                            </div>
                        <%
                            } else {
                        %>
                            <div class="flex items-center gap-2">
                                <div class="w-2 h-2 bg-blue-600 rounded-full"></div>
                                <span class="text-sm font-medium text-stone-700">Published 2020</span>
                            </div>
                        <%
                            }
                        %>
                        <div class="flex items-center gap-2">
                            <div class="w-2 h-2 bg-emerald-600 rounded-full"></div>
                            <span class="text-sm font-medium text-stone-700">English</span>
                        </div>
                    </div>

                    <!-- Rating Summary -->
                    <div class="flex items-center gap-6">
                        <%
                            Double avgRating = (Double) request.getAttribute("averageRating");
                            Long ratingCount = (Long) request.getAttribute("ratingCount");
                            if (avgRating != null && avgRating > 0) {
                                double rating = Math.round(avgRating * 10.0) / 10.0;
                                int fullStars = avgRating.intValue();
                                boolean hasHalfStar = (avgRating - fullStars) >= 0.5;
                        %>
                            <div>
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-2xl font-light playfair text-stone-900"><%= rating %></span>
                                    <div class="flex gap-1">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <% if (i <= fullStars) { %>
                                                <span class="text-amber-600">★</span>
                                            <% } else if (i == fullStars + 1 && hasHalfStar) { %>
                                                <span class="text-amber-600">★</span>
                                            <% } else { %>
                                                <span class="text-stone-300">★</span>
                                            <% } %>
                                        <% } %>
                                    </div>
                                </div>
                                <p class="text-xs text-stone-600">Based on <%= ratingCount %> ratings</p>
                            </div>
                        <%
                            } else {
                        %>
                            <div>
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-2xl font-light playfair text-stone-900">--</span>
                                    <div class="flex gap-1">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <span class="text-stone-300">★</span>
                                        <% } %>
                                    </div>
                                </div>
                                <p class="text-xs text-stone-600">No ratings yet</p>
                            </div>
                        <%
                            }
                        %>
                        <div class="border-l border-orange-200 pl-6">
                            <p class="text-sm font-semibold text-stone-900 mb-2">Rate this book</p>
                            <form action="/book/<%= book.getId() %>/rating" method="post" class="flex items-center gap-3">
                                <div class="flex gap-1 rating-container">
                                    <% for (int i = 1; i <= 5; i++) { %>
                                        <label class="cursor-pointer">
                                            <input type="radio" name="rating" value="<%= i %>" class="sr-only rating-star">
                                            <span class="star text-lg text-stone-300 hover:text-amber-600 transition-colors">★</span>
                                        </label>
                                    <% } %>
                                </div>
                                <input type="text" name="userName" placeholder="Your name" required 
                                       class="px-2 py-1 text-xs border border-orange-200 rounded focus:outline-none focus:border-amber-600 w-20">
                                <button type="submit" class="px-3 py-1 bg-amber-600 text-white text-xs font-semibold rounded hover:bg-amber-700 transition-colors">
                                    Rate
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Synopsis -->
                <div class="mb-8">
                    <h2 class="text-xl font-semibold text-stone-900 mb-4 playfair">Synopsis</h2>
                    <%
                        if (book.getSummary() != null && !book.getSummary().trim().isEmpty()) {
                    %>
                        <p class="text-stone-700 leading-relaxed"><%= book.getSummary() %></p>
                    <%
                        } else {
                    %>
                        <p class="text-stone-700 leading-relaxed mb-4">
                            Nora Seed is not okay. She's stuck in a cubicle, commuting to a job she hates, and struggling with her disappointment. She's always dreamed of following her passions, but work, responsibilities, and self-doubt have gotten in the way. So when life hits rock bottom, Nora decides to take a different path.
                        </p>
                        <p class="text-stone-700 leading-relaxed">
                            What happens next is unexpected and extraordinary. Nora finds herself transported to the Midnight Library, a place between life and death where every choice you could have made branches into another version of your life. Here, Nora gets the chance to explore all the choices she could have made differently, to experience all the alternate versions of her life, and to understand which path truly leads to fulfillment.
                        </p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- Reader Reviews Section -->
        <div class="mt-20 pt-12 border-t border-orange-100">
            <div class="mb-8">
                <h2 class="text-3xl font-light text-stone-900 playfair mb-2">Reader Reviews</h2>
                <div class="w-12 h-px bg-amber-600"></div>
            </div>

            <!-- Review Cards -->
            <div class="space-y-6">
                <%
                    @SuppressWarnings("unchecked")
                    List<com.example.e_library.model.Review> reviews = 
                        (List<com.example.e_library.model.Review>) request.getAttribute("reviews");
                    
                    if (reviews != null && !reviews.isEmpty()) {
                        for (com.example.e_library.model.Review review : reviews) {
                            long daysSinceCreated = 0;
                            String timeAgo = "recently";
                            if (review.getCreatedAt() != null) {
                                daysSinceCreated = java.time.Duration.between(review.getCreatedAt(), java.time.LocalDateTime.now()).toDays();
                                if (daysSinceCreated == 0) {
                                    timeAgo = "today";
                                } else if (daysSinceCreated == 1) {
                                    timeAgo = "1 day ago";
                                } else if (daysSinceCreated < 30) {
                                    timeAgo = daysSinceCreated + " days ago";
                                } else if (daysSinceCreated < 365) {
                                    long months = daysSinceCreated / 30;
                                    timeAgo = months + " month" + (months > 1 ? "s" : "") + " ago";
                                } else {
                                    long years = daysSinceCreated / 365;
                                    timeAgo = years + " year" + (years > 1 ? "s" : "") + " ago";
                                }
                            }
                %>
                <div class="bg-white border border-orange-100 rounded-sm p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div>
                            <p class="font-semibold text-stone-900"><%= review.getReviewerName() %></p>
                            <p class="text-xs text-stone-600">Verified Reader • <%= timeAgo %></p>
                        </div>
                        <div class="flex gap-1">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <span class="text-amber-600">★</span>
                            <% } %>
                        </div>
                    </div>
                    <h3 class="font-semibold text-stone-900 mb-2">Great Read</h3>
                    <p class="text-stone-700 leading-relaxed mb-4">
                        <%= review.getContent() %>
                    </p>
                    <div class="flex items-center gap-4">
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">👍 Helpful</button>
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">💬 Reply</button>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <!-- Sample Reviews when no dynamic reviews -->
                <div class="bg-white border border-orange-100 rounded-sm p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div>
                            <p class="font-semibold text-stone-900">Sarah Mitchell</p>
                            <p class="text-xs text-stone-600">Verified Reader • 3 months ago</p>
                        </div>
                        <div class="flex gap-1">
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                        </div>
                    </div>
                    <h3 class="font-semibold text-stone-900 mb-2">Life-Changing Perspective</h3>
                    <p class="text-stone-700 leading-relaxed mb-4">
                        This book truly moved me. It's a beautiful exploration of regret, hope, and the choices we make. Matt Haig writes with such warmth and philosophical depth that makes you question your own life decisions in the best way possible.
                    </p>
                    <div class="flex items-center gap-4">
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">👍 Helpful (234)</button>
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">💬 Reply</button>
                    </div>
                </div>

                <div class="bg-white border border-orange-100 rounded-sm p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div>
                            <p class="font-semibold text-stone-900">James Chen</p>
                            <p class="text-xs text-stone-600">Verified Reader • 2 months ago</p>
                        </div>
                        <div class="flex gap-1">
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-stone-300">★</span>
                        </div>
                    </div>
                    <h3 class="font-semibold text-stone-900 mb-2">Engaging but Predictable</h3>
                    <p class="text-stone-700 leading-relaxed mb-4">
                        Matt Haig creates a compelling world and the concept of the Midnight Library is unique. However, the narrative can feel a bit preachy at times, and some plot points are predictable. Still, it's a worthwhile read that makes you reflect on your choices.
                    </p>
                    <div class="flex items-center gap-4">
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">👍 Helpful (156)</button>
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">💬 Reply</button>
                    </div>
                </div>

                <div class="bg-white border border-orange-100 rounded-sm p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div>
                            <p class="font-semibold text-stone-900">Emma Rodriguez</p>
                            <p class="text-xs text-stone-600">Verified Reader • 1 month ago</p>
                        </div>
                        <div class="flex gap-1">
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                            <span class="text-amber-600">★</span>
                        </div>
                    </div>
                    <h3 class="font-semibold text-stone-900 mb-2">Exactly What I Needed Right Now</h3>
                    <p class="text-stone-700 leading-relaxed mb-4">
                        I found this book at exactly the right time in my life. The message of hope and the possibility of choosing a different path resonated deeply with me. The character development is excellent, and the philosophical questions posed are thought-provoking without being overwhelming.
                    </p>
                    <div class="flex items-center gap-4">
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">👍 Helpful (298)</button>
                        <button class="text-sm text-stone-600 hover:text-amber-600 transition-colors">💬 Reply</button>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Load More Reviews -->
            <div class="text-center mt-8">
                <button class="px-8 py-3 border-2 border-amber-600 text-amber-600 hover:bg-orange-50 font-semibold rounded-sm transition-colors duration-300">
                    Load More Reviews
                </button>
            </div>
            
            <!-- Write Review Form -->
            <div class="mt-12 bg-white border border-orange-100 rounded-sm p-6">
                <h3 class="text-xl font-semibold text-stone-900 mb-4">Write a Review</h3>
                <form action="/book/<%= book.getId() %>/review" method="post" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="reviewerName" class="block text-sm font-medium text-stone-700 mb-2">Your Name</label>
                            <input type="text" id="reviewerName" name="reviewerName" required 
                                   placeholder="Enter your name"
                                   class="w-full px-4 py-2 border border-orange-200 rounded-sm focus:outline-none focus:border-amber-600 focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-stone-700 mb-2">Your Rating</label>
                            <div class="flex gap-1 py-2">
                                <% for (int i = 1; i <= 5; i++) { %>
                                    <label class="cursor-pointer">
                                        <input type="radio" name="rating" value="<%= i %>" class="sr-only review-rating-star">
                                        <span class="review-star text-2xl text-stone-300 hover:text-amber-600 transition-colors">★</span>
                                    </label>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div>
                        <label for="content" class="block text-sm font-medium text-stone-700 mb-2">Your Review</label>
                        <textarea id="content" name="content" rows="4" required 
                                  placeholder="Share your thoughts about this book..."
                                  class="w-full px-4 py-2 border border-orange-200 rounded-sm focus:outline-none focus:border-amber-600 focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10 resize-vertical"></textarea>
                    </div>
                    <button type="submit" class="px-6 py-2 bg-amber-600 text-white font-semibold rounded-sm hover:bg-amber-700 transition-colors">
                        Submit Review
                    </button>
                </form>
            </div>
        </div>

        <!-- Related Books Section -->
        <%
            List<Book> relatedBooks = (List<Book>) request.getAttribute("relatedBooks");
            if (relatedBooks != null && !relatedBooks.isEmpty()) {
        %>
        <div class="mt-20 pt-12 border-t border-orange-100">
            <div class="mb-8">
                <h2 class="text-3xl font-light text-stone-900 playfair mb-2">You Might Also Like</h2>
                <div class="w-12 h-px bg-amber-600"></div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <%
                    for (Book relatedBook : relatedBooks) {
                %>
                <div class="group cursor-pointer" onclick="location.href='/book/<%= relatedBook.getId() %>'">
                    <%
                        if (relatedBook.getCover() != null && !relatedBook.getCover().trim().isEmpty()) {
                    %>
                        <div class="bg-gradient-to-br from-blue-100 to-cyan-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                            <img src="<%= request.getContextPath() %>/uploads/<%= relatedBook.getCover() %>" alt="<%= relatedBook.getTitle() %>" class="w-full h-full object-cover">
                        </div>
                    <%
                        } else {
                    %>
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                            <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                            <span class="text-6xl">📚</span>
                        </div>
                    <%
                        }
                    %>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                        <%= relatedBook.getTitle().length() > 40 ? relatedBook.getTitle().substring(0, 40) + "..." : relatedBook.getTitle() %>
                    </h3>
                    <p class="text-xs text-stone-600 mt-1"><%= relatedBook.getAuthor() %></p>
                    <%
                        if (relatedBook.getYear() != null) {
                    %>
                        <div class="flex items-center gap-1 mt-2">
                            <span class="text-xs text-amber-600">★★★★☆</span>
                            <span class="text-xs text-stone-500">(1.8K)</span>
                        </div>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="mt-20 pt-12 border-t border-orange-100">
            <div class="mb-8">
                <h2 class="text-3xl font-light text-stone-900 playfair mb-2">You Might Also Like</h2>
                <div class="w-12 h-px bg-amber-600"></div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Related Book 1 -->
                <div class="group cursor-pointer">
                    <div class="bg-gradient-to-br from-rose-100 to-pink-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <span class="text-6xl">📚</span>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">Tomorrow, and Tomorrow, and Tomorrow</h3>
                    <p class="text-xs text-stone-600 mt-1">Gabrielle Zevin</p>
                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600">★★★★☆</span>
                        <span class="text-xs text-stone-500">(1.8K)</span>
                    </div>
                </div>

                <!-- Related Book 2 -->
                <div class="group cursor-pointer">
                    <div class="bg-gradient-to-br from-green-100 to-emerald-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <span class="text-6xl">🌿</span>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">Lessons in Chemistry</h3>
                    <p class="text-xs text-stone-600 mt-1">Bonnie Garmus</p>
                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600">★★★★★</span>
                        <span class="text-xs text-stone-500">(3.1K)</span>
                    </div>
                </div>

                <!-- Related Book 3 -->
                <div class="group cursor-pointer">
                    <div class="bg-gradient-to-br from-blue-100 to-cyan-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <span class="text-6xl">🌊</span>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">The Seven Husbands of Evelyn Hugo</h3>
                    <p class="text-xs text-stone-600 mt-1">Taylor Jenkins Reid</p>
                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600">★★★★★</span>
                        <span class="text-xs text-stone-500">(4.2K)</span>
                    </div>
                </div>

                <!-- Related Book 4 -->
                <div class="group cursor-pointer">
                    <div class="bg-gradient-to-br from-purple-100 to-indigo-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <span class="text-6xl">✨</span>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">Circe</h3>
                    <p class="text-xs text-stone-600 mt-1">Madeline Miller</p>
                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600">★★★★★</span>
                        <span class="text-xs text-stone-500">(3.7K)</span>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-8">
                <button class="px-8 py-3 border-2 border-amber-600 text-amber-600 hover:bg-orange-50 font-semibold rounded-sm transition-colors duration-300">
                    Browse More Books
                </button>
            </div>
        </div>
        <%
            }
        %>
    </div>

    <!-- Footer -->
    <footer class="bg-stone-900 text-orange-50 py-12 mt-20">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
                <div>
                    <h3 class="text-lg font-bold text-amber-600 mb-4 playfair">E-Library</h3>
                    <p class="text-sm text-orange-100">Your gateway to infinite knowledge and timeless wisdom.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Quick Links</h4>
                    <ul class="space-y-2 text-sm">
                        <li><a href="/home" class="text-orange-100 hover:text-amber-600 transition-colors">Browse Books</a></li>
                        <li><a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">My Library</a></li>
                        <li><a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Recommendations</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Support</h4>
                    <ul class="space-y-2 text-sm">
                        <li><a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Help Center</a></li>
                        <li><a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Privacy Policy</a></li>
                        <li><a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Terms of Service</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Contact</h4>
                    <ul class="space-y-2 text-sm">
                        <li class="text-orange-100">Email: support@elibrary.com</li>
                        <li class="text-orange-100">Phone: 1-800-LIBRARY</li>
                        <li class="text-orange-100">Hours: 24/7 Support</li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-stone-700 pt-8 flex flex-col md:flex-row justify-between items-center">
                <p class="text-sm text-orange-100 mb-4 md:mb-0">&copy; 2025 E-Library. All rights reserved.</p>
                <div class="flex gap-6">
                    <a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Twitter</a>
                    <a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Facebook</a>
                    <a href="#" class="text-orange-100 hover:text-amber-600 transition-colors">Instagram</a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // Enhanced star rating functionality for both quick rating and review form
        document.addEventListener('DOMContentLoaded', function() {
            
            // Quick rating stars in sidebar
            const ratingStars = document.querySelectorAll('.rating-star');
            const starSpans = document.querySelectorAll('.star');
            
            starSpans.forEach((star, index) => {
                star.addEventListener('mouseover', function() {
                    // Highlight stars up to the hovered one
                    starSpans.forEach((s, i) => {
                        if (i <= index) {
                            s.classList.remove('text-stone-300');
                            s.classList.add('text-amber-500');
                        } else {
                            s.classList.remove('text-amber-600', 'text-amber-500');
                            s.classList.add('text-stone-300');
                        }
                    });
                });
                
                star.addEventListener('click', function() {
                    // Set the rating value
                    ratingStars[index].checked = true;
                    // Update visual feedback
                    starSpans.forEach((s, i) => {
                        if (i <= index) {
                            s.classList.remove('text-stone-300', 'text-amber-500');
                            s.classList.add('text-amber-600');
                        } else {
                            s.classList.remove('text-amber-600', 'text-amber-500');
                            s.classList.add('text-stone-300');
                        }
                    });
                });
            });
            
            // Reset stars on mouse leave
            const ratingContainer = document.querySelector('.rating-container');
            if (ratingContainer) {
                ratingContainer.addEventListener('mouseleave', function() {
                    const checkedStar = document.querySelector('.rating-star:checked');
                    if (checkedStar) {
                        const checkedIndex = Array.from(ratingStars).indexOf(checkedStar);
                        starSpans.forEach((s, i) => {
                            if (i <= checkedIndex) {
                                s.classList.remove('text-stone-300', 'text-amber-500');
                                s.classList.add('text-amber-600');
                            } else {
                                s.classList.remove('text-amber-600', 'text-amber-500');
                                s.classList.add('text-stone-300');
                            }
                        });
                    } else {
                        starSpans.forEach(s => {
                            s.classList.remove('text-amber-600', 'text-amber-500');
                            s.classList.add('text-stone-300');
                        });
                    }
                });
            }

            // Review form rating stars
            const reviewStars = document.querySelectorAll('.review-star');
            const reviewRatingInputs = document.querySelectorAll('.review-rating-star');
            
            reviewStars.forEach((star, index) => {
                star.addEventListener('click', function() {
                    // Set the rating value
                    reviewRatingInputs[index].checked = true;
                    updateReviewStars(index);
                });
                
                star.addEventListener('mouseover', function() {
                    updateReviewStars(index, true);
                });
                
                star.addEventListener('mouseleave', function() {
                    // Reset to selected state
                    const selectedIndex = Array.from(reviewRatingInputs).findIndex(input => input.checked);
                    updateReviewStars(selectedIndex >= 0 ? selectedIndex : -1);
                });
            });

            function updateReviewStars(index, isHover = false) {
                reviewStars.forEach((s, i) => {
                    if (i <= index) {
                        s.classList.add(isHover ? 'text-amber-500' : 'text-amber-600');
                        s.classList.remove('text-stone-300', isHover ? 'text-amber-600' : 'text-amber-500');
                    } else {
                        s.classList.add('text-stone-300');
                        s.classList.remove('text-amber-600', 'text-amber-500');
                    }
                });
            }
        });
    </script>

</body>
</html>
