<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Sidebar</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
    <!-- Sidebar Navigation -->
        <aside class="w-64 bg-zinc-50 border-r border-zinc-200 flex flex-col">
            <div class="p-6 border-b border-zinc-200">
                <div class="flex items-center gap-6.5">
                    <div class="w-8 h-8 bg-zinc-900 rounded-md flex items-center mr-4 justify-center">
                        <span class="text-white font-bold text-sm">📚</span>
                    </div>
                    <div>
                        <h1 class="text-sm font-semibold text-zinc-900">E-Library</h1>
                        <p class="text-xs text-zinc-500">Admin Portal</p>
                    </div>
                </div>
            </div>
            
            <nav class="flex-1 px-3 py-6 space-y-1 overflow-y-auto">
                <ul class="text-sm">
                    <li>
                        <a href="/admin" class="flex items-center gap-3 px-4 py-3 rounded-lg text-zinc-600 hover:bg-zinc-100 text-sm font-medium transition">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m4 4h.01M12 20h.01M4 6h16"/></svg>
                            Overview
                        </a>
                    </li>

                    <li>
                        <button type="button" class="w-full flex items-center justify-between gap-3 px-4 py-3 rounded-lg text-zinc-900 font-medium bg-zinc-100 transition submenu-toggle">
                            <span class="flex items-center gap-3">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 20l9-5-9-5-9 5 9 5z"></path></svg>
                                Books
                            </span>
                            <svg data-chevron class="w-4 h-4 text-zinc-500 transform transition-transform rotate-90" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg>
                        </button>
                        <ul class="pl-10 mt-1 space-y-1 text-zinc-600 submenu">
                            <li><a href="/admin/books/add" class="block px-3 py-2 rounded hover:bg-zinc-100">Add Book</a></li>
                            <li><a href="/admin/books" class="block px-3 py-2 rounded bg-zinc-100 text-zinc-900 font-medium">Manage Books</a></li>
                        </ul>
                    </li>

                    <li>
                        <button type="button" class="w-full flex items-center justify-between gap-3 px-4 py-3 rounded-lg text-zinc-900 font-medium hover:bg-zinc-100 transition submenu-toggle">
                            <span class="flex items-center gap-3">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                                Users
                            </span>
                            <svg data-chevron class="w-4 h-4 text-zinc-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg>
                        </button>
                        <ul class="pl-10 mt-1 space-y-1 text-zinc-600 hidden submenu">
                            <li><a href="/admin/users" class="block px-3 py-2 rounded hover:bg-zinc-100">Manage Users</a></li>
                            <li><a href="#" class="block px-3 py-2 rounded hover:bg-zinc-100">Reading Records</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="/admin/settings" class="flex items-center gap-3 px-4 py-3 rounded-lg text-zinc-600 hover:bg-zinc-100 text-sm font-medium transition">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3"/></svg>
                            Settings
                        </a>
                    </li>
                </ul>
            </nav>

            <div class="p-4 border-t border-zinc-200">
                <div class="px-4 py-3 rounded-lg bg-zinc-100">
                    <p class="text-xs text-zinc-600 font-medium">Admin Account</p>
                    <p class="text-xs text-zinc-500 mt-1">${user != null ? user.email : 'admin@library.io'}</p>
                    <a href="/logout" class="mt-3 block w-full text-center px-3 py-2 bg-zinc-900 text-white text-xs font-medium rounded hover:bg-zinc-700 transition">
                        Logout
                    </a>
                </div>
            </div>
        </aside>
        <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
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

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.dropdown-toggle') && !event.target.closest('#filterDropdown')) {
                    document.getElementById('filterDropdown').classList.add('hidden');
                }
            });
        });
        </script>
    </body>
</html>