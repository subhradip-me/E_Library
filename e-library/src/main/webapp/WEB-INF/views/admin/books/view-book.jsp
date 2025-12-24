<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
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
                        <button class="bg-gray-900 text-white px-4 py-3 rounded-lg text-sm font-medium hover:bg-gray-800 transition-colors">
                            Add New Book
                        </button>
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
                                        <p class="text-2xl font-bold text-gray-900">15,642</p>
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
                                        <p class="text-2xl font-bold text-gray-900">12,847</p>
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
                                        <p class="text-2xl font-bold text-gray-900">34+</p>
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

                                    <!-- Dropdown Container (Expands Down) -->
                                    <div id="filterDropdown" class="hidden absolute right-0 top-full mt-2 z-50">
                                        <div class="bg-white rounded-lg border border-gray-200 shadow-lg w-80 relative overflow-hidden">
                                            <!-- Applied Filters Section (Slides from underneath) -->
                                            <div id="appliedFiltersSection" class="absolute inset-0 bg-white rounded-lg border border-gray-200 shadow-lg p-4 transform translate-x-full transition-transform duration-300 ease-out z-10">
                                                <div class="flex items-center justify-between mb-3">
                                                    <h4 class="text-sm font-semibold text-gray-900">Applied Filters</h4>
                                                    <div class="flex items-center gap-2">
                                                        <span id="appliedCount" class="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-full">0 active</span>
                                                        <button onclick="toggleAppliedFilters()" class="p-1 hover:bg-gray-100 rounded transition-colors">
                                                            <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div id="appliedFiltersContainer" class="flex flex-wrap gap-2 mb-4 max-h-48 overflow-y-auto"></div>
                                                <div class="flex justify-between items-center">
                                                    <button onclick="clearAllFilters()" class="text-xs text-red-600 hover:text-red-700 transition-colors font-medium">
                                                        Clear all filters
                                                    </button>
                                                    <button onclick="applyFilters(); toggleAppliedFilters();" class="px-3 py-1.5 bg-blue-600 text-white text-xs rounded-lg hover:bg-blue-700 transition-colors font-medium">
                                                        Apply & Close
                                                    </button>
                                                </div>
                                            </div>

                                            <!-- Main Filters Section -->
                                            <div class="flex flex-col h-full">
                                                <!-- Header with Applied Filters Toggle -->
                                                <div class="p-4 border-b border-gray-100 flex items-center justify-between">
                                                    <h4 class="text-sm font-semibold text-gray-900">Filters</h4>
                                                    <button id="appliedFiltersToggle" onclick="toggleAppliedFilters()" class="hidden px-2 py-1 text-xs bg-blue-100 text-blue-700 rounded-md hover:bg-blue-200 transition-colors font-medium">
                                                        <span id="appliedFiltersCount">0</span> Applied
                                                    </button>
                                                </div>

                                                <!-- Filter Options -->
                                                <div class="p-4 space-y-4 max-h-80 overflow-y-auto flex-1">
                                                    <!-- Category Filter -->
                                                    <div>
                                                        <h5 class="text-sm font-medium text-gray-900 mb-2">Category</h5>
                                                        <div class="space-y-2">
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="category" data-value="fiction">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">📚 Fiction</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="category" data-value="romance">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">💕 Romance</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="category" data-value="dystopian">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">🌆 Dystopian</span>
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Status Filter -->
                                                    <div>
                                                        <h5 class="text-sm font-medium text-gray-900 mb-2">Status</h5>
                                                        <div class="space-y-2">
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="status" data-value="published">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">✅ Published</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="status" data-value="draft">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">📝 Draft</span>
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Availability Filter -->
                                                    <div>
                                                        <h5 class="text-sm font-medium text-gray-900 mb-2">Availability</h5>
                                                        <div class="space-y-2">
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="availability" data-value="available">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">🔓 Available</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="availability" data-value="restricted">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">🔒 Restricted</span>
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Tags Filter -->
                                                    <div>
                                                        <h5 class="text-sm font-medium text-gray-900 mb-2">Tags</h5>
                                                        <div class="space-y-2">
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="tags" data-value="classic">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">🏛️ Classic</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="tags" data-value="bestseller">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">⭐ Bestseller</span>
                                                            </label>
                                                            <label class="flex items-center cursor-pointer group">
                                                                <input type="checkbox" class="filter-checkbox w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" data-type="tags" data-value="award-winning">
                                                                <span class="ml-2 text-sm text-gray-700 group-hover:text-gray-900 transition-colors">🏆 Award-winning</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Footer -->
                                                <div class="border-t border-gray-100 p-4 flex items-center justify-between bg-gray-50">
                                                    <span id="filterCount2" class="text-sm text-gray-500">0 filters selected</span>
                                                    <div class="flex items-center gap-2">
                                                        <button onclick="clearAllFilters()" class="px-3 py-1.5 text-gray-600 text-xs rounded-lg hover:bg-gray-200 transition-colors font-medium">
                                                            Clear
                                                        </button>
                                                        <button onclick="applyFilters()" class="px-4 py-1.5 bg-blue-600 text-white text-xs rounded-lg hover:bg-blue-700 transition-colors font-medium">
                                                            Apply
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Books Table -->
                    <div class="bg-white rounded-lg border border-gray-200 overflow-hidden max-h-[74vh] flex flex-col">
                        <div class="px-6 py-4 border-b border-gray-200 flex items-center justify-between flex-shrink-0">
                            <h3 class="text-lg font-semibold text-gray-900">Books Collection</h3>
                            <div class="flex items-center gap-6">
                                <span class="text-sm text-gray-500">Showing 1-10 of 15,642</span>
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
                                                    <div class="text-sm font-medium text-gray-900">The Great Gatsby</div>
                                                    <div class="text-xs text-gray-500">ISBN: 978-0743273565</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-900">F. Scott Fitzgerald</td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded-full">Fiction</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full">Published</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full">Available</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex flex-wrap gap-1">
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">classic</span>
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">bestseller</span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-6">
                                                <button class="text-blue-600 hover:text-blue-900">View</button>
                                                <button class="text-gray-600 hover:text-gray-900">Edit</button>
                                                <button class="text-red-600 hover:text-red-900">Delete</button>
                                            </div>
                                        </td>
                                    </tr>

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
                                                    <div class="text-sm font-medium text-gray-900">To Kill a Mockingbird</div>
                                                    <div class="text-xs text-gray-500">ISBN: 978-0061120084</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-900">Harper Lee</td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded-full">Fiction</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full">Published</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full">Available</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex flex-wrap gap-1">
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">award-winning</span>
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">classic</span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-6">
                                                <button class="text-blue-600 hover:text-blue-900">View</button>
                                                <button class="text-gray-600 hover:text-gray-900">Edit</button>
                                                <button class="text-red-600 hover:text-red-900">Delete</button>
                                            </div>
                                        </td>
                                    </tr>

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
                                                    <div class="text-sm font-medium text-gray-900">1984</div>
                                                    <div class="text-xs text-gray-500">ISBN: 978-0451524935</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-900">George Orwell</td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-purple-100 text-purple-800 rounded-full">Dystopian</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full">Published</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full">Available</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex flex-wrap gap-1">
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">dystopian</span>
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">political</span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-6">
                                                <button class="text-blue-600 hover:text-blue-900">View</button>
                                                <button class="text-gray-600 hover:text-gray-900">Edit</button>
                                                <button class="text-red-600 hover:text-red-900">Delete</button>
                                            </div>
                                        </td>
                                    </tr>

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
                                                    <div class="text-sm font-medium text-gray-900">Pride and Prejudice</div>
                                                    <div class="text-xs text-gray-500">ISBN: 978-0141439518</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-900">Jane Austen</td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-pink-100 text-pink-800 rounded-full">Romance</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full">Published</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <span class="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full">Available</span>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap">
                                            <div class="flex flex-wrap gap-1">
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">romance</span>
                                                <span class="px-1.5 py-0.5 text-xs bg-gray-100 text-gray-700 rounded">classic</span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-6">
                                                <button class="text-blue-600 hover:text-blue-900">View</button>
                                                <button class="text-gray-600 hover:text-gray-900">Edit</button>
                                                <button class="text-red-600 hover:text-red-900">Delete</button>
                                            </div>
                                        </td>
                                    </tr>
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
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50">1564</button>
                                <button class="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50">
                                    Next
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Filter System Variables
        let activeFilters = new Set();
        let isDropdownOpen = false;
        let isAppliedFiltersVisible = false;

        // Global Functions
        function toggleFilterDropdown() {
            const dropdown = document.getElementById('filterDropdown');
            const chevron = document.getElementById('filterChevron');
            
            if (isDropdownOpen) {
                dropdown.classList.add('hidden');
                chevron.style.transform = 'rotate(0deg)';
                isDropdownOpen = false;
                isAppliedFiltersVisible = false;
            } else {
                dropdown.classList.remove('hidden');
                chevron.style.transform = 'rotate(180deg)';
                isDropdownOpen = true;
            }
        }

        function toggleAppliedFilters() {
            const appliedSection = document.getElementById('appliedFiltersSection');
            
            if (isAppliedFiltersVisible) {
                appliedSection.classList.add('translate-x-full');
                appliedSection.classList.remove('translate-x-0');
                isAppliedFiltersVisible = false;
            } else {
                appliedSection.classList.remove('translate-x-full');
                appliedSection.classList.add('translate-x-0');
                isAppliedFiltersVisible = true;
            }
        }

        function clearAllFilters() {
            activeFilters.clear();
            document.querySelectorAll('.filter-checkbox').forEach(checkbox => {
                checkbox.checked = false;
            });
            updateAppliedFilters();
            updateFilterBadge();
            applyFilters();
        }

        function removeFilter(filterKey) {
            activeFilters.delete(filterKey);
            const [type, value] = filterKey.split(':');
            const checkbox = document.querySelector(`input[data-type="${type}"][data-value="${value}"]`);
            if (checkbox) checkbox.checked = false;
            updateAppliedFilters();
            updateFilterBadge();
            applyFilters();
        }

        function updateAppliedFilters() {
            const appliedSection = document.getElementById('appliedFiltersSection');
            const appliedCount = document.getElementById('appliedCount');
            const appliedFiltersCount = document.getElementById('appliedFiltersCount');
            const appliedToggle = document.getElementById('appliedFiltersToggle');
            const container = document.getElementById('appliedFiltersContainer');
            
            if (activeFilters.size > 0) {
                // Update counts
                appliedCount.textContent = `${activeFilters.size} active`;
                appliedFiltersCount.textContent = activeFilters.size;
                
                // Show the toggle button in header
                appliedToggle.classList.remove('hidden');
                
                // Clear and rebuild applied filters
                container.innerHTML = '';
                activeFilters.forEach(filterKey => {
                    const [type, value] = filterKey.split(':');
                    const badge = createFilterBadge(type, value, filterKey);
                    container.appendChild(badge);
                });
            } else {
                // Hide the toggle button
                appliedToggle.classList.add('hidden');
                
                // Hide applied filters panel if visible
                if (isAppliedFiltersVisible) {
                    toggleAppliedFilters();
                }
            }
        }

        function createFilterBadge(type, value, filterKey) {
            const badge = document.createElement('span');
            badge.className = 'inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs font-medium rounded-full hover:bg-blue-200 transition-colors';
            badge.innerHTML = `
                <span class="capitalize">${type}: ${value}</span>
                <button onclick="removeFilter('${filterKey}')" class="ml-1 hover:bg-blue-300 rounded-full p-0.5 transition-colors">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            `;
            return badge;
        }

        function updateFilterBadge() {
            const filterCount = document.getElementById('filterCount');
            const filterCount2 = document.getElementById('filterCount2');
            const filterButton = document.getElementById('filterButton');
            
            if (activeFilters.size > 0) {
                filterCount.textContent = activeFilters.size;
                filterCount.classList.remove('hidden');
                filterCount2.textContent = `${activeFilters.size} filter${activeFilters.size !== 1 ? 's' : ''} selected`;
                filterButton.classList.add('border-blue-300', 'bg-blue-50');
                filterButton.classList.remove('border-gray-300');
            } else {
                filterCount.classList.add('hidden');
                filterCount2.textContent = '0 filters selected';
                filterButton.classList.remove('border-blue-300', 'bg-blue-50');
                filterButton.classList.add('border-gray-300');
            }
        }

        function applyFilters() {
            const rows = document.querySelectorAll('tbody tr');
            
            if (activeFilters.size === 0) {
                rows.forEach(row => row.style.display = '');
                return;
            }
            
            rows.forEach(row => {
                let shouldShow = true;
                
                for (const filterKey of activeFilters) {
                    const [type, value] = filterKey.split(':');
                    if (!checkRowMatchesFilter(row, type, value)) {
                        shouldShow = false;
                        break;
                    }
                }
                
                row.style.display = shouldShow ? '' : 'none';
            });
        }

        function checkRowMatchesFilter(row, filterType, value) {
            const cells = row.querySelectorAll('td');
            
            switch(filterType) {
                case 'category':
                    const categorySpan = cells[3]?.querySelector('span');
                    return categorySpan && categorySpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'status':
                    const statusSpan = cells[4]?.querySelector('span');
                    return statusSpan && statusSpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'availability':
                    const availabilitySpan = cells[5]?.querySelector('span');
                    return availabilitySpan && availabilitySpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'tags':
                    const tagSpans = cells[6]?.querySelectorAll('span');
                    if (tagSpans) {
                        return Array.from(tagSpans).some(span => 
                            span.textContent.toLowerCase().includes(value.toLowerCase())
                        );
                    }
                    return false;
                    
                default:
                    return false;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            // Sidebar menu functionality
            document.querySelectorAll('.submenu-toggle').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    var submenu = btn.nextElementSibling;
                    var chevron = btn.querySelector('[data-chevron]');
                    if (!submenu) return;
                    submenu.classList.toggle('hidden');
                    if (chevron) chevron.classList.toggle('rotate-90');
                });
            });

            // Select all checkbox functionality
            const selectAllCheckbox = document.querySelector('thead input[type="checkbox"]');
            const rowCheckboxes = document.querySelectorAll('tbody input[type="checkbox"]');

            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function() {
                    rowCheckboxes.forEach(checkbox => {
                        checkbox.checked = this.checked;
                    });
                });
            }

            // Filter checkbox functionality
            document.querySelectorAll('.filter-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const filterType = this.getAttribute('data-type');
                    const filterValue = this.getAttribute('data-value');
                    const filterKey = `${filterType}:${filterValue}`;
                    
                    if (this.checked) {
                        activeFilters.add(filterKey);
                    } else {
                        activeFilters.delete(filterKey);
                    }
                    
                    updateAppliedFilters();
                    updateFilterBadge();
                });
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                if (!event.target.closest('#filterButton') && !event.target.closest('#filterDropdown')) {
                    if (isDropdownOpen) {
                        toggleFilterDropdown();
                    }
                }
            });

            // Prevent dropdown from closing when clicking inside
            document.getElementById('filterDropdown').addEventListener('click', function(e) {
                e.stopPropagation();
            });
        });
    </script>
</body>
</html>
    