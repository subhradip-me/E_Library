<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library Admin Dashboard</title>
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
                        <h1 class="text-xl font-semibold text-gray-900">Dashboard Overview</h1>
                        <p class="text-sm text-gray-500 mt-1">Welcome back! Here's what's happening with your e-library today.</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="text-sm text-gray-500">
                            <span class="font-medium">Last updated:</span> 
                            <% 
                                SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
                                String currentTime = sdf.format(new Date());
                            %>
                            <%= currentTime %>
                        </div>
                        <button onclick="location.reload()" class="bg-gray-900 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-800 transition-colors">
                            Refresh Data
                        </button>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="flex-1 overflow-auto">
                <div class="max-w-7xl mx-auto p-6">
                    <!-- Stats Overview Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-4">
                        <!-- Total Users -->
                        <div class="bg-white rounded-lg border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Total Users</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                        <% 
                                            Integer totalUsers = (Integer) request.getAttribute("totalUsers");
                                            if (totalUsers != null) {
                                        %>
                                            <%= String.format("%,d", totalUsers) %>
                                        <% } else { %>
                                            2,847
                                        <% } %>
                                    </p>
                                    <div class="flex items-center mt-2">
                                        <svg class="w-4 h-4 text-green-500 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"/>
                                        </svg>
                                        <span class="text-sm text-green-600 font-medium">
                                            <% 
                                                Double userGrowthPercent = (Double) request.getAttribute("userGrowthPercent");
                                                if (userGrowthPercent != null) {
                                            %>
                                                +<%= String.format("%.1f", userGrowthPercent) %>%
                                            <% } else { %>
                                                +12.5%
                                            <% } %>
                                        </span>
                                        <span class="text-sm text-gray-500 ml-1">from last month</span>
                                    </div>
                                </div>
                                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <span class="text-2xl">👥</span>
                                </div>
                            </div>
                        </div>

                        <!-- Total Books -->
                        <div class="bg-white rounded-lg border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Total Books</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                        <% 
                                            Integer totalBooks = (Integer) request.getAttribute("totalBooks");
                                            if (totalBooks != null) {
                                        %>
                                            <%= String.format("%,d", totalBooks) %>
                                        <% } else { %>
                                            15,642
                                        <% } %>
                                    </p>
                                    <div class="flex items-center mt-2">
                                        <svg class="w-4 h-4 text-green-500 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"/>
                                        </svg>
                                        <span class="text-sm text-green-600 font-medium">
                                            <% 
                                                Integer newBooksThisWeek = (Integer) request.getAttribute("newBooksThisWeek");
                                                if (newBooksThisWeek != null) {
                                            %>
                                                +<%= newBooksThisWeek %>
                                            <% } else { %>
                                                +245
                                            <% } %>
                                        </span>
                                        <span class="text-sm text-gray-500 ml-1">new this week</span>
                                    </div>
                                </div>
                                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                                    <span class="text-2xl">📚</span>
                                </div>
                            </div>
                        </div>

                        <!-- Active Sessions -->
                        <div class="bg-white rounded-lg border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">Active Sessions</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                        <% 
                                            Integer activeSessions = (Integer) request.getAttribute("activeSessions");
                                            if (activeSessions != null) {
                                        %>
                                            <%= String.format("%,d", activeSessions) %>
                                        <% } else { %>
                                            1,234
                                        <% } %>
                                    </p>
                                    <div class="flex items-center mt-2">
                                        <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
                                        <span class="text-sm text-gray-500">Live visitors online</span>
                                    </div>
                                </div>
                                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                                    <span class="text-2xl">🌐</span>
                                </div>
                            </div>
                        </div>

                        <!-- New Registrations Today -->
                        <div class="bg-white rounded-lg border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-gray-600">New Registrations Today</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                        <% 
                                            Integer newRegistrationsToday = (Integer) request.getAttribute("newRegistrationsToday");
                                            if (newRegistrationsToday != null) {
                                        %>
                                            <%= newRegistrationsToday %>
                                        <% } else { %>
                                            89
                                        <% } %>
                                    </p>
                                    <div class="flex items-center mt-2">
                                        <svg class="w-4 h-4 text-orange-500 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3"/>
                                        </svg>
                                        <span class="text-sm text-orange-600 font-medium">Since midnight</span>
                                    </div>
                                </div>
                                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
                                    <span class="text-2xl">✨</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Admin Activity Summary & Quick Actions -->
                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-4">
                        <!-- Admin Activity Summary -->
                        <div class="lg:col-span-2 bg-white rounded-lg border border-gray-200 p-6">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-lg font-semibold text-gray-900">Admin Activity Summary</h3>
                                <select class="text-sm border border-gray-200 rounded-md px-3 py-1 focus:outline-none focus:ring-1 focus:ring-gray-300">
                                    <option>Last 7 days</option>
                                    <option>Last 30 days</option>
                                    <option>Last 90 days</option>
                                </select>
                            </div>
                            <div class="space-y-2">
                                <!-- Activity items would be dynamically generated from backend data -->
                                <%
                                    java.util.List adminActivities = (java.util.List) request.getAttribute("adminActivities");
                                    if (adminActivities != null && !adminActivities.isEmpty()) {
                                        for (Object activityObj : adminActivities) {
                                            // Assuming activity is a Map or custom object
                                            java.util.Map activity = (java.util.Map) activityObj;
                                %>
                                    <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                                        <div class="w-10 h-10 bg-<%= activity.get("iconColor") %>-100 rounded-full flex items-center justify-center">
                                            <svg class="w-5 h-5 text-<%= activity.get("iconColor") %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <%= activity.get("iconPath") %>
                                            </svg>
                                        </div>
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-gray-900"><%= activity.get("title") %></p>
                                            <p class="text-xs text-gray-500"><%= activity.get("description") %></p>
                                        </div>
                                        <span class="text-sm text-gray-600"><%= activity.get("timeAgo") %></span>
                                    </div>
                                <%
                                        }
                                    } else {
                                %>
                                    <!-- Default activity items -->
                                        <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                                            <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center">
                                                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                                </svg>
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm font-medium text-gray-900">Books Added</p>
                                                <p class="text-xs text-gray-500">245 new books added to the library</p>
                                            </div>
                                            <span class="text-sm text-gray-600">Today</span>
                                        </div>

                                        <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                                            <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                                                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                                </svg>
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm font-medium text-gray-900">User Management</p>
                                                <p class="text-xs text-gray-500">156 user accounts reviewed and updated</p>
                                            </div>
                                            <span class="text-sm text-gray-600">Yesterday</span>
                                        </div>

                                        <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                                            <div class="w-10 h-10 bg-purple-100 rounded-full flex items-center justify-center">
                                                <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                                                </svg>
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm font-medium text-gray-900">System Analytics</p>
                                                <p class="text-xs text-gray-500">Generated monthly performance reports</p>
                                            </div>
                                            <span class="text-sm text-gray-600">2 days ago</span>
                                        </div>

                                        <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                                            <div class="w-10 h-10 bg-red-100 rounded-full flex items-center justify-center">
                                                <svg class="w-5 h-5 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.664-.833-2.464 0L4.35 16.5c-.77.833.192 2.5 1.732 2.5z"/>
                                                </svg>
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm font-medium text-gray-900">Security Check</p>
                                                <p class="text-xs text-gray-500">Completed system security audit</p>
                                            </div>
                                            <span class="text-sm text-gray-600">3 days ago</span>
                                        </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6">
                            <h3 class="text-lg font-semibold text-gray-900 mb-6">Quick Actions</h3>
                            <div class="space-y-3">
                                <a href="/admin/books/add" class="block w-full text-left p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                            <span class="text-sm">📖</span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-gray-900">Add New Book</p>
                                            <p class="text-xs text-gray-500">Upload and catalog books</p>
                                        </div>
                                    </div>
                                </a>

                                <a href="/admin/users" class="block w-full text-left p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                                            <span class="text-sm">👤</span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-gray-900">Manage Users</p>
                                            <p class="text-xs text-gray-500">View and edit user accounts</p>
                                        </div>
                                    </div>
                                </a>

                                <a href="analytics" class="block w-full text-left p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center">
                                            <span class="text-sm">📊</span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-gray-900">View Analytics</p>
                                            <p class="text-xs text-gray-500">System performance metrics</p>
                                        </div>
                                    </div>
                                </a>

                                <a href="/admin/settings" class="block w-full text-left p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center">
                                            <span class="text-sm">⚙️</span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-medium text-gray-900">System Settings</p>
                                            <p class="text-xs text-gray-500">Configure library settings</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activity & System Status -->
                     <!-- System Status -->        
            </div>
        </main>
    </div>
</body>
</html>
