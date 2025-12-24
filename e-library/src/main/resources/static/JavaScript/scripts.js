// admin

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.submenu-toggle').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var submenu = btn.nextElementSibling;
            var chevron = btn.querySelector('[data-chevron]');
            if (!submenu) return;
            submenu.classList.toggle('hidden');
            if (chevron) chevron.classList.toggle('rotate-90');
        });
    });
});

// Initialize Lenis smooth scrolling
const lenis = new Lenis({
    duration: 1.2,
    easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
    smooth: true,
    smoothTouch: false,
});

function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
}
requestAnimationFrame(raf);

// GSAP Animations
gsap.registerPlugin(ScrollTrigger);

// Set initial states
gsap.set(".hero-badge", { y: 50, opacity: 0 });
gsap.set(".hero-word", { y: 100, opacity: 0 });
gsap.set(".hero-subtitle p", { y: 30, opacity: 0 });
gsap.set(".hero-cta button", { y: 40, opacity: 0 });
gsap.set(".hero-search", { y: 40, opacity: 0 });
gsap.set(".scroll-indicator", { y: 20, opacity: 0 });
gsap.set(".floating-leaf", { y: 20, opacity: 0, rotation: 0 });
gsap.set(".decorative-lines div", { scaleX: 0, opacity: 0 });

// Hero entrance animation
const tl = gsap.timeline({ delay: 0.5 });

tl.to(".hero-badge", {
    y: 0,
    opacity: 1,
    duration: 1,
    ease: "power3.out"
})
    .to(".hero-word", {
        y: 0,
        opacity: 1,
        duration: 1.2,
        stagger: 0.2,
        ease: "power3.out"
    }, "-=0.5")
    .to(".hero-subtitle p", {
        y: 0,
        opacity: 1,
        duration: 1,
        ease: "power3.out"
    }, "-=0.6")
    .to(".hero-cta button", {
        y: 0,
        opacity: 1,
        duration: 0.8,
        stagger: 0.1,
        ease: "power3.out"
    }, "-=0.4")
    .to(".hero-search", {
        y: 0,
        opacity: 1,
        duration: 0.8,
        ease: "power3.out"
    }, "-=0.3")
    .to(".scroll-indicator", {
        y: 0,
        opacity: 1,
        duration: 0.8,
        ease: "power3.out"
    }, "-=0.4")
    .to(".floating-leaf", {
        y: 0,
        opacity: 1,
        duration: 1.5,
        stagger: 0.3,
        ease: "power2.out"
    }, "-=1")
    .to(".decorative-lines div", {
        scaleX: 1,
        opacity: 1,
        duration: 1,
        stagger: 0.2,
        ease: "power2.out"
    }, "-=1");

// Parallax effect for background
gsap.to(".hero-bg", {
    yPercent: -50,
    ease: "none",
    scrollTrigger: {
        trigger: ".hero-section",
        start: "top bottom",
        end: "bottom top",
        scrub: true
    }
});

// Floating animations for leaves
gsap.to(".floating-leaf", {
    y: -20,
    rotation: 360,
    duration: 4,
    repeat: -1,
    yoyo: true,
    ease: "power1.inOut",
    stagger: {
        each: 0.5,
        repeat: -1
    }
});

// Scroll indicator animation
gsap.to(".scroll-dot", {
    y: 15,
    duration: 1.5,
    repeat: -1,
    yoyo: true,
    ease: "power2.inOut"
});

// Practice cards animation
gsap.set(".practice-card", { y: 60, opacity: 0 });

ScrollTrigger.create({
    trigger: ".content-section",
    start: "top 80%",
    onEnter: () => {
        gsap.to(".practice-card", {
            y: 0,
            opacity: 1,
            duration: 1,
            stagger: 0.2,
            ease: "power3.out"
        });
    }
});

// Button hover animations
document.querySelectorAll('.cta-primary, .cta-secondary').forEach(button => {
    button.addEventListener('mouseenter', () => {
        gsap.to(button, {
            scale: 1.05,
            duration: 0.3,
            ease: "power2.out"
        });
    });

    button.addEventListener('mouseleave', () => {
        gsap.to(button, {
            scale: 1,
            duration: 0.3,
            ease: "power2.out"
        });
    });
});

// Submenu toggle functionality
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.submenu-toggle').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var submenu = btn.nextElementSibling;
            var chevron = btn.querySelector('[data-chevron]');
            if (!submenu) return;
            submenu.classList.toggle('hidden');
            if (chevron) chevron.classList.toggle('rotate-90');
        });
    });
});

// Home page scripts
const booksData = [
    {
        id: 1,
        title: "Meditations",
        author: "Marcus Aurelius",
        category: "philosophy",
        year: "161-180 AD",
        description:
            "The personal writings of the Roman Emperor, offering timeless wisdom on virtue, mortality, and the human condition.",
        cover:
            "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300&h=400&fit=crop",
        tags: ["stoicism", "philosophy", "ancient rome"]
    },
    {
        id: 2,
        title: "The Republic",
        author: "Plato",
        category: "philosophy",
        year: "380 BC",
        description:
            "A Socratic dialogue concerning justice and the ideal state, exploring the nature of reality and knowledge.",
        cover:
            "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300&h=400&fit=crop",
        tags: ["philosophy", "politics", "ancient greece"]
    },
    {
        id: 3,
        title: "The Histories",
        author: "Herodotus",
        category: "history",
        year: "440 BC",
        description:
            "The first work of history in Western literature, chronicling the Persian Wars and ancient civilizations.",
        cover:
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=400&fit=crop",
        tags: ["history", "persian wars", "ancient civilizations"]
    },
    {
        id: 4,
        title: "The Iliad",
        author: "Homer",
        category: "literature",
        year: "8th century BC",
        description:
            "An epic poem telling the story of the Trojan War, exploring themes of honor, fate, and the human condition.",
        cover:
            "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300&h=400&fit=crop",
        tags: ["epic poetry", "trojan war", "ancient literature"]
    },
    {
        id: 5,
        title: "Natural History",
        author: "Pliny the Elder",
        category: "science",
        year: "77-79 AD",
        description:
            "An early encyclopedia covering astronomy, geography, zoology, botany, and mineralogy.",
        cover:
            "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300&h=400&fit=crop",
        tags: ["natural sciences", "encyclopedia", "roman knowledge"]
    },
    {
        id: 6,
        title: "Confessions",
        author: "Augustine of Hippo",
        category: "theology",
        year: "397-400 AD",
        description:
            "A spiritual autobiography exploring the nature of sin, redemption, and divine grace.",
        cover:
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=400&fit=crop",
        tags: ["theology", "autobiography", "christian philosophy"]
    },
    {
        id: 7,
        title: "The Aeneid",
        author: "Virgil",
        category: "literature",
        year: "29-19 BC",
        description:
            "An epic poem that tells the legendary story of Aeneas and the founding of Rome.",
        cover:
            "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300&h=400&fit=crop",
        tags: ["epic poetry", "roman mythology", "founding of rome"]
    },
    {
        id: 8,
        title: "Elements",
        author: "Euclid",
        category: "science",
        year: "300 BC",
        description:
            "A mathematical treatise consisting of 13 books on geometry and number theory.",
        cover:
            "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300&h=400&fit=crop",
        tags: ["mathematics", "geometry", "ancient science"]
    },
    {
        id: 9,
        title: "The Art of War",
        author: "Sun Tzu",
        category: "philosophy",
        year: "5th century BC",
        description:
            "An ancient Chinese military treatise on strategy, tactics, and warfare.",
        cover:
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=400&fit=crop",
        tags: ["strategy", "military", "ancient china"]
    },
    {
        id: 10,
        title: "The Canterbury Tales",
        author: "Geoffrey Chaucer",
        category: "literature",
        year: "1387-1400",
        description:
            "A collection of stories told by pilgrims on their way to Canterbury Cathedral.",
        cover:
            "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300&h=400&fit=crop",
        tags: ["medieval literature", "pilgrimage", "middle english"]
    },
    {
        id: 11,
        title: "City of God",
        author: "Augustine of Hippo",
        category: "theology",
        year: "413-426 AD",
        description:
            "A work of Christian philosophy defending Christianity against pagan critics.",
        cover:
            "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300&h=400&fit=crop",
        tags: ["theology", "christian philosophy", "late antiquity"]
    },
    {
        id: 12,
        title: "The Divine Comedy",
        author: "Dante Alighieri",
        category: "literature",
        year: "1308-1320",
        description:
            "An epic poem describing Dante's journey through Hell, Purgatory, and Paradise.",
        cover:
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=400&fit=crop",
        tags: ["epic poetry", "afterlife", "medieval literature"]
    }
];

let currentBooks = booksData;
let activeCategory = 'all';

// Function to create book card HTML
function createBookCard(book) {
    return `
<div
    class="book-card bg-white/80 backdrop-blur-sm rounded-xl shadow-xl border border-amber-200/50 hover:shadow-2xl transition-all duration-300 cursor-pointer overflow-hidden group">
    <div class="relative overflow-hidden">
        <img src="${book.cover}" alt="${book.title}"
            class="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-300">
        <div
            class="absolute inset-0 bg-gradient-to-t from-amber-900/60 to-transparent"></div>
        <div class="absolute top-3 right-3">
            <span
                class="px-2 py-1 bg-amber-700/80 text-amber-50 text-xs rounded-full font-medium">${book.year}</span>
        </div>
    </div>
    <div class="p-6">
        <h3
            class="text-lg font-bold text-amber-900 mb-2 line-clamp-2">${book.title}</h3>
        <p class="text-amber-700 text-sm mb-2 font-medium">by ${book.author}</p>
        <p
            class="text-amber-600 text-sm mb-4 line-clamp-3 leading-relaxed">${book.description}</p>
        <div class="flex flex-wrap gap-1 mb-4">
            ${book.tags.slice(0, 2).map(tag => `
            <span
                class="px-2 py-1 bg-amber-100 text-amber-700 text-xs rounded-full">${tag}</span>
            `).join('')}
        </div>
        <button
            class="w-full py-2 bg-gradient-to-r from-amber-600 to-amber-700 hover:from-amber-700 hover:to-amber-800 text-amber-50 rounded-lg transition-all duration-300 font-medium text-sm">
            Read Manuscript
        </button>
    </div>
</div>
`;
}

// Function to render books
function renderBooks(books) {
    const booksList = document.getElementById('booksList');
    booksList.innerHTML = books.map(book => createBookCard(book)).join('');

    // Animate book cards
    gsap.fromTo('.book-card',
        { y: 50, opacity: 0 },
        { y: 0, opacity: 1, duration: 0.8, stagger: 0.1, ease: "power3.out" }
    );
}

// Function to filter books by category
function filterBooks(category) {
    activeCategory = category;

    // Update filter buttons
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.classList.remove('bg-amber-600', 'text-amber-50');
        btn.classList.add('bg-amber-100', 'text-amber-800');
    });

    document.querySelector(`[data-category="${category}"]`).classList.remove('bg-amber-100',
        'text-amber-800');
    document.querySelector(`[data-category="${category}"]`).classList.add('bg-amber-600',
        'text-amber-50');

    if (category === 'all') {
        currentBooks = booksData;
    } else {
        currentBooks = booksData.filter(book => book.category === category);
    }

    renderBooks(currentBooks);
}

// Function to search books
function searchBooks(query) {
    if (!query.trim()) {
        renderBooks(activeCategory === 'all' ? booksData : booksData.filter(book =>
            book.category === activeCategory));
        return;
    }

    const filteredBooks = (activeCategory === 'all' ? booksData :
        booksData.filter(book => book.category === activeCategory))
        .filter(book =>
            book.title.toLowerCase().includes(query.toLowerCase()) ||
            book.author.toLowerCase().includes(query.toLowerCase()) ||
            book.description.toLowerCase().includes(query.toLowerCase()) ||
            book.tags.some(tag => tag.toLowerCase().includes(query.toLowerCase()))
        );

    renderBooks(filteredBooks);
}

// Event listeners
document.addEventListener('DOMContentLoaded', function () {
    // Initial render
    renderBooks(booksData);

    // Filter buttons
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            filterBooks(this.dataset.category);
        });
    });

    // Category cards
    document.querySelectorAll('.category-card').forEach(card => {
        card.addEventListener('click', function () {
            const category = this.dataset.category;
            filterBooks(category);
            document.getElementById('booksGrid').scrollIntoView({ behavior: 'smooth' });
        });
    });

    // Search functionality
    const searchInput = document.getElementById('mainSearch');
    let searchTimeout;

    searchInput.addEventListener('input', function () {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            searchBooks(this.value);
        }, 300);
    });

    // GSAP animations for page load
    gsap.registerPlugin(ScrollTrigger);

    gsap.fromTo('.category-card',
        { y: 60, opacity: 0 },
        { y: 0, opacity: 1, duration: 1, stagger: 0.2, ease: "power3.out", delay: 0.3 }
    );
});

// login

// GSAP Animations
document.addEventListener('DOMContentLoaded', function () {
    // Initial animations for two-panel layout
    gsap.fromTo('.w-1\\/2:first-child',
        { x: -100, opacity: 0 },
        { x: 0, opacity: 1, duration: 1, ease: "power3.out" }
    );

    gsap.fromTo('.w-1\\/2:last-child',
        { x: 100, opacity: 0 },
        { x: 0, opacity: 1, duration: 1, delay: 0.2, ease: "power3.out" }
    );

    gsap.fromTo('.form-field',
        { y: 30, opacity: 0 },
        {
            y: 0, opacity: 1, duration: 0.8, stagger: 0.15, delay: 0.8, ease: "power3.out"
        }
    );

    // Password toggle functionality
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    togglePassword.addEventListener('click', function () {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' :
            'password';
        passwordInput.setAttribute('type', type);
        this.textContent = type === 'password' ? '👁️' : '🙈';
    });

    // Form submission
    const form = document.getElementById('loginForm');
    form.addEventListener('submit', function (e) {
        e.preventDefault();

        // Success animation
        gsap.to('.form-container', {
            scale: 1.05,
            duration: 0.2,
            yoyo: true,
            repeat: 1,
            ease: "power2.inOut"
        });

        // Simulate login process
        const submitButton = form.querySelector('button[type="submit"]');
        const originalText = submitButton.textContent;

        submitButton.textContent = 'Unlocking Archive...';
        submitButton.disabled = true;

        setTimeout(() => {
            submitButton.textContent = 'Welcome Back! 📚';

            setTimeout(() => {
                window.location.href = 'home.html';
            }, 1000);
        }, 1500);
    });

    // Input focus animations
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', function () {
            gsap.to(this.parentElement, {
                scale: 1.02,
                duration: 0.3,
                ease: "power2.out"
            });
        });

        input.addEventListener('blur', function () {
            gsap.to(this.parentElement, {
                scale: 1,
                duration: 0.3,
                ease: "power2.out"
            });
        });
    });

    // Social login buttons
    document.querySelectorAll('button[type="button"]').forEach(button => {
        button.addEventListener('click', function () {
            if (this.textContent.includes('Academic Account')) {
                alert('🎓 Academic authentication coming soon!');
            } else if (this.textContent.includes('Library Card')) {
                alert('📚 Library card integration coming soon!');
            } else if (this.textContent.includes('Guest Reader')) {
                window.location.href = 'home.html';
            } else if (this.textContent.includes('Browse Catalog')) {
                window.location.href = 'home.html#booksGrid';
            }
        });
    });
});

// GSAP Animations for register
document.addEventListener('DOMContentLoaded', function () {
    // Initial animations for two-panel layout
    gsap.fromTo('.w-2\\/5',
        { x: -100, opacity: 0 },
        { x: 0, opacity: 1, duration: 1, ease: "power3.out" }
    );

    gsap.fromTo('.w-3\\/5',
        { x: 100, opacity: 0 },
        { x: 0, opacity: 1, duration: 1, delay: 0.2, ease: "power3.out" }
    );

    gsap.fromTo('.form-field',
        { y: 30, opacity: 0 },
        {
            y: 0, opacity: 1, duration: 0.8, stagger: 0.1, delay: 0.8, ease: "power3.out"
        }
    );

    // Password toggle functionality
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    togglePassword.addEventListener('click', function () {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' :
            'password';
        passwordInput.setAttribute('type', type);
        this.textContent = type === 'password' ? '👁️' : '🙈';
    });

    // Form validation
    const form = document.getElementById('registerForm');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');

    form.addEventListener('submit', function (e) {
        e.preventDefault();

        // Password match validation
        if (password.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity('Passwords do not match');
            confirmPassword.reportValidity();
            return;
        } else {
            confirmPassword.setCustomValidity('');
        }

        // Success animation
        gsap.to('.form-container', {
            scale: 1.05,
            duration: 0.2,
            yoyo: true,
            repeat: 1,
            ease: "power2.inOut"
        });

        // Simulate registration success
        setTimeout(() => {
            alert('Welcome to Bibliotheca! Your scholarly journey begins now.');
            window.location.href = 'login.html';
        }, 500);
    });

    // Real-time password confirmation
    confirmPassword.addEventListener('input', function () {
        if (this.value !== password.value) {
            this.setCustomValidity('Passwords do not match');
        } else {
            this.setCustomValidity('');
        }
    });

    // Input focus animations
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', function () {
            gsap.to(this.parentElement, {
                scale: 1.02,
                duration: 0.3,
                ease: "power2.out"
            });
        });

        input.addEventListener('blur', function () {
            gsap.to(this.parentElement, {
                scale: 1,
                duration: 0.3,
                ease: "power2.out"
            });
        });
    });
});
