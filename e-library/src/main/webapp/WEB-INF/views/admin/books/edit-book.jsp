<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.example.e_library.model.*"%>
<%!
// HTML escaper for XSS prevention
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

<%
Book book = (Book) request.getAttribute("book");
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - E-Library Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom dropdown styles */
        .custom-select {
            position: relative;
        }
        
        .select-dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            z-index: 50;
            max-height: 200px;
            overflow-y: auto;
        }
        
        .select-option {
            padding: 0.5rem 0.75rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .select-option:hover {
            background-color: #f3f4f6;
        }
        
        .select-option.selected {
            background-color: #dbeafe;
            color: #1e40af;
        }
        
        .category-icon {
            width: 1rem;
            height: 1rem;
            margin-right: 0.5rem;
        }
    </style>
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
                        <h1 class="text-xl font-semibold text-gray-900">Edit Book</h1>
                        <p class="text-sm text-gray-500 mt-1">Edit book details for "<%=esc(book.getTitle())%>"</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <a href="<%=request.getContextPath()%>/admin/books" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                            Cancel
                        </a>
                        <button type="submit" form="bookForm" class="bg-gray-900 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-800 transition-colors">
                            Save Changes
                        </button>
                    </div>
                </div>
            </header> 

            <!-- Content Area -->
            <div class="flex-1 overflow-hidden">
                <div class="max-w-7xl mx-auto p-3 h-full">
                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 h-full">
                        <form 
                        id="bookForm"
                        action="<%=request.getContextPath()%>/admin/books/edit/<%=book.getId()%>"
                        method="POST"
                        enctype="multipart/form-data"
                        class="lg:col-span-2 space-y-3 overflow-auto">
                            
                            <!-- Book Information -->
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <h3 class="text-base font-semibold text-gray-900 mb-3">Book Information</h3>
                                <div class="space-y-3">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Title *</label>
                                        <input type="text" name="title" required value="<%=esc(book.getTitle())%>" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="Enter book title">
                                    </div>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Author *</label>
                                            <input type="text" name="author" required value="<%=esc(book.getAuthor())%>" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="Author name">
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Category *</label>
                                            <div class="custom-select">
                                                <button type="button" id="categorySelector" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm text-left bg-white flex items-center justify-between" onclick="toggleCategoryDropdown()">
                                                    <span id="selectedCategory" class="flex items-center text-gray-900">
                                                        <span class="category-icon">📚</span>
                                                        <%
                                                        String currentCategoryName = "Select category";
                                                        Integer currentCategoryId = null;
                                                        
                                                        if (book.getCategory() != null) {
                                                            currentCategoryName = book.getCategory().getName();
                                                            currentCategoryId = book.getCategory().getId();
                                                        }
                                                        %>
                                                        <%=esc(currentCategoryName)%>
                                                    </span>
                                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                    </svg>
                                                </button>
                                                
                                                <div id="categoryDropdown" class="select-dropdown hidden">
                                                    <%
                                                    if (categories != null && !categories.isEmpty()) {
                                                        for (Category cat : categories) {
                                                    %>
                                                    <div class="select-option" onclick="selectCategory('<%=cat.getId()%>', '<%=esc(cat.getName())%>', '📚')">
                                                        <span class="flex items-center">
                                                            <span class="category-icon">📚</span>
                                                            <%=esc(cat.getName())%>
                                                        </span>
                                                    </div>
                                                    <%
                                                        }
                                                    } else {
                                                        // Fallback categories with proper numeric IDs
                                                        String[][] defaultCategories = {
                                                            {"1", "📚", "Fiction"},
                                                            {"2", "📖", "Non-Fiction"},
                                                            {"3", "🔬", "Science"},
                                                            {"4", "💻", "Technology"},
                                                            {"5", "🏛️", "History"},
                                                            {"6", "👤", "Biography"},
                                                            {"7", "💕", "Romance"},
                                                            {"8", "🔍", "Mystery"},
                                                            {"9", "🧙", "Fantasy"},
                                                            {"10", "🎓", "Education"},
                                                            {"11", "💪", "Self-Help"},
                                                            {"12", "💼", "Business"}
                                                        };
                                                        
                                                        for (String[] cat : defaultCategories) {
                                                    %>
                                                    <div class="select-option" onclick="selectCategory('<%=cat[0]%>', '<%=cat[2]%>', '<%=cat[1]%>')">
                                                        <span class="flex items-center">
                                                            <span class="category-icon"><%=cat[1]%></span>
                                                            <%=cat[2]%>
                                                        </span>
                                                    </div>
                                                    <%
                                                        }
                                                    }
                                                    %>
                                                </div>
                                                
                                                <input type="hidden" name="categoryId" id="categoryIdInput" value="<%=currentCategoryId != null ? currentCategoryId : ""%>" required>
                                            </div>
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Publication Year</label>
                                            <input type="number" name="publication_year" min="1000" max="<%=java.time.Year.now().getValue() + 5%>" value="<%=book.getYear() != null ? book.getYear() : ""%>" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="2024">
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Pages</label>
                                            <input type="number" name="pages" min="1" value="<%=book.getPages() != null ? book.getPages() : ""%>" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="Number of pages">
                                        </div>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                                        <textarea rows="3" name="description" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="Enter book description..."><%=book.getSummary() != null ? esc(book.getSummary()) : ""%></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- File Upload -->
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <h3 class="text-base font-semibold text-gray-900 mb-3">Book Files</h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                    <!-- PDF Upload -->
                                    <div class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center hover:border-gray-400 transition-colors">
                                        <svg class="mx-auto h-8 w-8 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
                                            <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        <div class="mt-2">
                                            <% if (book.getPdfUrl() != null && !book.getPdfUrl().isEmpty()) { %>
                                            <div class="mb-3">
                                                <span class="block text-sm font-medium text-gray-900 mb-1">Current PDF:</span>
                                                <a href="<%=request.getContextPath() + book.getPdfUrl()%>" class="text-blue-600 underline text-sm" target="_blank">📄 View Current PDF</a>
                                            </div>
                                            <% } %>
                                            <label for="pdf-upload" class="cursor-pointer">
                                                <span class="block text-sm font-medium text-gray-900"><%=book.getPdfUrl() != null && !book.getPdfUrl().isEmpty() ? "Replace PDF" : "Upload PDF"%></span>
                                                <span class="block text-xs text-gray-500">PDF up to 50MB</span>
                                            </label>
                                            <input id="pdf-upload" name="pdf-upload" type="file" accept=".pdf" class="sr-only" onchange="handleFileUpload(this, 'pdf')">
                                        </div>
                                        <div id="pdf-preview" class="hidden mt-2 text-xs text-green-600"></div>
                                    </div>

                                    <!-- Cover Image Upload -->
                                    <div class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center hover:border-gray-400 transition-colors">
                                        <svg class="mx-auto h-8 w-8 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
                                            <path d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h36v-2a2 2 0 00-2-2H8a2 2 0 00-2 2v2zM6 20v18a2 2 0 002 2h32a2 2 0 002-2V20M6 20h36" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        <div class="mt-2">
                                            <% if (book.getCover() != null && !book.getCover().isEmpty()) { %>
                                            <div class="mb-3">
                                                <span class="block text-sm font-medium text-gray-900 mb-2">Current Cover:</span>
                                                <img src="<%=request.getContextPath()%>/uploads/<%=book.getCover()%>" alt="Current cover" class="w-20 h-24 object-cover rounded mx-auto">
                                            </div>
                                            <% } %>
                                            <label for="cover-upload" class="cursor-pointer">
                                                <span class="block text-sm font-medium text-gray-900"><%=book.getCover() != null && !book.getCover().isEmpty() ? "Replace Cover" : "Upload Cover"%></span>
                                                <span class="block text-xs text-gray-500">PNG, JPG up to 10MB</span>
                                            </label>
                                            <input id="cover-upload" name="cover-upload" type="file" accept="image/*" class="sr-only" onchange="handleFileUpload(this, 'image')">
                                        </div>
                                        <div id="image-preview" class="hidden mt-2"></div>
                                    </div>
                                </div>
                            </div>
                            
                        </form>

                        <!-- Sidebar -->
                        <div class="space-y-3 overflow-auto">
                            <!-- Publishing Options -->
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <h3 class="text-base font-semibold text-gray-900 mb-3">Publishing Options</h3>
                                <div class="space-y-3">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                                        <select name="status" form="bookForm" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm">
                                            <option value="draft" <%="draft".equals(String.valueOf(book.getStatus())) ? "selected" : ""%>>📝 Draft</option>
                                            <option value="published" <%="published".equals(String.valueOf(book.getStatus())) ? "selected" : ""%>>✅ Published</option>
                                            <option value="archived" <%="archived".equals(String.valueOf(book.getStatus())) ? "selected" : ""%>>📦 Archived</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Availability</label>
                                        <div class="space-y-1">
                                            <label class="flex items-center cursor-pointer">
                                                <input type="radio" name="availability" form="bookForm" value="available" class="form-radio text-blue-600" <%="available".equals(String.valueOf(book.getAvailability())) ? "checked" : ""%>>
                                                <span class="ml-2 text-sm text-gray-700">🔓 Available to all</span>
                                            </label>
                                            <label class="flex items-center cursor-pointer">
                                                <input type="radio" name="availability" form="bookForm" value="restricted" class="form-radio text-blue-600" <%="restricted".equals(String.valueOf(book.getAvailability())) ? "checked" : ""%>>
                                                <span class="ml-2 text-sm text-gray-700">🔒 Restricted Access</span>
                                            </label>
                                        </div>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Tags</label>
                                        <input type="text" name="tags" form="bookForm" value="<%=book.getTags() != null ? esc(book.getTags()) : ""%>" class="w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm" placeholder="bestseller, award-winning">
                                        <p class="text-xs text-gray-500 mt-1">Separate tags with commas</p>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-3">Premium Access</label>
                                        <div class="flex items-center justify-between p-3 bg-gradient-to-r from-amber-50 to-orange-50 rounded-lg border border-amber-200">
                                            <div class="flex items-center gap-3">
                                                <span class="text-2xl">⭐</span>
                                                <div>
                                                    <p class="text-sm font-medium text-gray-900">Make Premium</p>
                                                    <p class="text-xs text-gray-600">Require subscription to access</p>
                                                </div>
                                            </div>
                                            <label class="relative inline-flex items-center cursor-pointer">
                                                <input type="checkbox" name="premium" form="bookForm" value="true" <%=book.isPremium() ? "checked" : ""%> class="sr-only peer">
                                                <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-amber-300 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-gradient-to-r peer-checked:from-amber-500 peer-checked:to-yellow-500"></div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Book Details -->
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <h3 class="text-base font-semibold text-gray-900 mb-3">Book Details</h3>
                                <div class="space-y-2 text-sm">
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Book ID</span>
                                        <span class="font-medium"><%=book.getId()%></span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Created</span>
                                        <span class="font-medium"><%=book.getCreatedAt() != null ? book.getCreatedAt().toString().substring(0, 10) : "N/A"%></span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Last Updated</span>
                                        <span class="font-medium"><%=book.getUpdatedAt() != null ? book.getUpdatedAt().toString().substring(0, 10) : "N/A"%></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <h3 class="text-base font-semibold text-gray-900 mb-3">Quick Actions</h3>
                                <div class="space-y-1">
                                    <a href="<%=request.getContextPath()%>/admin/books" class="w-full text-left px-3 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-lg transition-colors block">
                                        📚 Back to Books
                                    </a>
                                    <a href="<%=request.getContextPath()%>/admin/books/view/<%=book.getId()%>" class="w-full text-left px-3 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-lg transition-colors block">
                                        👁️ Preview Book
                                    </a>
                                    <button type="button" onclick="confirmDelete()" class="w-full text-left px-3 py-2 text-sm text-red-700 hover:bg-red-50 rounded-lg transition-colors">
                                        🗑️ Delete Book
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        // Category dropdown functionality
        function toggleCategoryDropdown() {
            const dropdown = document.getElementById('categoryDropdown');
            const chevron = document.querySelector('#categorySelector svg');
            
            dropdown.classList.toggle('hidden');
            
            // Rotate chevron icon
            if (dropdown.classList.contains('hidden')) {
                chevron.style.transform = 'rotate(0deg)';
            } else {
                chevron.style.transform = 'rotate(180deg)';
            }
        }

        function selectCategory(id, name, icon) {
            // Set the hidden input value
            document.getElementById('categoryIdInput').value = id;
            
            // Update the display text
            document.getElementById('selectedCategory').innerHTML = 
                '<span class="category-icon">' + icon + '</span>' + name;
            
            // Change text color to indicate selection
            const selectedElement = document.getElementById('selectedCategory');
            selectedElement.classList.remove('text-gray-500');
            selectedElement.classList.add('text-gray-900');
            
            // Close dropdown
            document.getElementById('categoryDropdown').classList.add('hidden');
            
            // Reset chevron
            const chevronElement = document.querySelector('#categorySelector svg');
            if (chevronElement) {
                chevronElement.style.transform = 'rotate(0deg)';
            }
        }

        // File upload handling
        function handleFileUpload(input, type) {
            const file = input.files[0];
            if (file) {
                const previewId = type === 'pdf' ? 'pdf-preview' : 'image-preview';
                const preview = document.getElementById(previewId);
                
                if (type === 'pdf') {
                    // Convert bytes to MB and format to 2 decimal places
                    const fileSizeInMB = Math.round((file.size / 1024 / 1024) * 100) / 100;
                    preview.innerHTML = '<div class="flex items-center justify-center text-green-600"><svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>New PDF: ' + file.name + ' (' + fileSizeInMB + ' MB)</div>';
                } else {
                    const imageUrl = URL.createObjectURL(file);
                    preview.innerHTML = '<div class="flex items-center justify-center"><img src="' + imageUrl + '" alt="New cover preview" class="w-16 h-20 object-cover rounded border"><div class="ml-2 text-left"><div class="font-medium text-green-600">New Cover</div><div class="text-xs text-gray-500">' + file.name + '</div></div></div>';
                }
                
                preview.classList.remove('hidden');
            }
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const dropdown = document.getElementById('categoryDropdown');
            const selector = document.getElementById('categorySelector');
            
            if (!selector.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.classList.add('hidden');
                const chevronElement = document.querySelector('#categorySelector svg');
                if (chevronElement) {
                    chevronElement.style.transform = 'rotate(0deg)';
                }
            }
        });

        // Form validation
        document.getElementById('bookForm').addEventListener('submit', function(e) {
            const title = this.querySelector('[name="title"]').value.trim();
            const author = this.querySelector('[name="author"]').value.trim();
            const categoryId = this.querySelector('[name="categoryId"]').value;
            
            if (!title || !author || !categoryId) {
                e.preventDefault();
                alert('Please fill in all required fields (Title, Author, Category)');
                return false;
            }
        });

        // Delete confirmation
        function confirmDelete() {
            if (confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                window.location.href = '<%=request.getContextPath()%>/admin/books/delete/<%=book.getId()%>';
            }
        }
    </script>
</body>
</html>