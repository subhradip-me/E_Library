<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.e_library.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - E-Library Admin</title>
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
                        <h1 class="text-xl font-semibold text-gray-900">User Management</h1>
                        <p class="text-sm text-gray-500 mt-1">Manage all registered users and their permissions</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <button onclick="window.location.reload()" class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors">
                            <span class="inline-block mr-2">🔄</span>
                            Refresh
                        </button>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="flex-1 overflow-auto">
                <div class="max-w-7xl mx-auto p-6">
                    
                    <!-- Statistics Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
                        <!-- Total Users -->
                        <div class="bg-white rounded-lg border border-gray-200 p-5">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Total Users</p>
                                    <p class="text-2xl font-bold text-gray-900 mt-2"><%= request.getAttribute("totalUsers") %></p>
                                </div>
                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">👥</span>
                                </div>
                            </div>
                        </div>

                        <!-- Active Users -->
                        <div class="bg-white rounded-lg border border-gray-200 p-5">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Active Users</p>
                                    <p class="text-2xl font-bold text-green-600 mt-2"><%= request.getAttribute("activeUsers") %></p>
                                </div>
                                <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">✅</span>
                                </div>
                            </div>
                        </div>

                        <!-- Inactive Users -->
                        <div class="bg-white rounded-lg border border-gray-200 p-5">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Inactive Users</p>
                                    <p class="text-2xl font-bold text-red-600 mt-2"><%= request.getAttribute("inactiveUsers") %></p>
                                </div>
                                <div class="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">❌</span>
                                </div>
                            </div>
                        </div>

                        <!-- Admin Users -->
                        <div class="bg-white rounded-lg border border-gray-200 p-5">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Admins</p>
                                    <p class="text-2xl font-bold text-purple-600 mt-2"><%= request.getAttribute("adminCount") %></p>
                                </div>
                                <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">👑</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Filters and Search -->
                    <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                        <form action="/admin/users" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                            <!-- Search -->
                            <div class="md:col-span-2">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Search Users</label>
                                <input type="text" 
                                       name="search" 
                                       value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>" 
                                       placeholder="Search by name, email..." 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                            </div>

                            <!-- Role Filter -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
                                <select name="role" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                                    <% String selectedRole = (String) request.getAttribute("selectedRole"); %>
                                    <option value="all" <%= (selectedRole == null || "all".equals(selectedRole)) ? "selected" : "" %>>All Roles</option>
                                    <option value="admin" <%= "admin".equals(selectedRole) ? "selected" : "" %>>Admin</option>
                                    <option value="reader" <%= "reader".equals(selectedRole) ? "selected" : "" %>>Reader</option>
                                </select>
                            </div>

                            <!-- Status Filter -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                                <select name="status" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                                    <% String selectedStatus = (String) request.getAttribute("selectedStatus"); %>
                                    <option value="all" <%= (selectedStatus == null || "all".equals(selectedStatus)) ? "selected" : "" %>>All Status</option>
                                    <option value="active" <%= "active".equals(selectedStatus) ? "selected" : "" %>>Active</option>
                                    <option value="inactive" <%= "inactive".equals(selectedStatus) ? "selected" : "" %>>Inactive</option>
                                </select>
                            </div>

                            <!-- Submit Button (Full Width) -->
                            <div class="md:col-span-4 flex gap-3">
                                <button type="submit" class="bg-gray-900 text-white px-6 py-2 rounded-lg font-medium hover:bg-gray-800 transition-colors">
                                    Apply Filters
                                </button>
                                <a href="/admin/users" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-lg font-medium hover:bg-gray-200 transition-colors">
                                    Clear Filters
                                </a>
                            </div>
                        </form>
                    </div>

                    <!-- Users Table -->
                    <div class="bg-white rounded-lg border border-gray-200 overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-900">User List</h3>
                            <% 
                                @SuppressWarnings("unchecked")
                                List<User> users = (List<User>) request.getAttribute("users");
                            %>
                            <p class="text-sm text-gray-500 mt-1">Showing <%= users != null ? users.size() : 0 %> users</p>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Subscription</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Joined Date</th>
                                        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <% 
                                        if (users != null && !users.isEmpty()) {
                                            for (User user : users) {
                                    %>
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <!-- User Info -->
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-bold">
                                                        <%= user.getFullname().substring(0, 1).toUpperCase() %>
                                                    </div>
                                                    <div class="ml-4">
                                                        <div class="text-sm font-medium text-gray-900"><%= user.getFullname() %></div>
                                                        <div class="text-xs text-gray-500">ID: <%= user.getId() %></div>
                                                    </div>
                                                </div>
                                            </td>

                                            <!-- Email -->
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900"><%= user.getEmail() %></div>
                                            </td>

                                            <!-- Role -->
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <% if ("admin".equals(user.getRole())) { %>
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-purple-100 text-purple-800">
                                                        👑 Admin
                                                    </span>
                                                <% } else { %>
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                                                        📖 Reader
                                                    </span>
                                                <% } %>
                                            </td>

                                            <!-- Subscription Status -->
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <% if (user.isSubscribed()) { %>
                                                    <span class="inline-flex items-center px-2 py-1 text-xs font-semibold rounded-full bg-amber-100 text-amber-800">
                                                        <span class="mr-1">⭐</span>
                                                        Subscribed
                                                    </span>
                                                <% } else { %>
                                                    <span class="inline-flex items-center px-2 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-600">
                                                        <span class="mr-1">📭</span>
                                                        Free
                                                    </span>
                                                <% } %>
                                            </td>

                                            <!-- Status -->
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <% if (user.isEnabled()) { %>
                                                    <span class="inline-flex items-center px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                                        <span class="w-2 h-2 bg-green-500 rounded-full mr-1"></span>
                                                        Active
                                                    </span>
                                                <% } else { %>
                                                    <span class="inline-flex items-center px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">
                                                        <span class="w-2 h-2 bg-red-500 rounded-full mr-1"></span>
                                                        Inactive
                                                    </span>
                                                <% } %>
                                            </td>

                                            <!-- Joined Date -->
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <%= user.getFormattedCreatedAt() %>
                                            </td>

                                            <!-- Actions -->
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex items-center justify-end gap-2">
                                                    <!-- Toggle Status -->
                                                    <form action="/admin/users/toggle-status/<%= user.getId() %>" method="post" style="display: inline;">
                                                        <button type="submit" 
                                                                class="px-3 py-1 text-xs font-medium rounded <%= user.isEnabled() ? "bg-red-100 text-red-700 hover:bg-red-200" : "bg-green-100 text-green-700 hover:bg-green-200" %> transition-colors"
                                                                onclick="return confirm('Are you sure you want to <%= user.isEnabled() ? "deactivate" : "activate" %> this user?')">
                                                            <%= user.isEnabled() ? "🚫 Deactivate" : "✅ Activate" %>
                                                        </button>
                                                    </form>

                                                    <!-- Change Role -->
                                                    <form action="/admin/users/update-role/<%= user.getId() %>" method="post" style="display: inline;">
                                                        <input type="hidden" name="role" value="<%= "admin".equals(user.getRole()) ? "reader" : "admin" %>">
                                                        <% String roleChangeMsg = "admin".equals(user.getRole()) ? "Reader" : "Admin"; %>
                                                        <button type="submit" 
                                                                class="px-3 py-1 text-xs font-medium rounded bg-blue-100 text-blue-700 hover:bg-blue-200 transition-colors"
                                                                onclick="return confirm('Change role to <%= roleChangeMsg %>?')">
                                                            <%= "admin".equals(user.getRole()) ? "📖 Make Reader" : "👑 Make Admin" %>
                                                        </button>
                                                    </form>

                                                    <!-- Delete User -->
                                                    <form action="/admin/users/delete/<%= user.getId() %>" method="post" style="display: inline;">
                                                        <button type="submit" 
                                                                class="px-3 py-1 text-xs font-medium rounded bg-red-100 text-red-700 hover:bg-red-200 transition-colors"
                                                                onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                                            🗑️ Delete
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <% 
                                            }
                                        } else {
                                    %>
                                        <!-- Empty State -->
                                        <tr>
                                            <td colspan="7" class="px-6 py-12 text-center">
                                                <div class="flex flex-col items-center justify-center">
                                                    <span class="text-6xl mb-4">🔍</span>
                                                    <p class="text-gray-500 text-lg font-medium">No users found</p>
                                                    <p class="text-gray-400 text-sm mt-2">Try adjusting your search or filter criteria</p>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>