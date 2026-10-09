<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String role = (currentUser != null) ? currentUser.getRole().name() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --cream: #F7F7F7; --gold: #FFB22C; --brown: #854836; --black: #000; }
        * { font-family: 'Poppins', sans-serif; }
        h1,h2,h3,h4,h5 { font-family: 'Playfair Display', serif; }
        body { background: var(--cream); min-height: 100vh; }

        .main-nav { background: var(--black); padding: 10px 0; }
        .nav-brand { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .nav-logo { width: 36px; height: 36px; background: var(--gold); border-radius: 8px; display: flex; align-items: center; justify-content: center; }
        .nav-logo i { color: var(--black); font-size: 1.1rem; }
        .nav-brand-text { font-family: 'Playfair Display',serif; font-size: 1.4rem; font-weight: 700; color: #fff; letter-spacing: 3px; }
        .user-badge { background: rgba(255,178,44,0.2); color: var(--gold); font-size: 0.65rem; padding: 3px 10px; border-radius: 4px; letter-spacing: 1px; text-transform: uppercase; }

        .sidebar { min-height: calc(100vh - 52px); background: var(--black); padding-top: 24px; }
        .sidebar .nav-link { color: #888; padding: 12px 24px; margin: 2px 12px; border-radius: 4px; font-size: 0.85rem; font-weight: 500; transition: all 0.3s; letter-spacing: 0.5px; }
        .sidebar .nav-link:hover { color: #fff; background: rgba(255,178,44,0.1); }
        .sidebar .nav-link.active { color: var(--black); background: var(--gold); font-weight: 600; }
        .sidebar .nav-link i { margin-right: 10px; font-size: 1rem; }

        .card { border: none; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.06); }
        .card-header { background: #fff; border-bottom: 1px solid #f0f0f0; padding: 16px 24px; }
        .card-body { padding: 24px; }

        .stat-card { padding: 28px; position: relative; overflow: hidden; border-radius: 4px; }
        .stat-card::before { content: ''; position: absolute; top: -30px; right: -30px; width: 100px; height: 100px; border-radius: 50%; opacity: 0.1; background: #fff; }
        .stat-card.gold { background: linear-gradient(135deg, var(--gold), #e6a028); color: var(--black); }
        .stat-card.dark { background: var(--black); color: #fff; }
        .stat-card.brown { background: linear-gradient(135deg, var(--brown), #6b3727); color: #fff; }
        .stat-card.cream-card { background: #fff; color: var(--black); border: 1px solid #eee; }
        .stat-label { font-size: 0.75rem; opacity: 0.8; font-weight: 600; letter-spacing: 1.5px; text-transform: uppercase; }
        .stat-value { font-family: 'Playfair Display',serif; font-size: 2.2rem; font-weight: 700; }

        .table thead th { background: var(--cream); border-bottom: 2px solid #e0e0e0; font-weight: 600; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 1.5px; color: #888; padding: 12px 16px; }
        .table tbody td { padding: 14px 16px; vertical-align: middle; font-size: 0.9rem; }
        .table tbody tr:hover { background: #fafafa; }

        .badge { padding: 5px 12px; border-radius: 4px; font-weight: 500; font-size: 0.72rem; letter-spacing: 0.5px; }
        .badge.bg-warning { background: var(--gold) !important; color: var(--black) !important; }
        .badge.bg-success { background: #10b981 !important; }
        .badge.bg-danger { background: #ef4444 !important; }
        .badge.bg-info { background: var(--brown) !important; }

        .btn { border-radius: 4px; font-weight: 500; letter-spacing: 0.5px; font-size: 0.85rem; }
        .btn-primary { background: var(--gold); border-color: var(--gold); color: var(--black); }
        .btn-primary:hover { background: #e6a028; border-color: #e6a028; color: var(--black); }
        .btn-dark { background: var(--black); border-color: var(--black); }

        .form-control, .form-select { border-radius: 4px; border: 1.5px solid #ddd; padding: 10px 14px; font-size: 0.9rem; }
        .form-control:focus, .form-select:focus { border-color: var(--gold); box-shadow: 0 0 0 3px rgba(255,178,44,0.15); }

        .page-title { font-size: 1.6rem; color: var(--black); }
        .alert { border-radius: 4px; border: none; }
        .alert-success { background: #ecfdf5; color: #065f46; }
        .alert-danger { background: #fef2f2; color: #991b1b; }

        .product-card { border: 1px solid #eee; transition: all 0.4s; border-radius: 4px; overflow: hidden; }
        .product-card:hover { box-shadow: 0 15px 40px rgba(0,0,0,0.1); transform: translateY(-4px); }
        .product-img { height: 200px; background: var(--cream); display: flex; align-items: center; justify-content: center; }
        .product-price { font-family: 'Playfair Display',serif; font-size: 1.3rem; font-weight: 700; color: var(--brown); }

        /* Cookie Popup */
        .cookie-popup {
            position: fixed; bottom: 0; left: 0; right: 0; z-index: 9999;
            background: var(--black); color: #fff; padding: 20px 30px;
            display: none; align-items: center; justify-content: space-between;
            box-shadow: 0 -4px 20px rgba(0,0,0,0.3);
            animation: slideUp 0.5s ease;
        }
        .cookie-popup.show { display: flex; }
        @keyframes slideUp { from { transform: translateY(100%); } to { transform: translateY(0); } }
        .cookie-popup p { margin: 0; font-size: 0.85rem; color: #ccc; max-width: 700px; }
        .cookie-popup a { color: var(--gold); }
        .cookie-btns { display: flex; gap: 10px; flex-shrink: 0; }
        .cookie-accept { background: var(--gold); color: var(--black); border: none; padding: 10px 24px; font-weight: 600; font-size: 0.8rem; letter-spacing: 1px; cursor: pointer; font-family: 'Poppins'; }
        .cookie-deny { background: transparent; color: #888; border: 1px solid #444; padding: 10px 24px; font-weight: 500; font-size: 0.8rem; letter-spacing: 1px; cursor: pointer; font-family: 'Poppins'; }
        .cookie-accept:hover { background: #e6a028; }
        .cookie-deny:hover { border-color: #888; color: #fff; }
    </style>
</head>
<body>

<nav class="main-nav">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
        <a class="nav-brand" href="${pageContext.request.contextPath}/">
            <div class="nav-logo"><i class="bi bi-bag-heart-fill"></i></div>
            <span class="nav-brand-text">SHOPEASE</span>
        </a>
        <div class="d-flex align-items-center gap-3">
            <% if (currentUser != null) { %>
                <span style="color:#aaa; font-size:0.85rem;">
                    <i class="bi bi-person-circle me-1"></i> <%= currentUser.getName() %>
                    <span class="user-badge ms-1"><%= currentUser.getRole() %></span>
                </span>
                <a href="${pageContext.request.contextPath}/logout" style="color:var(--gold); text-decoration:none; font-size:0.85rem; font-weight:500;">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" style="color:#fff; text-decoration:none; font-size:0.85rem;">Sign In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-sm px-3" style="background:var(--gold); color:#000; border:none;">Register</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Cookie Consent Popup -->
<div class="cookie-popup" id="cookiePopup">
    <div>
        <p><i class="bi bi-shield-lock me-2" style="color:var(--gold);"></i>
        We use cookies to enhance your shopping experience, analyze site traffic, and personalize content.
        By clicking "Accept All", you consent to our use of cookies. <a href="#">Learn more</a></p>
    </div>
    <div class="cookie-btns">
        <button class="cookie-deny" onclick="handleCookies(false)">Deny</button>
        <button class="cookie-accept" onclick="handleCookies(true)">ACCEPT ALL</button>
    </div>
</div>

<script>
// Cookie consent logic
function handleCookies(accepted) {
    document.getElementById('cookiePopup').style.display = 'none';
    try { localStorage.setItem('cookieConsent', accepted ? 'accepted' : 'denied'); } catch(e) {}
}
window.addEventListener('DOMContentLoaded', function() {
    try {
        var consent = localStorage.getItem('cookieConsent');
        if (!consent) { document.getElementById('cookiePopup').classList.add('show'); }
    } catch(e) { document.getElementById('cookiePopup').classList.add('show'); }
});
</script>
