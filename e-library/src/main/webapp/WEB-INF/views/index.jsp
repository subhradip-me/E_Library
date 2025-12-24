<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library - Discover Your Next Great Read</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
        }
        .book-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(78, 52, 30, 0.15);
        }
        .nav-link {
            transition: color 0.3s ease;
            position: relative;
        }
        .nav-link:hover::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #b8860b;
        }
    </style>
</head>
<body class="bg-amber-50 text-stone-900">
    <!-- Navigation -->
    <nav class="sticky top-0 z-50 bg-white bg-opacity-95 backdrop-blur-sm border-b border-amber-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center gap-2">
                    <div class="w-8 h-8 bg-amber-900 rounded-sm flex items-center justify-center">
                        <span class="text-white font-bold text-sm">📚</span>
                    </div>
                    <h1 class="text-xl font-semibold text-amber-900">E-Library</h1>
                </div>
                
                <div class="hidden md:flex items-center gap-8">
                    <a href="#features" class="nav-link text-stone-700 hover:text-amber-900">Features</a>
                    <a href="#collection" class="nav-link text-stone-700 hover:text-amber-900">Collection</a>
                    <a href="#testimonials" class="nav-link text-stone-700 hover:text-amber-900">Stories</a>
                </div>
                
                <div class="flex items-center gap-3">
                    <a href="login" class="text-stone-700 hover:text-amber-900 transition-colors">Login</a>
                    <a href="register" class="px-6 py-2 bg-amber-900 text-white rounded-lg hover:bg-amber-800 transition-colors">Sign Up</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative overflow-hidden">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 md:py-32">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
                <!-- Left Content -->
                <div>
                    <span class="inline-block px-4 py-1 bg-amber-100 text-amber-900 rounded-full text-sm font-medium mb-6">
                        Your Literary Gateway
                    </span>
                    <h1 class="text-5xl md:text-6xl font-bold text-amber-950 mb-6 leading-tight">
                        Discover Stories That Transform You
                    </h1>
                    <p class="text-lg text-stone-700 mb-8 leading-relaxed">
                        Explore thousands of curated books across every genre. From timeless classics to contemporary masterpieces, find your next favorite read in our meticulously organized digital library.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <a href="home.html" class="px-8 py-3 bg-amber-900 text-white rounded-lg hover:bg-amber-800 transition-all transform hover:scale-105 text-center font-medium">
                            Start Exploring
                        </a>
                        <a href="#features" class="px-8 py-3 border-2 border-amber-200 text-amber-900 rounded-lg hover:bg-amber-50 transition-colors text-center font-medium">
                            Learn More
                        </a>
                    </div>
                    <div class="mt-12 pt-8 border-t border-amber-200 flex items-center gap-6">
                        <div>
                            <p class="text-3xl font-bold text-amber-900">50K+</p>
                            <p class="text-stone-600 text-sm">Books Available</p>
                        </div>
                        <div class="w-px h-12 bg-amber-200"></div>
                        <div>
                            <p class="text-3xl font-bold text-amber-900">25K+</p>
                            <p class="text-stone-600 text-sm">Active Readers</p>
                        </div>
                        <div class="w-px h-12 bg-amber-200"></div>
                        <div>
                            <p class="text-3xl font-bold text-amber-900">100+</p>
                            <p class="text-stone-600 text-sm">Categories</p>
                        </div>
                    </div>
                </div>

                <!-- Right Image -->
                <div class="hidden md:flex justify-center">
                    <div class="relative w-full max-w-md aspect-square bg-gradient-to-br from-amber-100 to-amber-50 rounded-2xl shadow-2xl overflow-hidden p-8 flex items-center justify-center">
                        <div class="relative w-full h-full">
                            <div class="absolute inset-0 bg-amber-900 bg-opacity-5 rounded-lg transform -rotate-6"></div>
                            <div class="relative bg-white rounded-lg p-6 shadow-lg transform rotate-3 h-full flex flex-col justify-between">
                                <div>
                                    <div class="h-4 bg-amber-100 rounded w-3/4 mb-3"></div>
                                    <div class="h-3 bg-amber-50 rounded w-full mb-2"></div>
                                    <div class="h-3 bg-amber-50 rounded w-5/6 mb-4"></div>
                                </div>
                                <p class="text-center text-amber-900 font-semibold">The Art of Reading</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 md:py-32 bg-white border-y border-amber-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-4xl md:text-5xl font-bold text-amber-950 mb-4">Why Choose E-Library?</h2>
                <p class="text-lg text-stone-600 max-w-2xl mx-auto">
                    Everything you need for a seamless reading experience, carefully curated for your enjoyment.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">📖</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Vast Collection</h3>
                    <p class="text-stone-700">
                        Over 50,000 titles spanning every genre and era, from ancient classics to modern bestsellers.
                    </p>
                </div>

                <!-- Feature 2 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">🔍</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Smart Search</h3>
                    <p class="text-stone-700">
                        Advanced filtering by genre, author, rating, and year. Find exactly what you're looking for instantly.
                    </p>
                </div>

                <!-- Feature 3 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">⭐</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Community Reviews</h3>
                    <p class="text-stone-700">
                        Read authentic reviews from thousands of readers and share your own literary insights.
                    </p>
                </div>

                <!-- Feature 4 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">📚</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Personalized Lists</h3>
                    <p class="text-stone-700">
                        Create custom reading lists and save your favorites for easy access anytime.
                    </p>
                </div>

                <!-- Feature 5 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">🌍</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Global Reach</h3>
                    <p class="text-stone-700">
                        Access literature translated into multiple languages from authors worldwide.
                    </p>
                </div>

                <!-- Feature 6 -->
                <div class="p-8 rounded-xl bg-amber-50 border border-amber-100 hover:shadow-lg transition-shadow">
                    <div class="text-4xl mb-4">🔐</div>
                    <h3 class="text-2xl font-bold text-amber-950 mb-3">Secure & Private</h3>
                    <p class="text-stone-700">
                        Your reading history and preferences are protected with industry-leading security.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Collection -->
    <section id="collection" class="py-20 md:py-32 bg-amber-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="mb-12">
                <h2 class="text-4xl md:text-5xl font-bold text-amber-950 mb-2">Featured Collection</h2>
                <p class="text-lg text-stone-600">Handpicked selections from our most beloved categories</p>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Book Card 1 -->
                <div class="book-card">
                    <div class="relative bg-gradient-to-br from-amber-800 to-amber-900 rounded-lg overflow-hidden mb-4 aspect-[3/4] shadow-lg">
                        <div class="absolute inset-0 flex items-center justify-center text-4xl">📖</div>
                    </div>
                    <h3 class="text-lg font-bold text-amber-950">The Great Gatsby</h3>
                    <p class="text-stone-600 text-sm mb-3">F. Scott Fitzgerald</p>
                    <div class="flex items-center gap-1 text-amber-600">
                        <span>★★★★★</span> <span class="text-xs text-stone-500">(4.8k)</span>
                    </div>
                </div>

                <!-- Book Card 2 -->
                <div class="book-card">
                    <div class="relative bg-gradient-to-br from-red-700 to-red-900 rounded-lg overflow-hidden mb-4 aspect-[3/4] shadow-lg">
                        <div class="absolute inset-0 flex items-center justify-center text-4xl">📖</div>
                    </div>
                    <h3 class="text-lg font-bold text-amber-950">Pride and Prejudice</h3>
                    <p class="text-stone-600 text-sm mb-3">Jane Austen</p>
                    <div class="flex items-center gap-1 text-amber-600">
                        <span>★★★★★</span> <span class="text-xs text-stone-500">(5.2k)</span>
                    </div>
                </div>

                <!-- Book Card 3 -->
                <div class="book-card">
                    <div class="relative bg-gradient-to-br from-blue-800 to-blue-900 rounded-lg overflow-hidden mb-4 aspect-[3/4] shadow-lg">
                        <div class="absolute inset-0 flex items-center justify-center text-4xl">📖</div>
                    </div>
                    <h3 class="text-lg font-bold text-amber-950">1984</h3>
                    <p class="text-stone-600 text-sm mb-3">George Orwell</p>
                    <div class="flex items-center gap-1 text-amber-600">
                        <span>★★★★☆</span> <span class="text-xs text-stone-500">(3.9k)</span>
                    </div>
                </div>

                <!-- Book Card 4 -->
                <div class="book-card">
                    <div class="relative bg-gradient-to-br from-green-800 to-green-900 rounded-lg overflow-hidden mb-4 aspect-[3/4] shadow-lg">
                        <div class="absolute inset-0 flex items-center justify-center text-4xl">📖</div>
                    </div>
                    <h3 class="text-lg font-bold text-amber-950">To Kill a Mockingbird</h3>
                    <p class="text-stone-600 text-sm mb-3">Harper Lee</p>
                    <div class="flex items-center gap-1 text-amber-600">
                        <span>★★★★★</span> <span class="text-xs text-stone-500">(6.1k)</span>
                    </div>
                </div>
            </div>

            <div class="text-center mt-12">
                <a href="home.html" class="inline-block px-8 py-3 bg-amber-900 text-white rounded-lg hover:bg-amber-800 transition-all transform hover:scale-105 font-medium">
                    Browse All Books
                </a>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="py-20 md:py-32 bg-white border-t border-amber-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-4xl md:text-5xl font-bold text-amber-950 mb-4">Reader Stories</h2>
                <p class="text-lg text-stone-600 max-w-2xl mx-auto">
                    Hear from our community of passionate readers and book lovers.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Testimonial 1 -->
                <div class="p-8 bg-amber-50 rounded-xl border border-amber-100">
                    <div class="flex gap-1 mb-4 text-amber-600">★★★★★</div>
                    <p class="text-stone-700 mb-6">
                        "E-Library has completely transformed my reading habits. The organization and vast collection make discovering new books effortless. I've read more in the last year than ever before!"
                    </p>
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-amber-300 rounded-full"></div>
                        <div>
                            <p class="font-semibold text-amber-950">Sarah Mitchell</p>
                            <p class="text-xs text-stone-600">Book Enthusiast</p>
                        </div>
                    </div>
                </div>

                <!-- Testimonial 2 -->
                <div class="p-8 bg-amber-50 rounded-xl border border-amber-100">
                    <div class="flex gap-1 mb-4 text-amber-600">★★★★★</div>
                    <p class="text-stone-700 mb-6">
                        "As an avid reader, I appreciate the thoughtful curation and community reviews. It's like having a personal librarian in my pocket!"
                    </p>
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-amber-400 rounded-full"></div>
                        <div>
                            <p class="font-semibold text-amber-950">James Chen</p>
                            <p class="text-xs text-stone-600">Fiction Lover</p>
                        </div>
                    </div>
                </div>

                <!-- Testimonial 3 -->
                <div class="p-8 bg-amber-50 rounded-xl border border-amber-100">
                    <div class="flex gap-1 mb-4 text-amber-600">★★★★★</div>
                    <p class="text-stone-700 mb-6">
                        "The search functionality is incredible. I found rare editions and forgotten classics I'd been searching for years. Highly recommended!"
                    </p>
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-yellow-400 rounded-full"></div>
                        <div>
                            <p class="font-semibold text-amber-950">Emma Rodriguez</p>
                            <p class="text-xs text-stone-600">Literary Scholar</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 md:py-32 bg-gradient-to-r from-amber-900 to-amber-800">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 class="text-4xl md:text-5xl font-bold text-white mb-6">Start Your Reading Journey Today</h2>
            <p class="text-xl text-amber-50 mb-10 max-w-2xl mx-auto">
                Join thousands of readers discovering their next favorite book. Sign up now and get access to our complete collection.
            </p>
            <a href="register.html" class="inline-block px-10 py-4 bg-white text-amber-900 rounded-lg hover:bg-amber-50 transition-all transform hover:scale-105 font-bold text-lg">
                Create Free Account
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-amber-950 text-amber-50 border-t border-amber-900">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <div class="w-8 h-8 bg-amber-300 rounded-sm flex items-center justify-center">
                            <span class="text-amber-950 font-bold text-sm">📚</span>
                        </div>
                        <h3 class="font-bold text-lg">E-Library</h3>
                    </div>
                    <p class="text-amber-100 text-sm">Your gateway to unlimited literary treasures.</p>
                </div>

                <div>
                    <h4 class="font-bold mb-4">Quick Links</h4>
                    <ul class="space-y-2 text-sm text-amber-100">
                        <li><a href="#" class="hover:text-white transition-colors">Browse Books</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Categories</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">About Us</a></li>
                    </ul>
                </div>

                <div>
                    <h4 class="font-bold mb-4">Support</h4>
                    <ul class="space-y-2 text-sm text-amber-100">
                        <li><a href="#" class="hover:text-white transition-colors">Help Center</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Contact Us</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Privacy Policy</a></li>
                    </ul>
                </div>

                <div>
                    <h4 class="font-bold mb-4">Follow Us</h4>
                    <div class="flex gap-4 text-sm">
                        <a href="#" class="hover:text-white transition-colors">Twitter</a>
                        <a href="#" class="hover:text-white transition-colors">Instagram</a>
                        <a href="#" class="hover:text-white transition-colors">Facebook</a>
                    </div>
                </div>
            </div>

            <div class="border-t border-amber-800 pt-8 text-center text-amber-100 text-sm">
                <p>&copy; 2025 E-Library. All rights reserved. Preserving the love of reading, one book at a time.</p>
            </div>
        </div>
    </footer>
</body>
</html>
