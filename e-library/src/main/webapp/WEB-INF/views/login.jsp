<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        /* ... (keep your existing CSS styles) ... */
    </style>
</head>
<body class="bg-gradient-to-br from-orange-50 via-orange-50 to-white min-h-screen flex items-center justify-center p-5">
    <div class="grid grid-cols-1 md:grid-cols-2 max-w-4xl w-full bg-white rounded-sm shadow-2xl overflow-hidden">
        
        <!-- Sidebar with record book aesthetic -->
        <div class="sidebar hidden md:flex flex-col justify-between bg-gradient-to-br from-stone-800 to-stone-900 p-16 text-orange-50 relative">
            
            <div class="relative z-10">
                <div class="text-5xl font-bold letter-spacing-2 mb-10 text-amber-600">📚</div>
                <p class="text-sm leading-8 text-orange-100 mb-4">Your gateway to infinite knowledge and timeless wisdom.</p>
                
                <!-- Gold divider line -->
                <div class="w-12 h-px bg-amber-600 my-8"></div>

                <!-- Feature cards -->
                <div class="space-y-6">
                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0 text-lg">✨</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Curated Collections</strong>
                            Explore thousands of hand-picked titles across all genres
                        </div>
                    </div>

                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0 text-lg">🔖</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Smart Search</strong>
                            Discover books using AI-powered recommendations
                        </div>
                    </div>

                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0 text-lg">📖</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Instant Access</strong>
                            Read instantly on any device, anytime, anywhere
                        </div>
                    </div>
                </div>
            </div>

            <p class="text-xs opacity-60 text-orange-100 relative z-10">Established 2024. Where literature lives.</p>
        </div>

        <!-- Login form section -->
        <div class="p-12 md:p-16 flex flex-col justify-center">
            <div class="mb-12">
                <div class="w-16 h-px bg-amber-600 mb-6"></div>
                <h1 class="text-4xl md:text-5xl font-light text-stone-900 mb-3 tracking-tight">Welcome Back</h1>
                <p class="text-sm text-green-700 font-normal">Access your personal library and reading collection</p>
            </div>

            <!-- Error/Success Messages -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-sm text-sm mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-sm text-sm mb-4">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("msg") != null) { %>
                <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-sm text-sm mb-4">
                    <%= request.getAttribute("msg") %>
                </div>
            <% } %>

            <form action="login" method="post" class="space-y-6">
                <!-- Email input field -->
                <div>
                    <label for="email" class="block text-xs font-semibold letter-spacing-1 text-stone-900 mb-2 uppercase">Email Address</label>
                    <input 
                        type="email" 
                        id="email" 
                        name="email" 
                        placeholder="reader@example.com"
                        class="w-full px-4 py-4 border border-orange-100 rounded-sm font-normal text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Password input field -->
                <div>
                    <label for="password" class="block text-xs font-semibold letter-spacing-1 text-stone-900 mb-2 uppercase">Password</label>
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder="Enter your password"
                        class="w-full px-4 py-4 border border-orange-100 rounded-sm font-normal text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Remember and forgot password -->
                <div class="flex justify-between items-center text-xs gap-2 mb-9">
                    <div class="flex items-center gap-2 cursor-pointer">
                        <input 
                            type="checkbox" 
                            id="remember" 
                            name="remember"
                            value="true"
                            class="w-4 h-4 cursor-pointer accent-amber-600 rounded"
                        >
                        <label for="remember" class="cursor-pointer text-stone-700 font-normal m-0 uppercase">Remember me</label>
                    </div>
                    <a href="#forgot" class="text-amber-600 font-semibold hover:text-green-700 transition-colors">Forgot password?</a>
                </div>

                <!-- Login button -->
                <button 
                    type="submit" 
                    class="w-full py-4 px-4 bg-stone-900 text-orange-50 rounded-sm font-semibold text-xs letter-spacing-2 uppercase cursor-pointer transition-all duration-300 hover:bg-green-700 hover:-translate-y-0.5 hover:shadow-xl active:translate-y-0 mb-5"
                >
                    Sign In
                </button>

                <!-- Sign up link -->
                <p class="text-center text-xs text-stone-900">
                    New to E-Library? <a href="register" class="text-amber-600 font-bold hover:text-green-700 transition-colors">Create an account</a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>