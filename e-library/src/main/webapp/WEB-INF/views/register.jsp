<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • Register</title>
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
<body class="bg-gradient-to-br from-orange-50 via-orange-50 to-white min-h-screen flex items-center justify-center p-5">
    <div class="grid grid-cols-1 md:grid-cols-2 max-w-4xl w-full bg-white rounded-sm shadow-2xl overflow-hidden">
        
        <!-- Sidebar -->
        <div class="hidden md:flex flex-col justify-between bg-gradient-to-br from-stone-800 to-stone-900 p-16 text-orange-50 relative">
            <div class="relative z-10">
                <div class="text-5xl font-bold mb-10 text-amber-600">📚</div>
                <p class="text-sm leading-8 text-orange-100 mb-4">Join our community of readers and explore endless possibilities.</p>
                
                <div class="w-12 h-px bg-amber-600 my-8"></div>

                <div class="space-y-6">
                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0">✨</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Free Registration</strong>
                            Create your account in seconds
                        </div>
                    </div>

                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0">🔖</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Personalized Lists</strong>
                            Build your reading collection
                        </div>
                    </div>

                    <div class="flex gap-4">
                        <div class="w-8 h-8 rounded-full bg-amber-600 bg-opacity-20 flex items-center justify-center text-amber-600 flex-shrink-0">📖</div>
                        <div class="text-xs leading-relaxed text-orange-100">
                            <strong class="block text-orange-50">Unlimited Access</strong>
                            Browse millions of titles
                        </div>
                    </div>
                </div>
            </div>

            <p class="text-xs opacity-60 text-orange-100 relative z-10">Established 2024. Where literature lives.</p>
        </div>

        <!-- Register form -->
        <div class="p-12 md:p-16 flex flex-col justify-center">
            <div class="mb-10">
                <div class="w-16 h-px bg-amber-600 mb-6"></div>
                <h1 class="text-4xl md:text-5xl font-light text-stone-900 mb-3 tracking-tight playfair">Create Account</h1>
                <p class="text-sm text-green-700 font-normal">Join thousands of book lovers worldwide</p>
            </div>

            <!-- Error/Success Messages -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-sm text-sm mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("msg") != null) { %>
                <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-sm text-sm mb-4">
                    <%= request.getAttribute("msg") %>
                </div>
            <% } %>

            <form action="register" method="post" class="space-y-5">
                <!-- Full Name -->
                <div>
                    <label for="fullname" class="block text-xs font-semibold text-stone-900 mb-2 uppercase tracking-wider">Full Name</label>
                    <input 
                        type="text" 
                        id="fullname" 
                        name="fullname" 
                        placeholder="John Doe"
                        class="w-full px-4 py-3 border border-orange-100 rounded-sm text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Email -->
                <div>
                    <label for="reg-email" class="block text-xs font-semibold text-stone-900 mb-2 uppercase tracking-wider">Email Address</label>
                    <input 
                        type="email" 
                        id="reg-email" 
                        name="email" 
                        placeholder="reader@example.com"
                        class="w-full px-4 py-3 border border-orange-100 rounded-sm text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Password -->
                <div>
                    <label for="reg-password" class="block text-xs font-semibold text-stone-900 mb-2 uppercase tracking-wider">Password</label>
                    <input 
                        type="password" 
                        id="reg-password" 
                        name="password" 
                        placeholder="Create a strong password"
                        class="w-full px-4 py-3 border border-orange-100 rounded-sm text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Confirm Password -->
                <div>
                    <label for="confirm-password" class="block text-xs font-semibold text-stone-900 mb-2 uppercase tracking-wider">Confirm Password</label>
                    <input 
                        type="password" 
                        id="confirm-password" 
                        name="confirm-password" 
                        placeholder="Confirm your password"
                        class="w-full px-4 py-3 border border-orange-100 rounded-sm text-sm text-stone-900 bg-orange-50 transition-all duration-300 focus:outline-none focus:border-amber-600 focus:bg-white focus:ring-2 focus:ring-amber-600 focus:ring-opacity-10"
                        required
                    >
                </div>

                <!-- Terms checkbox -->
                <div class="flex items-start gap-3 pt-2">
                    <input 
                        type="checkbox" 
                        id="terms" 
                        name="terms"
                        value="true"
                        class="w-4 h-4 mt-1 cursor-pointer accent-amber-600 rounded"
                        required
                    >
                    <label for="terms" class="text-xs text-stone-700 font-normal cursor-pointer">
                        I agree to the <a href="#" class="text-amber-600 font-semibold hover:text-green-700 transition-colors">Terms of Service</a> and <a href="#" class="text-amber-600 font-semibold hover:text-green-700 transition-colors">Privacy Policy</a>
                    </label>
                </div>

                <!-- Register button -->
                <button 
                    type="submit" 
                    class="w-full py-3 px-4 bg-stone-900 text-orange-50 rounded-sm font-semibold text-xs uppercase cursor-pointer transition-all duration-300 hover:bg-green-700 hover:-translate-y-0.5 hover:shadow-xl active:translate-y-0 mt-8 mb-5 tracking-wider"
                >
                    Create Account
                </button>

                <!-- Login link -->
                <p class="text-center text-xs text-stone-900">
                    Already have an account? <a href="login" class="text-amber-600 font-bold hover:text-green-700 transition-colors">Sign In</a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>