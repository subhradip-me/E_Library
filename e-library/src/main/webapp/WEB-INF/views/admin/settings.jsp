<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - E-Library Admin</title>
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
                        <h1 class="text-xl font-semibold text-gray-900">Settings</h1>
                        <p class="text-sm text-gray-500 mt-1">Manage your e-library system settings and preferences</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="text-sm text-gray-500">
                            <span class="font-medium">Last saved:</span> Just now
                        </span>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="flex-1 overflow-auto">
                <div class="max-w-6xl mx-auto p-6">
                    
                    <!-- Success Message -->
                    <% 
                        String successMessage = (String) request.getAttribute("successMessage");
                        if (successMessage != null && !successMessage.isEmpty()) {
                    %>
                        <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">✅</span>
                                <div>
                                    <p class="text-green-800 font-medium"><%= successMessage %></p>
                                </div>
                            </div>
                        </div>
                    <% } %>

                    <!-- Settings Form -->
                    <form action="/admin/settings/update" method="post">
                        
                        <!-- General Settings -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">⚙️</span>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">General Settings</h3>
                                    <p class="text-sm text-gray-500">Configure basic system settings</p>
                                </div>
                            </div>

                            <div class="space-y-4">
                                <!-- Site Name -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Site Name</label>
                                    <input type="text" 
                                           name="siteName" 
                                           value="E-Library System" 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                                    <p class="text-xs text-gray-500 mt-1">This name appears throughout the application</p>
                                </div>

                                <!-- Site Description -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Site Description</label>
                                    <textarea name="siteDescription" 
                                              rows="3" 
                                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">Your digital library for discovering and reading amazing books</textarea>
                                    <p class="text-xs text-gray-500 mt-1">Brief description of your library system</p>
                                </div>

                                <!-- Admin Email -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Admin Email</label>
                                    <input type="email" 
                                           name="adminEmail" 
                                           value="admin@library.io" 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                                    <p class="text-xs text-gray-500 mt-1">Primary contact email for system notifications</p>
                                </div>
                            </div>
                        </div>

                        <!-- Display Settings -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">🖥️</span>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">Display Settings</h3>
                                    <p class="text-sm text-gray-500">Control how content is displayed</p>
                                </div>
                            </div>

                            <div class="space-y-4">
                                <!-- Books Per Page -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Books Per Page</label>
                                    <select name="booksPerPage" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-900">
                                        <option value="12">12 books</option>
                                        <option value="24" selected>24 books</option>
                                        <option value="48">48 books</option>
                                        <option value="96">96 books</option>
                                    </select>
                                    <p class="text-xs text-gray-500 mt-1">Number of books to display per page</p>
                                </div>

                                <!-- Default View -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Default Book View</label>
                                    <div class="flex gap-4">
                                        <label class="flex items-center">
                                            <input type="radio" name="defaultView" value="grid" checked class="mr-2">
                                            <span class="text-sm">Grid View</span>
                                        </label>
                                        <label class="flex items-center">
                                            <input type="radio" name="defaultView" value="list" class="mr-2">
                                            <span class="text-sm">List View</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- System Settings -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">🔧</span>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">System Configuration</h3>
                                    <p class="text-sm text-gray-500">Advanced system settings</p>
                                </div>
                            </div>

                            <div class="space-y-4">
                                <!-- Maintenance Mode -->
                                <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">Maintenance Mode</p>
                                        <p class="text-xs text-gray-500 mt-1">Put the site in maintenance mode for updates</p>
                                    </div>
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" name="maintenanceMode" class="sr-only peer">
                                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                                    </label>
                                </div>

                                <!-- User Registration -->
                                <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">User Registration</p>
                                        <p class="text-xs text-gray-500 mt-1">Allow new users to register accounts</p>
                                    </div>
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" name="userRegistration" checked class="sr-only peer">
                                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                                    </label>
                                </div>

                                <!-- Email Notifications -->
                                <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">Email Notifications</p>
                                        <p class="text-xs text-gray-500 mt-1">Send email notifications to users</p>
                                    </div>
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" name="emailNotifications" checked class="sr-only peer">
                                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Statistics Overview -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">📊</span>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">System Statistics</h3>
                                    <p class="text-sm text-gray-500">Current system overview</p>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <!-- Total Books -->
                                <div class="p-4 bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg">
                                    <p class="text-sm font-medium text-gray-600">Total Books</p>
                                    <p class="text-3xl font-bold text-blue-600 mt-2"><%= request.getAttribute("totalBooks") %></p>
                                    <p class="text-xs text-gray-500 mt-2">📚 In library collection</p>
                                </div>

                                <!-- Total Users -->
                                <div class="p-4 bg-gradient-to-br from-green-50 to-green-100 rounded-lg">
                                    <p class="text-sm font-medium text-gray-600">Total Users</p>
                                    <p class="text-3xl font-bold text-green-600 mt-2"><%= request.getAttribute("totalUsers") %></p>
                                    <p class="text-xs text-gray-500 mt-2">👥 Registered accounts</p>
                                </div>

                                <!-- Total Categories -->
                                <div class="p-4 bg-gradient-to-br from-purple-50 to-purple-100 rounded-lg">
                                    <p class="text-sm font-medium text-gray-600">Categories</p>
                                    <p class="text-3xl font-bold text-purple-600 mt-2"><%= request.getAttribute("totalCategories") %></p>
                                    <p class="text-xs text-gray-500 mt-2">🏷️ Book categories</p>
                                </div>
                            </div>
                        </div>

                        <!-- Database Settings -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6 mb-6">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center">
                                    <span class="text-xl">💾</span>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">Database & Backup</h3>
                                    <p class="text-sm text-gray-500">Manage database and backups</p>
                                </div>
                            </div>

                            <div class="space-y-4">
                                <!-- Database Info -->
                                <div class="p-4 bg-gray-50 rounded-lg">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-sm font-medium text-gray-900">Database Status</p>
                                            <p class="text-xs text-gray-500 mt-1">MySQL 8.0 - Connected</p>
                                        </div>
                                        <span class="inline-flex items-center px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                            <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                                            Operational
                                        </span>
                                    </div>
                                </div>

                                <!-- Backup Options -->
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <button type="button" 
                                            onclick="alert('Backup feature will be implemented soon')" 
                                            class="px-6 py-3 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                                        💾 Create Backup
                                    </button>
                                    <button type="button" 
                                            onclick="alert('Restore feature will be implemented soon')" 
                                            class="px-6 py-3 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                                        ♻️ Restore Backup
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="bg-white rounded-lg border border-gray-200 p-6">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm text-gray-600">Make sure to save your changes before leaving this page.</p>
                                </div>
                                <div class="flex gap-3">
                                    <button type="button" 
                                            onclick="window.location.reload()" 
                                            class="px-6 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                                        Cancel
                                    </button>
                                    <button type="submit" 
                                            class="bg-gray-900 text-white px-6 py-2 rounded-lg text-sm font-medium hover:bg-gray-800 transition-colors">
                                        💾 Save Settings
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>