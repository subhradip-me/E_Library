<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.e_library.model.Book" %>
<%@ page import="com.example.e_library.model.Category" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • <%
        Category category = (Category) request.getAttribute("category");
        if (category != null) {
    %>Books in <%= category.getName() %><%
        } else {
    %>Categories<%
        }
    %></title>
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

    <!-- Breadcrumb -->
    <div class="bg-white border-b border-orange-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center gap-2 text-sm">
                <a href="/home" class="text-amber-600 hover:text-amber-700">Home</a>
                <span class="text-stone-400">/</span>
                <%
                    if (category != null) {
                %>
                        <a href="/category" class="text-amber-600 hover:text-amber-700">Categories</a>
                        <span class="text-stone-400">/</span>
                        <span class="text-stone-600"><%= category.getName() %></span>
                <%
                    } else {
                %>
                        <span class="text-stone-600">Categories</span>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        
        <%
            if (category != null) {
        %>
                <!-- Category Books Page -->
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h1 class="text-4xl md:text-5xl font-light text-stone-900 playfair mb-2"><%= category.getName() %></h1>
                        <%
                            if (category.getDescription() != null && !category.getDescription().trim().isEmpty()) {
                        %>
                            <p class="text-lg text-stone-600 mb-4"><%= category.getDescription() %></p>
                        <%
                            }
                        %>
                        <div class="w-12 h-px bg-amber-600"></div>
                    </div>
                    <%
                        Long totalElements = (Long) request.getAttribute("totalElements");
                        if (totalElements != null && totalElements > 0) {
                    %>
                        <span class="text-sm text-stone-600"><%= totalElements %> books</span>
                    <%
                        }
                    %>
                </div>

                <!-- Books Grid -->
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
                        %>
                        <div class="flex justify-center items-center mt-12 gap-2">
                            <%
                                if (hasPrevious != null && hasPrevious) {
                            %>
                                <a href="?page=<%= currentPage - 1 %>" 
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
                            %>
                                    <a href="?page=<%= pageNum %>" 
                                       class="px-4 py-2 bg-white border border-stone-200 rounded-sm text-sm text-stone-700 hover:bg-orange-50 hover:border-amber-300 transition-colors">
                                        <%= pageNum + 1 %>
                                    </a>
                            <%
                                    }
                                }
                            %>

                            <%
                                if (hasNext != null && hasNext) {
                            %>
                                <a href="?page=<%= currentPage + 1 %>" 
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
                            <p class="text-stone-600">No books are currently available in this category.</p>
                            <a href="/category" class="inline-block mt-4 px-6 py-2 bg-amber-600 text-white rounded-sm text-sm font-semibold hover:bg-amber-700 transition-colors">
                                Browse All Categories
                            </a>
                        </div>
                <%
                    }
                %>
                <!-- Categories List Page -->
                <div class="text-center mb-16">
                    <h1 class="text-4xl md:text-5xl font-light text-stone-900 playfair mb-4">📂 Browse by Category</h1>
                    <p class="text-lg text-stone-600 max-w-2xl mx-auto">
                        Discover books organized by different genres and topics. Find your next favorite read in these carefully curated categories.
                    </p>
                    <div class="w-12 h-px bg-amber-600 mx-auto mt-6"></div>
                </div>

                <!-- Categories Grid -->
                <%
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    if (categories != null && !categories.isEmpty()) {
                %>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                            <%
                                for (int i = 0; i < categories.size(); i++) {
                                    Category cat = categories.get(i);
                            %>
                            <div class="group cursor-pointer" onclick="location.href='/category/<%= cat.getId() %>'">
                                <div class="bg-white rounded-lg shadow-md group-hover:shadow-xl transition-shadow duration-300 overflow-hidden">
                                    <!-- Category Icon/Color -->
                                    <div class="h-32 bg-gradient-to-br 
                                        <%
                                            switch (i % 6) {
                                                case 0: %>from-blue-100 to-indigo-200<%  break;
                                                case 1: %>from-green-100 to-emerald-200<%  break;
                                                case 2: %>from-purple-100 to-violet-200<%  break;
                                                case 3: %>from-rose-100 to-pink-200<%  break;
                                                case 4: %>from-yellow-100 to-amber-200<%  break;
                                                default: %>from-cyan-100 to-teal-200<%  break;
                                            }
                                        %>
                                         flex items-center justify-center">
                                        <span class="text-4xl">
                                            <%
                                                String catNameLower = cat.getName().toLowerCase();
                                                if (catNameLower.contains("fiction")) { %>📖<%
                                                } else if (catNameLower.contains("science")) { %>🔬<%
                                                } else if (catNameLower.contains("mystery")) { %>🔍<%
                                                } else if (catNameLower.contains("romance")) { %>💖<%
                                                } else if (catNameLower.contains("fantasy")) { %>🐉<%
                                                } else if (catNameLower.contains("history")) { %>📜<%
                                                } else if (catNameLower.contains("biography")) { %>👤<%
                                                } else if (catNameLower.contains("business")) { %>💼<%
                                                } else if (catNameLower.contains("health")) { %>🌿<%
                                                } else if (catNameLower.contains("technology")) { %>💻<%
                                                } else if (catNameLower.contains("art")) { %>🎨<%
                                                } else if (catNameLower.contains("travel")) { %>✈️<%
                                                } else { %>📚<%
                                                }
                                            %>
                                        </span>
                                    </div>
                                    
                                    <!-- Category Details -->
                                    <div class="p-6">
                                        <h3 class="text-xl font-semibold text-stone-900 group-hover:text-amber-600 transition-colors mb-2">
                                            <%= cat.getName() %>
                                        </h3>
                                        <%
                                            if (cat.getDescription() != null && !cat.getDescription().trim().isEmpty() && !cat.getDescription().contains(" books")) {
                                        %>
                                            <p class="text-sm text-stone-600 mb-4 line-clamp-3">
                                                <%= cat.getDescription().length() > 120 ? cat.getDescription().substring(0, 120) + "..." : cat.getDescription() %>
                                            </p>
                                        <%
                                            }
                                        %>
                                        
                                        <!-- Category Stats -->
                                        <div class="flex items-center justify-between text-xs text-stone-500">
                                            <span>Browse Collection</span>
                                            <span class="text-amber-600">→</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                <%
                    } else {
                %>
                        <div class="text-center py-20">
                            <div class="text-6xl mb-4">📂</div>
                            <h3 class="text-xl font-semibold text-stone-900 mb-2">No categories found</h3>
                            <p class="text-stone-600">Categories will appear here once they are created.</p>
                        </div>
                <%
                    }
                %>
        <%
            }
        %>

    </main>

</body>
</html>
