<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.e_library.model.Book" %>
<%@ page import="com.example.e_library.model.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • Home</title>
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
    
    <%@ include file="/WEB-INF/views/includes/reader/header.jsp" %>

    <!-- Hero Section with Search & Filter -->
    <section class="bg-white border-b border-orange-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Search Bar -->
                <div class="md:col-span-2">
                    <form method="get" action="/home" class="relative">
                        <input 
                            type="text" 
                            id="search-input"
                            name="search"
                            value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                            placeholder="Search by title, author, or keyword..." 
                            class="w-full px-5 py-4 pr-14 border border-orange-100 rounded-sm text-sm bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        >
                        <button type="submit" class="absolute right-4 top-1/2 -translate-y-1/2 text-stone-600 hover:text-amber-600 transition-colors">🔍</button>
                    </form>
                </div>

                <!-- Category Filter Dropdown -->
                <div>
                    <form method="get" action="/home">
                        <% if (request.getParameter("search") != null && !request.getParameter("search").trim().isEmpty()) { %>
                            <input type="hidden" name="search" value="<%= request.getParameter("search") %>">
                        <% } %>
                        <select name="categoryFilter" onchange="this.form.submit()" class="w-full px-5 py-4 border border-orange-100 rounded-sm text-sm bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10">
                            <option value="">All Categories</option>
                            <%
                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                String selectedCategoryFilter = request.getParameter("categoryFilter");
                                if (categories != null) {
                                    for (Category category : categories) {
                                        String selected = (selectedCategoryFilter != null && selectedCategoryFilter.equals(String.valueOf(category.getId()))) ? "selected" : "";
                            %>
                                <option value="<%= category.getId() %>" <%= selected %>><%= category.getName() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        
        <!-- Featured Books Section -->
        <%
            List<Book> featuredBooks = (List<Book>) request.getAttribute("featuredBooks");
            if (featuredBooks != null && !featuredBooks.isEmpty()) {
        %>
        <div class="mb-20">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl md:text-4xl font-light text-stone-900 playfair mb-2">✨ Featured Books</h2>
                    <div class="w-12 h-px bg-gradient-to-r from-amber-600 to-yellow-500"></div>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-6">
                <%
                    for (int i = 0; i < featuredBooks.size(); i++) {
                        Book book = featuredBooks.get(i);
                %>
                <div class="group cursor-pointer" onclick="location.href='/book/<%= book.getId() %>'">
                    <div class="bg-gradient-to-br from-orange-100 to-amber-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <%
                            if (book.getCover() != null && !book.getCover().trim().isEmpty()) {
                        %>
                                <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" alt="<%= book.getTitle() %>" class="w-full h-full object-cover">
                        <%
                            } else {
                        %>
                                <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                                <span class="text-4xl">📖</span>
                        <%
                            }
                        %>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                        <%= book.getTitle().length() > 50 ? book.getTitle().substring(0, 50) + "..." : book.getTitle() %>
                    </h3>
                    <p class="text-xs text-stone-600 mt-1"><%= book.getAuthor() %></p>
                    <%
                        if (book.getCategory() != null) {
                    %>
                        <p class="text-xs text-amber-600 mt-1"><%= book.getCategory().getName() %></p>
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
            }
        %>
        
        <!-- Premium Books Section -->
        <%
            List<Book> premiumBooks = (List<Book>) request.getAttribute("premiumBooks");
            if (premiumBooks != null && !premiumBooks.isEmpty()) {
        %>
        <div class="mb-20">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl md:text-4xl font-light text-stone-900 playfair mb-2">💎 Premium Collection</h2>
                    <div class="w-12 h-px bg-gradient-to-r from-amber-600 to-yellow-500"></div>
                </div>
                <a href="/subscription" class="text-sm font-semibold text-amber-600 hover:text-green-700 transition-colors">Subscribe for Access →</a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <%
                    String[] premiumGradients = {
                        "from-amber-200 via-yellow-200 to-orange-200 border-amber-300",
                        "from-purple-200 via-violet-200 to-indigo-200 border-purple-300",
                        "from-emerald-200 via-teal-200 to-cyan-200 border-emerald-300",
                        "from-rose-200 via-pink-200 to-red-200 border-rose-300"
                    };
                    
                    for (int i = 0; i < premiumBooks.size(); i++) {
                        Book book = premiumBooks.get(i);
                        String gradient = premiumGradients[i % premiumGradients.length];
                %>
                <div class="group cursor-pointer relative" onclick="location.href='/book/<%= book.getId() %>'">
                    <div class="absolute -top-2 -right-2 bg-gradient-to-r from-amber-500 to-yellow-500 text-white text-xs px-2 py-1 rounded-full z-10 font-bold shadow-lg">PREMIUM</div>
                    <div class="bg-gradient-to-br <%= gradient %> aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-lg group-hover:shadow-2xl transition-shadow duration-300 overflow-hidden relative border-2">
                        <%
                            if (book.getCover() != null && !book.getCover().isEmpty()) {
                        %>
                            <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" 
                                 alt="<%= book.getTitle() %>"
                                 class="w-full h-full object-cover"
                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                            <div class="hidden absolute inset-0 items-center justify-center">
                                <span class="text-6xl">⭐</span>
                            </div>
                        <%
                            } else {
                        %>
                            <span class="text-6xl">⭐</span>
                        <%
                            }
                        %>
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <div class="absolute bottom-2 right-2 text-amber-600">✨</div>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                        <%= book.getTitle().length() > 50 ? book.getTitle().substring(0, 47) + "..." : book.getTitle() %>
                    </h3>
                    <p class="text-xs text-stone-600 mt-1"><%= book.getAuthor() %></p>
                    <%
                        if (book.getCategory() != null) {
                    %>
                        <p class="text-xs text-amber-700 mt-1 font-semibold"><%= book.getCategory().getName() %></p>
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
            }
        %>

        <%
            // Helper functions used across multiple sections
            
            // Basic HTML escape function
            java.util.function.Function<String, String> escapeHtml = (s) -> {
                if (s == null) return "";
                return s.replace("&","&amp;")
                        .replace("<","&lt;")
                        .replace(">","&gt;")
                        .replace("\"","&quot;")
                        .replace("'","&#39;");
            };

            // Format reads like 2.1K function
            java.util.function.Function<Long, String> formatReads = (n) -> {
                if (n == null) return "0";
                if (n < 1000) return String.valueOf(n);
                return (n / 1000) + "." + ((n % 1000) / 100) + "K";
            };

            // Convert clickCount into stars function
            java.util.function.Function<Long, String> getStars = (c) -> {
                if (c == null) c = 0L;
                int s = 1;
                if (c >= 3000) s = 5;
                else if (c >= 2000) s = 4;
                else if (c >= 1000) s = 3;
                else if (c >= 500) s = 2;
                else s = 1;

                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < s; i++) sb.append("★");
                for (int i = s; i < 5; i++) sb.append("☆");
                return sb.toString();
            };

            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            
            // Emoji fallback icons
            String[] icons = {"🚀","🔥","💜","🌍","📗","📘","📕","📙"};
        %>

        <!-- Recently Added Books Section -->
        <%
            List<Book> recentlyAddedBooks = (List<Book>) request.getAttribute("recentlyAddedBooks");
            if (recentlyAddedBooks != null && !recentlyAddedBooks.isEmpty()) {
                String[] recentGradients = {
                    "from-cyan-100 to-blue-100",
                    "from-orange-100 to-red-100",
                    "from-purple-100 to-pink-100",
                    "from-lime-100 to-green-100"
                };
                String[] recentIcons = {"🚀", "🔥", "💜", "🌍"};
        %>
        <div class="mb-20">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl md:text-4xl font-light text-stone-900 playfair mb-2">🆕 Recently Added</h2>
                    <div class="w-12 h-px bg-amber-600"></div>
                </div>
                <a href="#" class="text-sm font-semibold text-amber-600 hover:text-green-700 transition-colors">View All →</a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <%
                    for (int i = 0; i < recentlyAddedBooks.size(); i++) {
                        Book book = recentlyAddedBooks.get(i);
                        String gradient = recentGradients[i % recentGradients.length];
                        String icon = recentIcons[i % recentIcons.length];
                        
                        // Calculate "added ago" text
                        String addedAgo = "";
                        if (book.getCreatedAt() != null) {
                            long days = java.time.Duration.between(book.getCreatedAt(), now).abs().toDays();
                            if (days == 0) {
                                addedAgo = "Added today";
                            } else if (days == 1) {
                                addedAgo = "Added 1 day ago";
                            } else if (days <= 7) {
                                addedAgo = "Added " + days + " days ago";
                            } else {
                                long weeks = days / 7;
                                if (weeks == 1) {
                                    addedAgo = "Added 1 week ago";
                                } else {
                                    addedAgo = "Added " + weeks + " weeks ago";
                                }
                            }
                        }
                        
                        Long clickCount = book.getClickCount() == null ? 0L : book.getClickCount();
                %>
                <div class="group cursor-pointer relative" onclick="location.href='/book/<%= book.getId() %>'">
                    <div class="absolute -top-2 -right-2 bg-green-500 text-white text-xs px-2 py-1 rounded-full z-10">NEW</div>
                    <div class="bg-gradient-to-br <%= gradient %> aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <%
                            if (book.getCover() != null && !book.getCover().trim().isEmpty()) {
                        %>
                            <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" alt="<%= book.getTitle() %>" class="w-full h-full object-cover">
                        <%
                            } else {
                        %>
                            <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                            <span class="text-6xl"><%= icon %></span>
                        <%
                            }
                        %>
                    </div>
                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                        <%= book.getTitle().length() > 50 ? book.getTitle().substring(0, 47) + "..." : book.getTitle() %>
                    </h3>
                    <p class="text-xs text-stone-600 mt-1"><%= book.getAuthor() %></p>
                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600"><%= getStars.apply(clickCount) %></span>
                        <span class="text-xs text-stone-500">(<%= formatReads.apply(clickCount) %>)</span>
                    </div>
                    <% if (!addedAgo.isEmpty()) { %>
                        <p class="text-xs text-green-600 mt-1"><%= addedAgo %></p>
                    <% } %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            }
        %>
        
        <%
            // Get Most Read Books
            List<Book> mostReadBooks = (List<Book>) request.getAttribute("mostReadBooks");
        %>

        <!-- Most Read Books Section -->
        <div class="mb-20">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl md:text-4xl font-light text-stone-900 playfair mb-2">📈 Most Read</h2>
                    <div class="w-12 h-px bg-amber-600"></div>
                </div>
                <a href="#" class="text-sm font-semibold text-amber-600 hover:text-green-700 transition-colors">View All →</a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <%
                    if (mostReadBooks != null && !mostReadBooks.isEmpty()) {
                        int iconIndex = 0;
                        for (Book book : mostReadBooks) {
                            String title = escapeHtml.apply(book.getTitle());
                            String author = escapeHtml.apply(book.getAuthor());
                            Long clickCount = book.getClickCount() == null ? 0L : book.getClickCount();

                            // NEW badge logic
                            boolean isNew = false;
                            String addedAgo = "";
                            if (book.getCreatedAt() != null) {
                                long days = java.time.Duration.between(book.getCreatedAt(), now).abs().toDays();
                                isNew = (days <= 7);
                                if (days == 0) {
                                    addedAgo = "Added today";
                                } else if (days == 1) {
                                    addedAgo = "Added 1 day ago";
                                } else if (days <= 7) {
                                    addedAgo = "Added " + days + " days ago";
                                }
                            }
                %>
                <div class="group cursor-pointer relative" onclick="location.href='/book/<%= book.getId() %>'">
                    <% if (isNew) { %>
                        <div class="absolute -top-2 -right-2 bg-green-500 text-white text-xs px-2 py-1 rounded-full z-10">NEW</div>
                    <% } %>

                    <div class="bg-gradient-to-br from-cyan-100 to-blue-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                        <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <% if (book.getCover() != null && !book.getCover().trim().isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" alt="<%= title %>" class="w-full h-full object-cover" />
                        <% } else { %>
                            <span class="text-6xl"><%= icons[iconIndex % icons.length] %></span>
                        <% } %>
                    </div>

                    <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                        <%= title.length() > 40 ? title.substring(0,37) + "..." : title %>
                    </h3>

                    <p class="text-xs text-stone-600 mt-1"><%= author %></p>

                    <div class="flex items-center gap-1 mt-2">
                        <span class="text-xs text-amber-600"><%= getStars.apply(clickCount) %></span>
                        <span class="text-xs text-stone-500">(<%= formatReads.apply(clickCount) %>)</span>
                    </div>

                    <% if (!addedAgo.isEmpty()) { %>
                        <p class="text-xs text-green-600 mt-1"><%= addedAgo %></p>
                    <% } %>
                </div>
                <%
                            iconIndex++;
                        }
                    } else {
                %>
                <div class="col-span-full text-center py-8">
                    <p class="text-sm text-stone-500">No most-read books available yet.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- All Books Section -->
        <div class="mb-20">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl md:text-4xl font-light text-stone-900 playfair mb-2">
                        <%
                            String searchTerm = request.getParameter("search");
                            Category selectedCategory = (Category) request.getAttribute("selectedCategory");
                            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        %>
                                Search Results for "<%= searchTerm %>"
                        <%
                            } else if (selectedCategory != null) {
                        %>
                                Books in <%= selectedCategory.getName() %>
                        <%
                            } else {
                        %>
                                📚 All Books
                        <%
                            }
                        %>
                    </h2>
                    <div class="w-12 h-px bg-amber-600"></div>
                </div>
                <%
                    Long totalElements = (Long) request.getAttribute("totalElements");
                    if (totalElements != null && totalElements > 0) {
                %>
                    <span class="text-sm text-stone-600"><%= totalElements %> books found</span>
                <%
                    }
                %>
            </div>

            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books != null && !books.isEmpty()) {
            %>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <%
                        for (Book book : books) {
                    %>
                    <div class="group cursor-pointer" onclick="location.href='/book/<%= book.getId() %>'">
                        <div class="bg-gradient-to-br from-blue-100 to-cyan-100 aspect-[2/3] rounded-sm mb-4 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden relative">
                            <%
                                if (book.getCover() != null && !book.getCover().trim().isEmpty()) {
                            %>
                                    <img src="<%= request.getContextPath() %>/uploads/<%= book.getCover() %>" alt="<%= book.getTitle() %>" class="w-full h-full object-cover">
                            <%
                                } else {
                            %>
                                    <div class="absolute inset-0 bg-stone-900 opacity-0 group-hover:opacity-5 transition-opacity"></div>
                                    <span class="text-6xl">📚</span>
                            <%
                                }
                            %>
                        </div>
                        <h3 class="font-semibold text-stone-900 text-sm group-hover:text-amber-600 transition-colors">
                            <%= book.getTitle().length() > 60 ? book.getTitle().substring(0, 60) + "..." : book.getTitle() %>
                        </h3>
                        <p class="text-xs text-stone-600 mt-1"><%= book.getAuthor() %></p>
                        <%
                            if (book.getCategory() != null) {
                        %>
                            <p class="text-xs text-amber-600 mt-1"><%= book.getCategory().getName() %></p>
                        <%
                            }
                        %>
                        <%
                            if (book.getYear() != null) {
                        %>
                            <p class="text-xs text-stone-500 mt-1"><%= book.getYear() %></p>
                        <%
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                </div>

                <!-- Pagination -->
                <%
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    if (totalPages != null && totalPages > 1) {
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Boolean hasPrevious = (Boolean) request.getAttribute("hasPrevious");
                        Boolean hasNext = (Boolean) request.getAttribute("hasNext");
                        String categoryFilter = request.getParameter("categoryFilter");
                %>
                <div class="flex justify-center items-center mt-12 gap-2">
                    <%
                        if (hasPrevious != null && hasPrevious) {
                            String prevUrl = "?page=" + (currentPage - 1);
                            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                                prevUrl += "&search=" + searchTerm;
                            }
                            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                                prevUrl += "&categoryFilter=" + categoryFilter;
                            }
                    %>
                        <a href="<%= prevUrl %>" 
                           class="px-4 py-2 bg-white border border-stone-200 rounded-sm text-sm text-stone-700 hover:bg-orange-50 hover:border-amber-300 transition-colors">
                            Previous
                        </a>
                    <%
                        }
                    %>

                    <%
                        for (int pageNum = 0; pageNum < totalPages; pageNum++) {
                            if (pageNum == currentPage) {
                    %>
                                <span class="px-4 py-2 bg-amber-600 text-white rounded-sm text-sm font-semibold"><%= pageNum + 1 %></span>
                    <%
                            } else if (pageNum < currentPage + 3 && pageNum > currentPage - 3) {
                                String pageUrl = "?page=" + pageNum;
                                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                                    pageUrl += "&search=" + searchTerm;
                                }
                                if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                                    pageUrl += "&categoryFilter=" + categoryFilter;
                                }
                    %>
                                <a href="<%= pageUrl %>" 
                                   class="px-4 py-2 bg-white border border-stone-200 rounded-sm text-sm text-stone-700 hover:bg-orange-50 hover:border-amber-300 transition-colors">
                                    <%= pageNum + 1 %>
                                </a>
                    <%
                            }
                        }
                    %>

                    <%
                        if (hasNext != null && hasNext) {
                            String nextUrl = "?page=" + (currentPage + 1);
                            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                                nextUrl += "&search=" + searchTerm;
                            }
                            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                                nextUrl += "&categoryFilter=" + categoryFilter;
                            }
                    %>
                        <a href="<%= nextUrl %>" 
                           class="px-4 py-2 bg-white border border-stone-200 rounded-sm text-sm text-stone-700 hover:bg-orange-50 hover:border-amber-300 transition-colors">
                            Next
                        </a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            <%
                } else {
            %>
                <div class="text-center py-20">
                    <div class="text-6xl mb-4">📚</div>
                    <h3 class="text-xl font-semibold text-stone-900 mb-2">No books found</h3>
                    <p class="text-stone-600">
                        <%
                            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        %>
                            Try searching with different keywords
                        <%
                            } else if (selectedCategory != null) {
                        %>
                            No books available in this category
                        <%
                            } else {
                        %>
                            No books are currently available
                        <%
                            }
                        %>
                    </p>
                    <%
                        if ((searchTerm != null && !searchTerm.trim().isEmpty()) || selectedCategory != null) {
                    %>
                        <a href="/home" class="inline-block mt-4 px-6 py-2 bg-amber-600 text-white rounded-sm text-sm font-semibold hover:bg-amber-700 transition-colors">
                            View All Books
                        </a>
                    <%
                        }
                    %>
                </div>
            <%
                }
            %>
        </div>
    </main>

</body>
</html>
