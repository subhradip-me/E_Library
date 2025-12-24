<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="com.example.e_library.model.*"%>
<%!
// simple HTML escaper (recommended even without JSTL)
public static String esc(Object o) {
    if (o == null) return "";
    String s = o.toString();
    s = s.replace("&", "&amp;")
     .replace("<", "&lt;")
     .replace(">", "&gt;")
     .replace("\"", "&quot;");
    return s;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - E-Library Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-white text-zinc-900 font-sans">
    <div class="flex h-screen">
        <!-- Sidebar Navigation -->
        <%@ include file="/WEB-INF/views/includes/admin/sidebar.jsp" %>
        
        <!-- Main Content -->
        <main class="flex-1 flex flex-col overflow-hidden bg-gray-50">
            <!-- Header -->
            <header class="bg-white border-b border-gray-200 px-6 py-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-xl font-semibold text-gray-900">Manage Books</h1>
                        <p class="text-sm text-gray-500 mt-1">View, edit, and organize your book collection</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <button class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium border border-gray-200 rounded-lg">
                            Export
                        </button>
                        <a href="/admin/books/add">
                        <button class="bg-gray-900 text-white px-4 py-3 rounded-lg text-sm font-medium hover:bg-gray-800 transition-colors">
                            Add New Book
                        </button>
                        </a>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="flex-1 overflow-auto">
                <div class="max-w-7xl mx-auto p-6">
                    <!-- Statistics & Search Section -->
                    <div class="bg-white rounded-lg border border-gray-200 px-6 py-4 mb-6">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                            <!-- Statistics -->
                            <div class="flex items-center gap-8">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Total Books</p>
                                        <p class="text-2xl font-bold text-gray-900">
                                            <%
                                            List<Book> bookList = (List<Book>)request.getAttribute("bookdata");
                                            int totalBooks = (bookList != null) ? bookList.size() : 0;
                                            out.print(totalBooks);
                                            %>
                                        </p>
                                    </div>
                                </div>
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Available</p>
                                        <p class="text-2xl font-bold text-gray-900">
                                            <%
                                            int availableBooks = 0;
                                            if(bookList != null) {
                                                for(Book b : bookList) {
                                                    if("Available".equalsIgnoreCase(String.valueOf(b.getAvailability()))) {
                                                        availableBooks++;
                                                    }
                                                }
                                            }
                                            out.print(availableBooks);
                                            %>
                                        </p>
                                    </div>
                                </div>
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm text-gray-600">Total Categories</p>
                                        <p class="text-2xl font-bold text-gray-900">
                                         <%
Set<String> categories = new HashSet<>();

if (bookList != null) {
    for (Book b : bookList) {

        // Check 1: category object not null
        if (b.getCategory() != null) {
            String name = b.getCategory().getName();

            // Check 2: category name not null / empty
            if (name != null && !name.trim().isEmpty()) {
                categories.add(name.trim());
            }
        }
    }
}

out.print(categories.size());
%>+
                                         
                                            
                                            
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Search & Filter -->
                            <div class="flex items-center gap-3">
                                <div class="relative flex-1 min-w-80">
                                    <input type="text" placeholder="Search books, authors, ISBN..." class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <svg class="absolute left-3 top-2.5 h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                    </svg>
                                </div>
                                
                                <!-- Filter Dropdown -->
                                <div class="relative">
                                    <button id="filterButton" onclick="toggleFilterDropdown()" class="flex items-center gap-2 px-4 py-2 text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
                                        </svg>
                                        <span class="text-sm font-medium">Filters</span>
                                        <svg id="filterChevron" class="w-4 h-4 transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                        </svg>
                                        <!-- Filter Count Badge -->
                                        <span id="filterCount" class="hidden bg-blue-600 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center -ml-1">0</span>
                                    </button>

                                    <!-- Filter Dropdown Content (keeping existing structure) -->
                                    <!-- ... keeping the filter dropdown as is since it's working fine ... -->
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Books Table -->
                    <div class="bg-white rounded-lg border border-gray-200 overflow-hidden max-h-[74vh] flex flex-col">
                        <div class="px-6 py-4 border-b border-gray-200 flex items-center justify-between flex-shrink-0">
                            <h3 class="text-lg font-semibold text-gray-900">Books Collection</h3>
                            <div class="flex items-center gap-6">
                                <span class="text-sm text-gray-500">Showing 1-<%=Math.min(10, totalBooks)%> of <%=totalBooks%></span>
                            </div>
                        </div>
                        
                        <div class="overflow-auto flex-1">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-200 sticky top-0">
                                    <tr>
                                        <th class="px-4 py-3 text-left">
                                            <input type="checkbox" class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                                        </th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Book</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Author</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Availability</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tags</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <%
                                    List<Book> book = (List<Book>)request.getAttribute("bookdata");
                                    if(book != null && !book.isEmpty()) {
                                        for(Book bookRepo : book) { 
                                    %>
                                    <tr class="hover:bg-gray-50">
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <input type="checkbox" class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="h-10 w-8 bg-gray-200 rounded flex-shrink-0 flex items-center justify-center">
                                                    <span class="text-xs font-medium text-gray-600">📖</span>
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900"><%=esc(bookRepo.getTitle())%></div>
                                                    <div class="text-xs text-gray-500">ISBN: </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-900"><%=esc(bookRepo.getAuthor())%></td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded-full">
                                            <%= esc(
                                              (bookRepo.getCategory() != null && bookRepo.getCategory().getName() != null)
                                              ? bookRepo.getCategory().getName()
                                               : "—"
                                              ) %>
                                            </span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full"><%=esc(bookRepo.getStatus())%></span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full"><%=esc(bookRepo.getAvailability())%></span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex flex-wrap gap-1">
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded"><%=esc(bookRepo.getTags())%></span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-6">
                                                <a href="view/<%=bookRepo.getId()%>" class="text-blue-600 hover:text-blue-900">View</a>
                                                <a href="/admin/books/edit/<%=bookRepo.getId()%>" class="text-gray-600 hover:text-gray-900">Edit</a>
                                                <a href="/admin/books/delete/<%=bookRepo.getId()%>" onclick="return confirm('Are you sure you want to delete this book?')" class="text-red-600 hover:text-red-900">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% 
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="8" class="px-4 py-8 text-center">
                                            <div class="text-gray-500">
                                                <svg class="mx-auto h-12 w-12 text-gray-400 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                                </svg>
                                                <h4 class="text-lg font-medium text-gray-900 mb-2">No books found</h4>
                                                <p class="text-sm">Get started by adding your first book to the library.</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div class="px-6 py-3 border-t border-gray-200 flex items-center justify-between flex-shrink-0 bg-white">
                            <div class="flex items-center gap-6">
                                <span class="text-sm text-gray-700">Show</span>
                                <select class="border border-gray-300 rounded px-2 py-1 text-sm">
                                    <option>10</option>
                                    <option>25</option>
                                    <option>50</option>
                                    <option>100</option>
                                </select>
                                <span class="text-sm text-gray-700">entries</span>
                            </div>
                            <div class="flex items-center gap-6">
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50" disabled>
                                    Previous
                                </button>
                                <button class="px-3 py-1 bg-gray-900 text-white rounded text-sm">1</button>
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50">2</button>
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50">3</button>
                                <span class="px-2 text-sm text-gray-500">...</span>
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50">Next</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/JavaScript/adminn.js"></script>
</body>
</html>