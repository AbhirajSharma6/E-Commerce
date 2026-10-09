<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEase - Premium Shopping Experience</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --cream: #F7F7F7;
            --gold: #FFB22C;
            --brown: #854836;
            --black: #000000;
            --dark: #1a1a1a;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; color: var(--black); background: var(--cream); }
        h1, h2, h3, h4 { font-family: 'Playfair Display', serif; }

        /* Navbar */
        .top-bar { background: var(--black); color: #fff; font-size: 0.75rem; padding: 8px 0; text-align: center; letter-spacing: 2px; }
        .main-nav { background: #fff; border-bottom: 1px solid #eee; padding: 16px 0; position: sticky; top: 0; z-index: 100; }
        .nav-brand { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 700; color: var(--black); text-decoration: none; letter-spacing: 3px; }
        .nav-links a { color: var(--black); text-decoration: none; font-size: 0.85rem; font-weight: 500; letter-spacing: 1px; text-transform: uppercase; transition: color 0.3s; }
        .nav-links a:hover { color: var(--gold); }
        .nav-btn { padding: 10px 28px; border-radius: 0; font-size: 0.8rem; font-weight: 600; letter-spacing: 1px; text-transform: uppercase; transition: all 0.3s; }
        .btn-gold { background: var(--gold); color: var(--black); border: none; }
        .btn-gold:hover { background: #e6a028; color: var(--black); transform: translateY(-1px); }
        .btn-dark { background: var(--black); color: #fff; border: none; }
        .btn-dark:hover { background: #333; color: #fff; }
        .btn-outline-dark2 { background: transparent; color: var(--black); border: 2px solid var(--black); }
        .btn-outline-dark2:hover { background: var(--black); color: #fff; }

        /* Hero */
        .hero { background: var(--black); min-height: 85vh; display: flex; align-items: center; position: relative; overflow: hidden; }
        .hero::before {
            content: ''; position: absolute; top: 0; right: 0; width: 55%; height: 100%;
            background: linear-gradient(135deg, rgba(133,72,54,0.3), rgba(255,178,44,0.15));
        }
        .hero-content { position: relative; z-index: 2; }
        .hero-label { color: var(--gold); font-size: 0.8rem; letter-spacing: 4px; text-transform: uppercase; font-weight: 500; }
        .hero-title { color: #fff; font-size: 4.5rem; font-weight: 700; line-height: 1.1; margin: 20px 0; }
        .hero-title span { color: var(--gold); }
        .hero-desc { color: #aaa; font-size: 1.1rem; line-height: 1.8; max-width: 500px; }

        /* Timer */
        .timer-section { background: var(--brown); padding: 20px 0; }
        .timer-section h5 { color: var(--cream); font-size: 0.85rem; letter-spacing: 3px; text-transform: uppercase; }
        .timer-box { display: inline-flex; gap: 20px; }
        .timer-unit { text-align: center; }
        .timer-num { font-family: 'Playfair Display', serif; font-size: 2.5rem; font-weight: 700; color: var(--gold); line-height: 1; }
        .timer-label { font-size: 0.7rem; color: rgba(255,255,255,0.6); letter-spacing: 2px; text-transform: uppercase; margin-top: 4px; }

        /* Categories */
        .categories { padding: 80px 0; }
        .cat-card { position: relative; height: 350px; overflow: hidden; cursor: pointer; }
        .cat-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s; }
        .cat-card:hover img { transform: scale(1.08); }
        .cat-overlay {
            position: absolute; bottom: 0; left: 0; right: 0; padding: 30px;
            background: linear-gradient(transparent, rgba(0,0,0,0.7));
        }
        .cat-overlay h3 { color: #fff; font-size: 1.5rem; margin-bottom: 5px; }
        .cat-overlay p { color: rgba(255,255,255,0.7); font-size: 0.85rem; }

        /* Features */
        .features { padding: 60px 0; background: #fff; }
        .feature-box { text-align: center; padding: 30px; }
        .feature-box i { font-size: 2rem; color: var(--gold); margin-bottom: 16px; }
        .feature-box h5 { font-family: 'Playfair Display', serif; font-size: 1.1rem; margin-bottom: 8px; }
        .feature-box p { font-size: 0.85rem; color: #777; }

        /* Products */
        .products-section { padding: 80px 0; background: var(--cream); }
        .section-label { color: var(--gold); font-size: 0.75rem; letter-spacing: 4px; text-transform: uppercase; font-weight: 600; text-align: center; }
        .section-title { font-size: 2.5rem; text-align: center; margin: 10px 0 50px; }

        .prod-card { background: #fff; transition: all 0.4s; border: 1px solid #f0f0f0; }
        .prod-card:hover { box-shadow: 0 20px 50px rgba(0,0,0,0.1); transform: translateY(-5px); }
        .prod-img { height: 260px; background: var(--cream); display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; }
        .prod-img img { max-height: 200px; transition: transform 0.4s; }
        .prod-card:hover .prod-img img { transform: scale(1.05); }
        .prod-badge { position: absolute; top: 12px; left: 12px; background: var(--gold); color: var(--black); font-size: 0.7rem; padding: 4px 12px; font-weight: 600; letter-spacing: 1px; }
        .prod-info { padding: 20px; }
        .prod-cat { font-size: 0.7rem; color: #999; letter-spacing: 2px; text-transform: uppercase; }
        .prod-name { font-family: 'Playfair Display', serif; font-size: 1rem; margin: 6px 0; }
        .prod-price { font-size: 1.2rem; font-weight: 700; color: var(--brown); }
        .prod-old-price { font-size: 0.85rem; color: #bbb; text-decoration: line-through; margin-left: 8px; }

        /* Roles */
        .roles-section { padding: 80px 0; background: var(--black); }
        .role-box { padding: 40px; border: 1px solid rgba(255,255,255,0.1); transition: all 0.4s; }
        .role-box:hover { border-color: var(--gold); background: rgba(255,178,44,0.05); }
        .role-icon { width: 60px; height: 60px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 20px; }
        .role-box h4 { color: #fff; font-size: 1.3rem; }
        .role-box p { color: #888; font-size: 0.9rem; line-height: 1.7; }

        /* Newsletter */
        .newsletter { padding: 80px 0; background: var(--brown); text-align: center; }
        .newsletter h2 { color: #fff; font-size: 2.2rem; margin-bottom: 12px; }
        .newsletter p { color: rgba(255,255,255,0.7); margin-bottom: 30px; }
        .newsletter input { border: none; padding: 16px 24px; width: 350px; font-family: 'Poppins'; font-size: 0.9rem; }
        .newsletter button { background: var(--gold); border: none; padding: 16px 32px; font-weight: 600; letter-spacing: 1px; font-family: 'Poppins'; cursor: pointer; }

        /* Footer */
        .site-footer { background: var(--black); padding: 60px 0 30px; color: #888; }
        .footer-brand { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #fff; letter-spacing: 3px; }
        .footer-links a { color: #888; text-decoration: none; font-size: 0.85rem; display: block; margin-bottom: 8px; transition: color 0.3s; }
        .footer-links a:hover { color: var(--gold); }
        .footer-title { color: #fff; font-size: 0.8rem; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 20px; }

        /* Animations */
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(40px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .animate-up { animation: fadeInUp 0.8s ease forwards; }
        .animate-fade { animation: fadeIn 1s ease forwards; }
        .delay-1 { animation-delay: 0.2s; }
        .delay-2 { animation-delay: 0.4s; }
        .delay-3 { animation-delay: 0.6s; }
    </style>
</head>
<body>

<!-- Top Bar -->
<div class="top-bar">
    Free shipping on orders above &#8377;2,000 &mdash; Use code <strong>SHOP2024</strong>
</div>

<!-- Navigation -->
<nav class="main-nav">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="nav-links d-flex gap-4 align-items-center">
            <a href="#">New Arrivals</a>
            <a href="#">Categories</a>
            <a href="#">Deals</a>
        </div>
        <a href="${pageContext.request.contextPath}/" class="nav-brand">SHOPEASE</a>
        <div class="d-flex gap-3 align-items-center">
            <a href="${pageContext.request.contextPath}/login" class="nav-links"><a href="${pageContext.request.contextPath}/login" style="color:#000; text-decoration:none; font-size:0.85rem;"><i class="bi bi-person" style="font-size:1.2rem;"></i></a></a>
            <a href="${pageContext.request.contextPath}/login" style="color:#000; text-decoration:none;"><i class="bi bi-heart" style="font-size:1.1rem;"></i></a>
            <a href="${pageContext.request.contextPath}/login" style="color:#000; text-decoration:none;"><i class="bi bi-bag" style="font-size:1.1rem;"></i></a>
            <a href="${pageContext.request.contextPath}/login" class="btn nav-btn btn-gold ms-2">Sign In</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-content">
                <p class="hero-label animate-up">Autumn Collection 2024</p>
                <h1 class="hero-title animate-up delay-1">Discover <span>Premium</span> Style</h1>
                <p class="hero-desc animate-up delay-2">Curated collections from the finest sellers. Quality products, seamless shopping, delivered to your doorstep.</p>
                <div class="d-flex gap-3 mt-4 animate-up delay-3">
                    <a href="${pageContext.request.contextPath}/register" class="btn nav-btn btn-gold">Start Shopping</a>
                    <a href="${pageContext.request.contextPath}/login" class="btn nav-btn btn-outline-dark2" style="border-color:rgba(255,255,255,0.3); color:#fff;">Sign In</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Flash Sale Timer -->
<section class="timer-section text-center">
    <div class="container">
        <h5 class="mb-3">&#9889; Flash Sale Ends In</h5>
        <div class="timer-box" id="saleTimer">
            <div class="timer-unit"><div class="timer-num" id="hours">08</div><div class="timer-label">Hours</div></div>
            <div style="color:var(--gold); font-size:2rem; line-height:1;">:</div>
            <div class="timer-unit"><div class="timer-num" id="minutes">45</div><div class="timer-label">Minutes</div></div>
            <div style="color:var(--gold); font-size:2rem; line-height:1;">:</div>
            <div class="timer-unit"><div class="timer-num" id="seconds">30</div><div class="timer-label">Seconds</div></div>
        </div>
    </div>
</section>

<!-- Features -->
<section class="features">
    <div class="container">
        <div class="row">
            <div class="col-md-3"><div class="feature-box"><i class="bi bi-truck d-block"></i><h5>Free Delivery</h5><p>On orders above &#8377;2,000</p></div></div>
            <div class="col-md-3"><div class="feature-box"><i class="bi bi-shield-check d-block"></i><h5>Secure Payments</h5><p>100% protected checkout</p></div></div>
            <div class="col-md-3"><div class="feature-box"><i class="bi bi-arrow-repeat d-block"></i><h5>Easy Returns</h5><p>30-day return policy</p></div></div>
            <div class="col-md-3"><div class="feature-box"><i class="bi bi-headset d-block"></i><h5>24/7 Support</h5><p>Dedicated customer service</p></div></div>
        </div>
    </div>
</section>

<!-- Categories -->
<section class="categories">
    <div class="container">
        <p class="section-label">Browse</p>
        <h2 class="section-title">Shop by Category</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="cat-card">
                    <div style="width:100%;height:100%;background:linear-gradient(135deg,#2d2d2d,#1a1a1a);display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-headphones" style="font-size:6rem;color:var(--gold);opacity:0.6;"></i>
                    </div>
                    <div class="cat-overlay"><h3>Electronics</h3><p>Headphones, Smart Watches & More</p></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="cat-card">
                    <div style="width:100%;height:100%;background:linear-gradient(135deg,var(--brown),#6b3727);display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-bag" style="font-size:6rem;color:var(--gold);opacity:0.6;"></i>
                    </div>
                    <div class="cat-overlay"><h3>Fashion</h3><p>Clothing, Footwear & Accessories</p></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="cat-card">
                    <div style="width:100%;height:100%;background:linear-gradient(135deg,#333,#1a1a1a);display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-watch" style="font-size:6rem;color:var(--gold);opacity:0.6;"></i>
                    </div>
                    <div class="cat-overlay"><h3>Accessories</h3><p>Wallets, Sunglasses & Bags</p></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Roles Section -->
<section class="roles-section">
    <div class="container text-center">
        <p class="section-label">Platform</p>
        <h2 style="color:#fff; font-size:2.5rem; margin:10px 0 50px;">Three Powerful Dashboards</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="role-box">
                    <div class="role-icon" style="background:rgba(255,178,44,0.1); color:var(--gold);"><i class="bi bi-shield-lock-fill"></i></div>
                    <h4>Admin</h4>
                    <p>Complete platform control. Manage all users, oversee product listings, process orders, and monitor system analytics.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="role-box">
                    <div class="role-icon" style="background:rgba(255,178,44,0.1); color:var(--gold);"><i class="bi bi-shop"></i></div>
                    <h4>Seller</h4>
                    <p>Your business hub. Create listings, manage inventory with stock alerts, fulfill orders, and track sales revenue.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="role-box">
                    <div class="role-icon" style="background:rgba(255,178,44,0.1); color:var(--gold);"><i class="bi bi-bag-heart"></i></div>
                    <h4>Buyer</h4>
                    <p>Premium shopping. Browse curated products, manage wishlists, enjoy seamless checkout, and track deliveries.</p>
                </div>
            </div>
        </div>
        <div class="mt-5">
            <a href="${pageContext.request.contextPath}/register" class="btn nav-btn btn-gold me-3">Create Account</a>
            <a href="${pageContext.request.contextPath}/login" class="btn nav-btn" style="border:1px solid rgba(255,255,255,0.3); color:#fff;">Sign In</a>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section class="newsletter">
    <div class="container">
        <h2>Stay in the Loop</h2>
        <p>Subscribe for exclusive deals, new arrivals, and insider updates.</p>
        <div class="d-inline-flex">
            <input type="email" placeholder="Your email address">
            <button>Subscribe</button>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="site-footer">
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="footer-brand mb-3">SHOPEASE</div>
                <p style="font-size:0.85rem; line-height:1.8;">Premium e-commerce platform built with Java Servlets, JSP, JDBC and MySQL. Featuring three dedicated dashboards for Admin, Seller, and Buyer.</p>
            </div>
            <div class="col-md-2 offset-md-2">
                <div class="footer-title">Shop</div>
                <div class="footer-links">
                    <a href="#">New Arrivals</a>
                    <a href="#">Electronics</a>
                    <a href="#">Fashion</a>
                    <a href="#">Accessories</a>
                </div>
            </div>
            <div class="col-md-2">
                <div class="footer-title">Account</div>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                    <a href="#">Orders</a>
                    <a href="#">Wishlist</a>
                </div>
            </div>
            <div class="col-md-2">
                <div class="footer-title">Support</div>
                <div class="footer-links">
                    <a href="#">Contact Us</a>
                    <a href="#">FAQs</a>
                    <a href="#">Shipping</a>
                    <a href="#">Returns</a>
                </div>
            </div>
        </div>
        <hr style="border-color:rgba(255,255,255,0.1);">
        <div class="d-flex justify-content-between align-items-center">
            <p style="font-size:0.8rem; margin:0;">&copy; 2024 ShopEase. All rights reserved.</p>
            <div class="d-flex gap-3">
                <a href="#" style="color:#888; font-size:1.2rem;"><i class="bi bi-instagram"></i></a>
                <a href="#" style="color:#888; font-size:1.2rem;"><i class="bi bi-twitter-x"></i></a>
                <a href="#" style="color:#888; font-size:1.2rem;"><i class="bi bi-facebook"></i></a>
                <a href="#" style="color:#888; font-size:1.2rem;"><i class="bi bi-youtube"></i></a>
            </div>
        </div>
    </div>
</footer>

<script>
// Countdown Timer
function startTimer() {
    let h = 8, m = 45, s = 30;
    setInterval(() => {
        s--;
        if (s < 0) { s = 59; m--; }
        if (m < 0) { m = 59; h--; }
        if (h < 0) { h = 23; m = 59; s = 59; }
        document.getElementById('hours').textContent = String(h).padStart(2, '0');
        document.getElementById('minutes').textContent = String(m).padStart(2, '0');
        document.getElementById('seconds').textContent = String(s).padStart(2, '0');
    }, 1000);
}
startTimer();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
