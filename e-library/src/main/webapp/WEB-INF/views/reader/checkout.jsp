<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Library • Checkout</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        :root {
            --cream: #f5f1ed;
            --dark-brown: #2c2416;
            --gold: #a68a64;
            --sage: #6b7d6f;
            --light-gray: #e8e3dd;
        }

        body {
            background: linear-gradient(135deg, var(--cream) 0%, #faf8f5 50%);
            color: var(--dark-brown);
            min-height: 100vh;
        }

        .playfair {
            font-family: 'Playfair Display', serif;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--light-gray);
            border-radius: 2px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(166, 138, 100, 0.1);
        }

        .cta-button {
            width: 100%;
            padding: 14px 24px;
            border: none;
            border-radius: 2px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--dark-brown);
            color: var(--cream);
        }

        .cta-button:hover {
            background: var(--sage);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(44, 36, 22, 0.2);
        }

        .back-link {
            color: var(--sage);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--gold);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
            <div class="flex items-center gap-3">
                <span class="text-3xl">📚</span>
                <h1 class="text-2xl font-bold playfair text-amber-600">E-Library</h1>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <section class="max-w-3xl mx-auto px-6 py-16">
        <a href="${pageContext.request.contextPath}/subscription" class="back-link inline-block mb-8">← Back to Plans</a>
        
        <div class="text-center mb-12">
            <div class="w-16 h-px bg-amber-600 mx-auto mb-8"></div>
            <h1 class="text-4xl md:text-5xl font-light playfair text-stone-900 mb-4">Complete Your Subscription</h1>
            <p class="text-stone-600">Just one more step to start your reading journey</p>
        </div>

        <div class="bg-white rounded-sm shadow-xl p-8 md:p-12">
            <!-- Plan Summary -->
            <div class="bg-gradient-to-br from-amber-50 to-orange-50 rounded-sm p-6 mb-8">
                <h3 class="text-lg font-semibold playfair text-stone-900 mb-4">Plan Summary</h3>
                <div class="space-y-3">
                    <div class="flex justify-between items-center">
                        <span class="text-sm text-stone-600">Plan Type:</span>
                        <strong class="text-stone-900">${planType}</strong>
                    </div>
                    <div class="flex justify-between items-center">
                        <span class="text-sm text-stone-600">Duration:</span>
                        <strong class="text-stone-900">${planType == 'MONTHLY' ? '1 Month' : '12 Months'}</strong>
                    </div>
                    <div class="border-t border-stone-300 pt-3 mt-3">
                        <div class="flex justify-between items-center">
                            <span class="text-lg font-semibold text-stone-900">Total Amount:</span>
                            <span class="text-2xl font-bold playfair text-amber-600">₹${amount}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Billing Form -->
            <form action="${pageContext.request.contextPath}/subscription/process" method="post">
                <input type="hidden" name="planType" value="${planType}" />
                <input type="hidden" name="amount" value="${amount}" />
                
                <div class="space-y-6">
                    <div>
                        <label for="name" class="block text-sm font-semibold text-stone-900 mb-2">Full Name *</label>
                        <input type="text" id="name" name="name" class="form-input" required placeholder="Enter your full name" />
                    </div>
                    
                    <div>
                        <label for="email" class="block text-sm font-semibold text-stone-900 mb-2">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-input" required placeholder="your.email@example.com" />
                    </div>
                    
                    <div>
                        <label for="contact" class="block text-sm font-semibold text-stone-900 mb-2">Phone Number *</label>
                        <input type="tel" id="contact" name="contact" class="form-input" pattern="[0-9]{10}" required placeholder="10-digit mobile number" />
                    </div>
                </div>
                
                <div class="mt-8">
                    <button type="submit" class="cta-button">Proceed to Payment</button>
                </div>

                <p class="text-xs text-stone-500 text-center mt-6">By proceeding, you agree to our Terms of Service and Privacy Policy</p>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-stone-900 text-orange-100 py-12 mt-20">
        <div class="max-w-7xl mx-auto px-6 text-center">
            <div class="flex items-center justify-center gap-3 mb-6">
                <span class="text-3xl">📚</span>
                <h3 class="text-2xl font-bold playfair text-amber-600">E-Library</h3>
            </div>
            <p class="text-sm opacity-60">Established 2024. Where literature lives.</p>
        </div>
    </footer>
</body>
</html>