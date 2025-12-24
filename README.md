# 📚 E-Library Management System

![Java](https://img.shields.io/badge/Java-17-orange?style=flat&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.4-brightgreen?style=flat&logo=spring-boot)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat&logo=mysql)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📖 Introduction

The **E-Library Management System** is a comprehensive web-based solution designed to transform traditional libraries into efficient digital platforms. Built with modern web technologies, this system revolutionizes how libraries operate and serve their users in today's digital age.

### 🎯 Key Features

- **User Management**: Secure registration, login, and role-based access control (Admin/Reader)
- **Book Management**: Complete CRUD operations for books with categorization and tagging
- **Digital Library**: Upload and manage PDF books with cover images
- **Premium Content**: Subscription-based access to premium books
- **Search & Filter**: Advanced search functionality with category-based filtering
- **Rating & Reviews**: Users can rate and review books
- **Analytics Dashboard**: Track book popularity through click counts and ratings
- **Payment Integration**: Razorpay payment gateway for subscriptions
- **Responsive Design**: Mobile-friendly interface using Tailwind CSS

### 🚀 Technology Stack

- **Backend**: Spring Boot 3.3.4, Spring Data JPA
- **Frontend**: JSP, JSTL, Tailwind CSS
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Payment Gateway**: Razorpay
- **Server**: Embedded Tomcat

---

## 📋 Software Requirement Specification (SRS)

### 1. System Overview

The E-Library Management System is a web-based application that allows administrators to manage digital books and users to access, read, and interact with the library content.

### 2. Functional Requirements

#### 2.1 User Management
- **FR-1.1**: System shall allow users to register with email, password, and full name
- **FR-1.2**: System shall authenticate users via email and password
- **FR-1.3**: System shall support two roles: Admin and Reader
- **FR-1.4**: System shall allow admins to enable/disable user accounts
- **FR-1.5**: System shall track user creation timestamp

#### 2.2 Book Management
- **FR-2.1**: System shall allow admins to add new books with metadata (title, author, year, pages, summary)
- **FR-2.2**: System shall allow admins to upload book covers and PDF files
- **FR-2.3**: System shall support book categorization
- **FR-2.4**: System shall allow admins to mark books as premium content
- **FR-2.5**: System shall track book status (draft, published, archived)
- **FR-2.6**: System shall track book availability (available, restricted)
- **FR-2.7**: System shall track click counts for analytics

#### 2.3 Category Management
- **FR-3.1**: System shall allow admins to create, update, and delete categories
- **FR-3.2**: System shall ensure category names are unique
- **FR-3.3**: System shall allow category descriptions

#### 2.4 Rating System
- **FR-4.1**: System shall allow users to rate books (1-5 stars)
- **FR-4.2**: System shall calculate average ratings for books
- **FR-4.3**: System shall track rating timestamps

#### 2.5 Review System
- **FR-5.1**: System shall allow users to write text reviews for books
- **FR-5.2**: System shall display reviewer names with reviews
- **FR-5.3**: System shall track review creation and update timestamps

#### 2.6 Subscription Management
- **FR-6.1**: System shall offer monthly and annual subscription plans
- **FR-6.2**: System shall integrate with Razorpay for payment processing
- **FR-6.3**: System shall track subscription status (active, expired)
- **FR-6.4**: System shall grant access to premium content for subscribed users

#### 2.7 Search and Navigation
- **FR-7.1**: System shall allow users to search books by title, author, or tags
- **FR-7.2**: System shall allow filtering books by category
- **FR-7.3**: System shall display book recommendations based on popularity

### 3. Non-Functional Requirements

#### 3.1 Performance
- **NFR-1.1**: System shall load pages within 3 seconds under normal load
- **NFR-1.2**: System shall support at least 100 concurrent users
- **NFR-1.3**: Database queries shall be optimized with proper indexing

#### 3.2 Security
- **NFR-2.1**: System shall store passwords securely (hashed)
- **NFR-2.2**: System shall implement session management
- **NFR-2.3**: System shall protect against SQL injection attacks
- **NFR-2.4**: System shall restrict unauthorized access to admin functions

#### 3.3 Usability
- **NFR-3.1**: System shall have an intuitive and responsive user interface
- **NFR-3.2**: System shall work on modern web browsers (Chrome, Firefox, Safari, Edge)
- **NFR-3.3**: System shall be mobile-responsive

#### 3.4 Reliability
- **NFR-4.1**: System shall have 99% uptime
- **NFR-4.2**: System shall handle errors gracefully with appropriate messages
- **NFR-4.3**: System shall maintain data integrity with transactions

#### 3.5 Maintainability
- **NFR-5.1**: System shall follow MVC architectural pattern
- **NFR-5.2**: System shall have modular and reusable code
- **NFR-5.3**: System shall use standard coding conventions

### 4. System Constraints

- **SC-1**: System requires Java 17 or higher
- **SC-2**: System requires MySQL 8.0 or higher
- **SC-3**: System requires internet connection for payment processing
- **SC-4**: File uploads are limited by server configuration

### 5. User Roles and Permissions

| Feature | Admin | Reader |
|---------|-------|--------|
| View Books | ✓ | ✓ |
| Read Free Books | ✓ | ✓ |
| Read Premium Books | ✓ | ✓ (with subscription) |
| Add/Edit/Delete Books | ✓ | ✗ |
| Manage Categories | ✓ | ✗ |
| Manage Users | ✓ | ✗ |
| Rate Books | ✓ | ✓ |
| Write Reviews | ✓ | ✓ |
| Subscribe | ✗ | ✓ |
| View Analytics | ✓ | ✗ |

---

## 📁 Project Structure

```
e-library/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── e_library/
│   │   │               ├── ELibraryApplication.java          # Main application entry point
│   │   │               ├── ServletInitializer.java           # WAR deployment initializer
│   │   │               ├── config/                           # Configuration classes
│   │   │               │   ├── AuthenticationInterceptor.java # Session/auth interceptor
│   │   │               │   └── WebConfig.java                # Web MVC configuration
│   │   │               ├── controller/                       # REST/Web Controllers
│   │   │               │   ├── AdminController.java          # Admin dashboard & management
│   │   │               │   ├── AuthController.java           # Login/Register/Logout
│   │   │               │   ├── HomeController.java           # Public home page
│   │   │               │   ├── IncludesController.java       # Partial views (fragments)
│   │   │               │   ├── OrderController.java          # Subscription orders
│   │   │               │   ├── ReaderController.java         # Reader dashboard & features
│   │   │               │   └── SubscriptionController.java   # Subscription management
│   │   │               ├── model/                            # JPA Entity classes
│   │   │               │   ├── Book.java                     # Book entity
│   │   │               │   ├── Category.java                 # Category entity
│   │   │               │   ├── Rating.java                   # Rating entity
│   │   │               │   ├── Review.java                   # Review entity
│   │   │               │   ├── Subscription.java             # Subscription entity
│   │   │               │   └── User.java                     # User entity
│   │   │               ├── repository/                       # Spring Data JPA repositories
│   │   │               │   ├── BookRepository.java
│   │   │               │   ├── CategoryRepository.java
│   │   │               │   ├── RatingRepository.java
│   │   │               │   ├── ReviewRepository.java
│   │   │               │   ├── SubscriptionRepository.java
│   │   │               │   └── UserRepository.java
│   │   │               └── service/                          # Business logic layer
│   │   │                   ├── BookService.java
│   │   │                   ├── CategoryService.java
│   │   │                   ├── RatingService.java
│   │   │                   ├── ReviewService.java
│   │   │                   ├── SubscriptionService.java
│   │   │                   └── UserService.java
│   │   ├── resources/
│   │   │   ├── application.properties                        # Application configuration
│   │   │   ├── META-INF/
│   │   │   │   └── additional-spring-configuration-metadata.json
│   │   │   └── static/                                       # Static assets
│   │   │       ├── css/
│   │   │       │   └── styles.css                            # Custom styles
│   │   │       ├── fonts/                                    # Font files
│   │   │       ├── images/                                   # Static images
│   │   │       ├── JavaScript/
│   │   │       │   ├── admin.js                              # Admin dashboard scripts
│   │   │       │   └── scripts.js                            # General scripts
│   │   │       └── uploads/                                  # User uploaded files
│   │   │           ├── covers/                               # Book cover images
│   │   │           └── pdfs/                                 # Book PDF files
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/                                    # JSP view templates
│   │               ├── about.jsp                             # About page
│   │               ├── index.jsp                             # Landing page
│   │               ├── login.jsp                             # Login page
│   │               ├── register.jsp                          # Registration page
│   │               ├── admin/                                # Admin views
│   │               │   ├── dashboard.jsp                     # Admin dashboard
│   │               │   ├── manage-user.jsp                   # User management
│   │               │   ├── settings.jsp                      # Admin settings
│   │               │   └── books/                            # Book management views
│   │               │       ├── add-book.jsp
│   │               │       ├── edit-book.jsp
│   │               │       └── list-books.jsp
│   │               ├── includes/                             # Reusable fragments
│   │               │   ├── admin/                            # Admin fragments
│   │               │   │   ├── header.jsp
│   │               │   │   ├── footer.jsp
│   │               │   │   └── sidebar.jsp
│   │               │   └── reader/                           # Reader fragments
│   │               │       ├── header.jsp
│   │               │       └── footer.jsp
│   │               └── reader/                               # Reader views
│   │                   ├── book.jsp                          # Book detail page
│   │                   ├── category.jsp                      # Category page
│   │                   ├── checkout.jsp                      # Subscription checkout
│   │                   ├── home.jsp                          # Reader dashboard
│   │                   ├── order-success.jsp                 # Order confirmation
│   │                   ├── order.jsp                         # Order history
│   │                   └── subscription.jsp                  # Subscription management
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   └── e_library/
│                       └── ELibraryApplicationTests.java     # Unit tests
├── target/                                                    # Compiled classes (build output)
├── .gitignore                                                 # Git ignore rules
├── pom.xml                                                    # Maven configuration
├── mvnw                                                       # Maven wrapper (Unix)
├── mvnw.cmd                                                   # Maven wrapper (Windows)
└── README.md                                                  # Project documentation
```

### 📂 Key Directory Descriptions

- **config/**: Contains Spring configuration classes including interceptors and web configuration
- **controller/**: MVC controllers handling HTTP requests and routing
- **model/**: JPA entity classes representing database tables
- **repository/**: Spring Data JPA interfaces for database operations
- **service/**: Business logic layer containing service classes
- **static/**: Static resources like CSS, JavaScript, images, and user uploads
- **views/**: JSP templates for rendering HTML pages
- **test/**: Unit and integration test classes

---

## 🗄️ Entity Relationship Diagram (ERD)

### Database Schema

The E-Library system uses **6 main entities** to manage the digital library:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          E-LIBRARY DATABASE SCHEMA                       │
└─────────────────────────────────────────────────────────────────────────┘

┌──────────────────────┐           ┌──────────────────────┐
│      USERS           │           │     CATEGORIES       │
├──────────────────────┤           ├──────────────────────┤
│ PK: id (INT)         │           │ PK: id (INT)         │
│     fullname (STR)   │           │     name (STR) UQ    │
│     email (STR) UQ   │           │     description(STR) │
│     password (STR)   │           └──────────────────────┘
│     role (STR)       │                      │
│     enabled (BOOL)   │                      │
│     subscribed(BOOL) │                      │
│     createdAt (DT)   │                      │
└──────────────────────┘                      │
         │                                    │
         │ 1                                  │
         │                                    │
         │                                    │ 1
         │ *                                  │
         │                                    │
┌────────┴────────────┐              ┌───────┴──────────────┐
│   SUBSCRIPTIONS     │              │       BOOKS          │
├─────────────────────┤              ├──────────────────────┤
│ PK: id (BIGINT)     │              │ PK: id (INT)         │
│ FK: user_id (INT)   │              │ FK: category_id(INT) │
│     type (STR)      │              │     title (STR)      │
│     start_date (DT) │              │     author (STR)     │
│     end_date (DT)   │              │     year (INT)       │
│     status (STR)    │              │     pages (INT)      │
└─────────────────────┘              │     summary (TEXT)   │
                                     │     cover (STR)      │
                                     │     pdfUrl (STR)     │
                                     │     tags (STR)       │
                                     │     status (STR)     │
                                     │     availability(STR)│
                                     │     premium (BOOL)   │
                                     │     clickCount (LONG)│
                                     │     createdAt (DT)   │
                                     │     updatedAt (DT)   │
                                     └──────────────────────┘
                                              │
                                              │ 1
                    ┌─────────────────────────┼─────────────────────────┐
                    │                         │                         │
                    │ *                       │ *                       │ *
                    │                         │                         │
         ┌──────────┴─────────┐    ┌─────────┴────────┐    ┌──────────┴──────────┐
         │      RATINGS       │    │      REVIEWS      │    │   (Future: Orders)  │
         ├────────────────────┤    ├───────────────────┤    │                     │
         │ PK: id (INT)       │    │ PK: id (INT)      │    │  For order tracking │
         │ FK: book_id (INT)  │    │ FK: book_id (INT) │    │  and history        │
         │     userName (STR) │    │     content (TEXT)│    │                     │
         │     rating (INT)   │    │     reviewerName  │    └─────────────────────┘
         │     createdAt (DT) │    │     createdAt (DT)│
         │     updatedAt (DT) │    │     updatedAt (DT)│
         └────────────────────┘    └───────────────────┘
```

### Entity Details

#### 1. **USERS**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INT | PK, Auto-increment | Unique identifier |
| fullname | VARCHAR(255) | NOT NULL | User's full name |
| email | VARCHAR(255) | UNIQUE, NOT NULL | Login email |
| password | VARCHAR(255) | NOT NULL | Encrypted password |
| role | VARCHAR(50) | NOT NULL | Admin or Reader |
| enabled | BOOLEAN | DEFAULT true | Account status |
| subscribed | BOOLEAN | DEFAULT false | Subscription status |
| createdAt | DATETIME | NOT NULL | Registration timestamp |

**Business Rules:**
- Email must be unique across all users
- Default role is "Reader"
- Password should be stored encrypted (BCrypt recommended)
- Enabled flag allows admin to deactivate accounts

#### 2. **CATEGORIES**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INT | PK, Auto-increment | Unique identifier |
| name | VARCHAR(128) | UNIQUE, NOT NULL | Category name |
| description | VARCHAR(512) | NULL | Category description |

**Business Rules:**
- Category names must be unique
- Categories can have multiple books
- Deleting a category should handle associated books (SET NULL or CASCADE)

#### 3. **BOOKS**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INT | PK, Auto-increment | Unique identifier |
| title | VARCHAR(512) | NOT NULL | Book title |
| author | VARCHAR(256) | NOT NULL | Author name |
| category_id | INT | FK to Categories | Book category |
| year | INT | NULL | Publication year |
| pages | INT | NULL | Number of pages |
| summary | TEXT(8192) | NULL | Book description |
| cover | VARCHAR(1024) | NULL | Cover image path |
| pdfUrl | VARCHAR(1024) | NULL | PDF file path |
| tags | VARCHAR(512) | NULL | Comma-separated tags |
| status | VARCHAR(50) | NULL | draft/published/archived |
| availability | VARCHAR(50) | NULL | available/restricted |
| premium | BOOLEAN | DEFAULT false | Premium content flag |
| clickCount | BIGINT | DEFAULT 0 | View counter |
| createdAt | DATETIME | Auto | Creation timestamp |
| updatedAt | DATETIME | Auto | Last update timestamp |

**Business Rules:**
- Premium books require active subscription
- Click count increments on book view
- Status controls visibility: only "published" books appear to readers
- Availability can restrict access further

#### 4. **RATINGS**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INT | PK, Auto-increment | Unique identifier |
| book_id | INT | FK to Books | Referenced book |
| userName | VARCHAR(100) | NOT NULL | Rater's name |
| rating | INT | 1-5, NOT NULL | Star rating |
| createdAt | DATETIME | Auto | Rating timestamp |
| updatedAt | DATETIME | Auto | Update timestamp |

**Business Rules:**
- Rating must be between 1 and 5
- One user can rate a book multiple times (consider unique constraint for user+book)
- Average rating calculated from all ratings

#### 5. **REVIEWS**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | INT | PK, Auto-increment | Unique identifier |
| book_id | INT | FK to Books | Referenced book |
| content | TEXT(2000) | NOT NULL | Review text |
| reviewerName | VARCHAR(100) | NOT NULL | Reviewer's name |
| createdAt | DATETIME | Auto | Review timestamp |
| updatedAt | DATETIME | Auto | Update timestamp |

**Business Rules:**
- Reviews have character limit (2000 chars)
- Both authenticated and guest users can review (tracked by name)
- Reviews can be edited (updatedAt tracks changes)

#### 6. **SUBSCRIPTIONS**
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | BIGINT | PK, Auto-increment | Unique identifier |
| user_id | INT | FK to Users | Subscriber |
| type | VARCHAR(50) | NOT NULL | MONTHLY/ANNUAL |
| start_date | DATE | NOT NULL | Subscription start |
| end_date | DATE | NOT NULL | Subscription expiry |
| status | VARCHAR(50) | NOT NULL | ACTIVE/EXPIRED |

**Business Rules:**
- User can have multiple subscriptions (track history)
- Active subscription grants access to premium content
- System should auto-update status based on end_date
- Payment processed through Razorpay gateway

### Relationships

1. **User → Subscription**: One-to-Many (1:N)
   - A user can have multiple subscriptions over time
   
2. **Category → Book**: One-to-Many (1:N)
   - Each category can contain multiple books
   - Each book belongs to one category

3. **Book → Rating**: One-to-Many (1:N)
   - A book can have multiple ratings
   - Each rating belongs to one book

4. **Book → Review**: One-to-Many (1:N)
   - A book can have multiple reviews
   - Each review belongs to one book

---

## 🔄 Data Flow Diagrams (DFD)

### DFD Level 0 (Context Diagram)

```
                        ┌─────────────────────────────────────┐
                        │                                     │
                        │      E-LIBRARY MANAGEMENT SYSTEM    │
                        │                                     │
                        │  • User Management                  │
     ┌──────────┐       │  • Book Management                  │       ┌──────────┐
     │          │       │  • Category Management              │       │          │
     │  ADMIN   │◄─────►│  • Subscription Management          │◄─────►│  READER  │
     │          │       │  • Rating & Review System           │       │          │
     └──────────┘       │  • Payment Processing               │       └──────────┘
                        │  • Analytics & Reporting            │
                        │                                     │
                        └───────────▲─────────▲───────────────┘
                                    │         │
                                    │         │
                                    │         │
                          ┌─────────┴─┐   ┌──┴────────┐
                          │           │   │           │
                          │  DATABASE │   │  RAZORPAY │
                          │  (MySQL)  │   │  GATEWAY  │
                          │           │   │           │
                          └───────────┘   └───────────┘
```

**External Entities:**
1. **Admin**: Manages books, categories, users, and views analytics
2. **Reader**: Browses books, subscribes, rates, and reviews
3. **Database**: Stores all application data
4. **Razorpay Gateway**: Processes subscription payments

---

### DFD Level 1 (System Overview)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    E-LIBRARY MANAGEMENT SYSTEM - LEVEL 1                    │
└────────────────────────────────────────────────────────────────────────────┘

ADMIN                                                                    READER
  │                                                                         │
  │ Login credentials                                                       │ Login/Register
  ├────────────►┌──────────────────┐                                      │
  │             │   1.0             │                        ┌─────────────┘
  │             │ AUTHENTICATION   │◄───────────────────────┤
  │             │   & ACCESS       │                        │ User credentials
  │             │   CONTROL        │                        │
  │             └────────┬─────────┘                        │
  │                      │ User data                        │
  │                      ▼                                  │
  │                   [D1: USERS]                           │
  │                      │                                  │
  │ Book/Category mgmt   │                                  │ Browse/Search
  ├────────────►┌────────┴─────────┐◄──────────────────────┤
  │             │   2.0             │                       │
  │             │  CONTENT          │                       │
  │             │  MANAGEMENT       │                       │
  │             │  (Books/Category) │                       │
  │             └────────┬──────────┘                       │
  │                      │ Books, Categories                │
  │                      ▼                                  │
  │            [D2: BOOKS] [D3: CATEGORIES]                 │
  │                      │                                  │
  │                      │ Book data                        │
  │                      │                                  │
  │ View analytics       │                                  │ Rate/Review
  ├────────────►┌────────┴─────────┐◄──────────────────────┤
  │             │   3.0             │                       │
  │             │  RATING &         │                       │
  │             │  REVIEW           │                       │
  │             │  MANAGEMENT       │                       │
  │             └────────┬──────────┘                       │
  │                      │ Ratings, Reviews                 │
  │                      ▼                                  │
  │             [D4: RATINGS] [D5: REVIEWS]                 │
  │                                                         │
  │                                                         │ Subscribe
  │                                                         ├────────────┐
  │                      ┌──────────────────┐◄─────────────┘            │
  │                      │   4.0             │                           │
  │                      │  SUBSCRIPTION     │                           │
  │                      │  & PAYMENT        │                           │
  │                      │  PROCESSING       │                           │
  │                      └────────┬──────────┘                           │
  │                               │ Subscription data                    │
  │                               ▼                                      │
  │                      [D6: SUBSCRIPTIONS]                             │
  │                               │                                      │
  │                               │ Payment request                      │
  │                               ▼                                      │
  │                       ┌───────────────┐                              │
  └───────────────────────┤   RAZORPAY    ├──────────────────────────────┘
                          │   GATEWAY     │  Payment confirmation
                          └───────────────┘
```

**Main Processes:**

1. **Process 1.0 - Authentication & Access Control**
   - Input: Login credentials (Admin/Reader)
   - Output: Session token, User role
   - Data Store: D1 (USERS)

2. **Process 2.0 - Content Management**
   - Input: Book/Category CRUD operations
   - Output: Updated book/category list
   - Data Stores: D2 (BOOKS), D3 (CATEGORIES)

3. **Process 3.0 - Rating & Review Management**
   - Input: User ratings and reviews
   - Output: Aggregated ratings, review list
   - Data Stores: D4 (RATINGS), D5 (REVIEWS)

4. **Process 4.0 - Subscription & Payment Processing**
   - Input: Subscription requests
   - Output: Payment confirmation, subscription status
   - Data Store: D6 (SUBSCRIPTIONS)

---

### DFD Level 2 - Process 2.0 (Content Management)

```
┌──────────────────────────────────────────────────────────────────────────┐
│              PROCESS 2.0 - CONTENT MANAGEMENT (Level 2)                   │
└──────────────────────────────────────────────────────────────────────────┘

ADMIN                                                              READER
  │                                                                   │
  │ Add/Edit Book                                                     │
  ├───────────►┌─────────────────┐                                  │
  │            │   2.1             │                                  │
  │            │  MANAGE BOOKS     │                                  │
  │            │  (CRUD)           │                                  │
  │            └────────┬──────────┘                                  │
  │                     │ Book data                                   │
  │                     ▼                                             │
  │            ┌─────────────────┐                                   │
  │            │  FILE UPLOAD     │                                   │
  │            │  (Cover/PDF)     │                                   │
  │            └────────┬─────────┘                                   │
  │                     │ File paths                                  │
  │                     ▼                                             │
  │              [D2: BOOKS]                                          │
  │                     │                                             │
  │ Manage Category     │                                             │ Search/Filter
  ├───────────►┌───────┴────────┐◄──────────────────────────────────┤
  │            │   2.2            │                                   │
  │            │  MANAGE          │                                   │
  │            │  CATEGORIES      │                                   │
  │            └────────┬─────────┘                                   │
  │                     │ Category data                               │
  │                     ▼                                             │
  │            [D3: CATEGORIES]                                       │
  │                     │                                             │
  │                     │                                             │
  │                     │                                             │ View books
  │            ┌────────┴─────────┐◄──────────────────────────────────┤
  │            │   2.3             │                                   │
  │            │  BOOK SEARCH      │                                   │
  │            │  & FILTER         │                                   │
  │            └────────┬──────────┘                                   │
  │                     │ Query results                                │
  │                     │                                              │
  │                     │ Filtered books                               │
  │                     └──────────────────────────────────────────────►
  │                                                                    │
  │                     ┌──────────────┐                              │
  │                     │   2.4         │◄─────────────────────────────┤
  │                     │  BOOK VIEW    │  Click book                  │
  │                     │  & ANALYTICS  │                              │
  │                     └────────┬──────┘                              │
  │                              │ Increment click                     │
  │                              ▼                                     │
  │                       [D2: BOOKS]                                  │
  │                       (Update clickCount)                          │
```

**Sub-Processes:**

**2.1 - Manage Books (CRUD)**
- **Inputs**: Book details (title, author, summary, etc.), Admin credentials
- **Outputs**: Success/Error message
- **Process**: 
  - Validate book data
  - Upload cover image and PDF
  - Store file paths in database
  - Save book metadata
- **Data Store**: D2 (BOOKS)

**2.2 - Manage Categories**
- **Inputs**: Category name, description, Admin credentials
- **Outputs**: Category list, Success/Error message
- **Process**:
  - Create/Update/Delete categories
  - Ensure unique category names
  - Handle books associated with deleted categories
- **Data Store**: D3 (CATEGORIES)

**2.3 - Book Search & Filter**
- **Inputs**: Search query (title/author/tags), Category filter, Reader request
- **Outputs**: Filtered book list
- **Process**:
  - Search books by title, author, or tags
  - Filter by category
  - Filter by premium status (if not subscribed)
  - Sort by popularity (click count), date, or title
- **Data Stores**: D2 (BOOKS), D3 (CATEGORIES)

**2.4 - Book View & Analytics**
- **Inputs**: Book ID, Reader request
- **Outputs**: Book details, PDF viewer
- **Process**:
  - Retrieve book details
  - Increment click count
  - Check premium access (subscription required)
  - Display book with ratings and reviews
- **Data Store**: D2 (BOOKS)

---

### DFD Level 2 - Process 4.0 (Subscription & Payment)

```
┌──────────────────────────────────────────────────────────────────────────┐
│         PROCESS 4.0 - SUBSCRIPTION & PAYMENT (Level 2)                    │
└──────────────────────────────────────────────────────────────────────────┘

READER
  │
  │ Select plan
  ├────────────►┌─────────────────┐
  │             │   4.1             │
  │             │  SUBSCRIPTION     │
  │             │  PLAN SELECTION   │
  │             └────────┬──────────┘
  │                      │ Plan: Monthly/Annual
  │                      ▼
  │             ┌─────────────────┐
  │             │   4.2             │
  │             │  PAYMENT          │
  │             │  INITIATION       │
  │             └────────┬──────────┘
  │                      │ Amount, User ID
  │                      │
  │                      ▼
  │             ┌────────────────┐
  │             │   RAZORPAY     │
  │             │   GATEWAY      │
  │             └────────┬───────┘
  │                      │ Payment response
  │                      ▼
  │             ┌─────────────────┐
  │             │   4.3             │
  │             │  PAYMENT          │
  │             │  VERIFICATION     │
  │             └────────┬──────────┘
  │                      │ Success/Failure
  │                      │
  │        Success       │       Failure
  │        ┌─────────────┴──────────┐
  │        ▼                        ▼
  │   ┌──────────────┐      ┌──────────────┐
  │   │   4.4         │      │   4.5         │
  │   │  CREATE       │      │  PAYMENT      │
  │   │  SUBSCRIPTION │      │  FAILURE      │
  │   └───────┬───────┘      │  HANDLER      │
  │           │              └───────────────┘
  │           │ Subscription data
  │           ▼
  │    [D6: SUBSCRIPTIONS]
  │           │
  │           │ Update user status
  │           ▼
  │     [D1: USERS]
  │     (Set subscribed=true)
  │           │
  │           │ Confirmation
  │           └──────────────────────────►
```

**Sub-Processes:**

**4.1 - Subscription Plan Selection**
- **Inputs**: Reader selection (Monthly/Annual)
- **Outputs**: Plan details (price, duration)
- **Process**:
  - Display available plans
  - Calculate pricing
  - Prepare checkout

**4.2 - Payment Initiation**
- **Inputs**: Plan selection, User ID
- **Outputs**: Razorpay order ID
- **Process**:
  - Create payment order
  - Generate Razorpay checkout
  - Redirect to payment gateway

**4.3 - Payment Verification**
- **Inputs**: Payment callback from Razorpay
- **Outputs**: Success/Failure status
- **Process**:
  - Verify payment signature
  - Validate payment amount
  - Check payment status

**4.4 - Create Subscription**
- **Inputs**: Verified payment, User ID, Plan type
- **Outputs**: Subscription record
- **Process**:
  - Calculate start_date and end_date
  - Create subscription record
  - Update user.subscribed = true
  - Grant premium access
- **Data Stores**: D6 (SUBSCRIPTIONS), D1 (USERS)

**4.5 - Payment Failure Handler**
- **Inputs**: Failed payment response
- **Outputs**: Error message
- **Process**:
  - Log payment failure
  - Display error to user
  - Provide retry option

---

## 🚀 Getting Started

### Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher
- IDE (IntelliJ IDEA, Eclipse, or VS Code)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/e-library.git
   cd e-library
   ```

2. **Create MySQL database**
   ```sql
   CREATE DATABASE e_library;
   ```

3. **Configure application properties**
   
   Edit `e-library/src/main/resources/application.properties`:
   ```properties
   # Database Configuration
   spring.datasource.url=jdbc:mysql://localhost:3306/e_library?allowPublicKeyRetrieval=true&useSSL=false
   spring.datasource.username=your_mysql_username
   spring.datasource.password=your_mysql_password
   
   # Razorpay Configuration
   razorpay.key.id=your_razorpay_key_id
   razorpay.key.secret=your_razorpay_key_secret
   ```

4. **Build the project**
   ```bash
   cd e-library
   mvn clean install
   ```

5. **Run the application**
   ```bash
   mvn spring-boot:run
   ```

6. **Access the application**
   
   Open your browser and navigate to: `http://localhost:8081`

### Default Admin Account

After first run, create an admin account by registering and manually updating the database:

```sql
UPDATE users SET role = 'admin' WHERE email = 'youremail@example.com';
```

---

## 📝 Configuration

### Application Properties

Key configuration parameters in `application.properties`:

```properties
# Server Configuration
server.port=8081

# Database
spring.datasource.url=jdbc:mysql://localhost:3306/e_library
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# View Configuration
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

# File Upload (Optional)
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

---

## 🧪 Testing

Run tests with Maven:

```bash
mvn test
```

---

## 📦 Deployment

### Build WAR file

```bash
mvn clean package
```

The WAR file will be generated in `target/e-library-1.0.0.war`

### Deploy to Tomcat

1. Copy the WAR file to Tomcat's `webapps` directory
2. Start Tomcat server
3. Access application at `http://localhost:8080/e-library-1.0.0/`

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Authors

- **SUBHRADIP HANSDA** - *Initial work* - [GitHub Profile](https://github.com/yourusername)

---

## 🙏 Acknowledgments

- Spring Boot Documentation
- Tailwind CSS
- Razorpay Payment Gateway
- MySQL Database
- Open Source Community

---

## 📧 Contact

For questions or support, please contact:
- **Email**: your.email@example.com
- **GitHub**: [SUBHRADiP HANSDA](https://github.com/subhradip-me)

---

## 🗺️ Roadmap

- [ ] Implement user authentication with JWT
- [ ] Add email notifications
- [ ] Implement PDF reader in-browser
- [ ] Add book recommendations using ML
- [ ] Mobile app development
- [ ] Multi-language support
- [ ] Social sharing features
- [ ] Advanced analytics dashboard

---

**⭐ If you find this project useful, please consider giving it a star on GitHub!**