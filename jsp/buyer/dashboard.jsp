<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-bag"></i>My Bag</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>
<main class="col-md-10 p-4" style="background:#fff;">

<!-- Welcome Banner -->
<div style="background:var(--black); padding:30px 35px; margin-bottom:24px; position:relative; overflow:hidden;">
<div style="position:absolute; top:0; right:0; width:40%; height:100%; background:linear-gradient(135deg, rgba(133,72,54,0.3), rgba(255,178,44,0.15));"></div>
<div style="position:relative; z-index:1;">
<p style="color:var(--gold); font-size:0.7rem; letter-spacing:3px; text-transform:uppercase; font-weight:600; margin-bottom:4px;">WELCOME BACK</p>
<h2 style="color:#fff; font-size:1.8rem; margin-bottom:4px;"><%= currentUser.getName() %></h2>
<p style="color:#888; font-size:0.85rem; margin:0;">Your personal shopping dashboard</p>
</div>
</div>

<!-- Stats Cards -->
<div class="row mb-4 g-3">
<div class="col-md-3"><div class="stat-card gold"><div class="stat-label">My Orders</div><div class="stat-value"><%= request.getAttribute("totalOrders") %></div></div></div>
<div class="col-md-3"><div class="stat-card dark"><div class="stat-label" style="color:#aaa;">Cart Items</div><div class="stat-value" style="color:var(--gold);"><%= request.getAttribute("cartCount") %></div></div></div>
<div class="col-md-3"><div class="stat-card brown"><div class="stat-label">Wishlist</div><div class="stat-value"><%= request.getAttribute("wishlistCount") %></div></div></div>
<div class="col-md-3"><div class="stat-card cream-card"><div class="stat-label" style="color:#888;">Account Status</div><div class="stat-value" style="font-size:1.4rem; color:#10b981;"><i class="bi bi-patch-check-fill"></i> Active</div></div></div>
</div>

<!-- Main Content Row -->
<div class="row g-4 mb-4">

<!-- Recent Orders -->
<div class="col-md-8">
<div class="card"><div class="card-header d-flex justify-content-between align-items-center">
<h5 class="mb-0" style="font-size:1.1rem;">Recent Orders</h5>
<a href="${pageContext.request.contextPath}/buyer/orders" style="color:var(--brown);font-size:0.75rem;text-decoration:none;font-weight:600;letter-spacing:1.5px;">VIEW ALL &rarr;</a>
</div>
<div class="card-body p-0">
<table class="table mb-0"><thead><tr><th>Order</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead><tbody>
<% List<Order> ro=(List<Order>)request.getAttribute("recentOrders"); if(ro!=null&&!ro.isEmpty()){for(Order o:ro){ %>
<tr><td><a href="${pageContext.request.contextPath}/buyer/orders/view?id=<%= o.getId() %>" style="color:var(--brown);font-weight:600;text-decoration:none;">#<%= o.getId() %></a></td>
<td style="font-family:'Playfair Display',serif;font-weight:600;">&#8377;<%= String.format("%.2f",o.getTotalAmount()) %></td>
<td><span class="badge bg-<%= o.getStatus()==Order.Status.DELIVERED?"success":o.getStatus()==Order.Status.CANCELLED?"danger":"warning" %>"><%= o.getStatus() %></span></td>
<td style="font-size:0.8rem;color:#aaa;"><%= o.getCreatedAt() %></td></tr>
<% }}else{ %><tr><td colspan="4" class="text-center py-4" style="color:#aaa;">No orders yet. <a href="${pageContext.request.contextPath}/buyer/products" style="color:var(--brown);font-weight:600;text-decoration:none;">Start shopping!</a></td></tr><% } %>
</tbody></table></div></div></div>

<!-- Quick Actions -->
<div class="col-md-4">
<div class="card" style="background:var(--black);color:#fff;">
<div class="card-body" style="padding:28px;">
<h5 style="font-size:1rem;color:var(--gold);margin-bottom:20px;">Quick Actions</h5>
<a href="${pageContext.request.contextPath}/buyer/products" class="d-block mb-3" style="background:var(--gold);color:var(--black);padding:14px 20px;text-decoration:none;font-weight:600;font-size:0.8rem;letter-spacing:1.5px;text-align:center;transition:all 0.3s;">
<i class="bi bi-shop-window me-2"></i>BROWSE PRODUCTS</a>
<a href="${pageContext.request.contextPath}/buyer/cart" class="d-block mb-3" style="border:1px solid rgba(255,255,255,0.2);color:#fff;padding:14px 20px;text-decoration:none;font-weight:500;font-size:0.8rem;letter-spacing:1.5px;text-align:center;transition:all 0.3s;">
<i class="bi bi-bag me-2"></i>VIEW MY BAG</a>
<a href="${pageContext.request.contextPath}/buyer/wishlist" class="d-block mb-3" style="border:1px solid rgba(255,255,255,0.2);color:#fff;padding:14px 20px;text-decoration:none;font-weight:500;font-size:0.8rem;letter-spacing:1.5px;text-align:center;transition:all 0.3s;">
<i class="bi bi-heart me-2"></i>MY WISHLIST</a>
<a href="${pageContext.request.contextPath}/buyer/orders" class="d-block" style="border:1px solid rgba(255,255,255,0.2);color:#fff;padding:14px 20px;text-decoration:none;font-weight:500;font-size:0.8rem;letter-spacing:1.5px;text-align:center;transition:all 0.3s;">
<i class="bi bi-receipt me-2"></i>ORDER HISTORY</a>
</div></div></div>
</div>

<!-- About ShopEase Section -->
<div class="card mb-4">
<div class="card-body" style="padding:35px;">
<div class="row align-items-center">
<div class="col-md-7">
<p style="color:var(--gold); font-size:0.7rem; letter-spacing:3px; text-transform:uppercase; font-weight:600; margin-bottom:8px;">ABOUT US</p>
<h3 style="font-size:1.8rem; margin-bottom:16px;">Welcome to ShopEase</h3>
<p style="color:#666; line-height:1.9; font-size:0.9rem;">
ShopEase is your premium online shopping destination. We connect buyers with trusted sellers to deliver a seamless e-commerce experience. From electronics to fashion, accessories to footwear — discover quality products at competitive prices with secure payments and fast delivery.
</p>
<p style="color:#666; line-height:1.9; font-size:0.9rem;">
Our platform is built with modern Java technology featuring three dedicated dashboards for Admins, Sellers, and Buyers — ensuring every user has the tools they need for a perfect experience.
</p>
</div>
<div class="col-md-5">
<div style="background:var(--black); padding:30px; text-align:center;">
<div style="font-family:'Playfair Display',serif; font-size:2.5rem; color:#fff; letter-spacing:5px; font-weight:700; margin-bottom:12px;">SHOPEASE</div>
<div style="width:60px; height:3px; background:var(--gold); margin:0 auto 16px;"></div>
<p style="color:#888; font-size:0.85rem; margin-bottom:20px;">Premium Shopping Experience</p>
<div class="row g-3" style="text-align:center;">
<div class="col-6"><div style="color:var(--gold); font-family:'Playfair Display',serif; font-size:1.5rem; font-weight:700;">8+</div><div style="color:#888; font-size:0.7rem; letter-spacing:1px;">PRODUCTS</div></div>
<div class="col-6"><div style="color:var(--gold); font-family:'Playfair Display',serif; font-size:1.5rem; font-weight:700;">3</div><div style="color:#888; font-size:0.7rem; letter-spacing:1px;">USER ROLES</div></div>
<div class="col-6"><div style="color:var(--gold); font-family:'Playfair Display',serif; font-size:1.5rem; font-weight:700;">24/7</div><div style="color:#888; font-size:0.7rem; letter-spacing:1px;">SUPPORT</div></div>
<div class="col-6"><div style="color:var(--gold); font-family:'Playfair Display',serif; font-size:1.5rem; font-weight:700;">100%</div><div style="color:#888; font-size:0.7rem; letter-spacing:1px;">SECURE</div></div>
</div>
</div>
</div>
</div>
</div></div>

<!-- Features Row -->
<div class="row g-3 mb-4">
<div class="col-md-3">
<div class="card text-center" style="padding:24px;">
<i class="bi bi-truck" style="font-size:2rem; color:var(--gold); margin-bottom:12px; display:block;"></i>
<h6 style="font-size:0.85rem; margin-bottom:4px;">Free Delivery</h6>
<p style="font-size:0.75rem; color:#aaa; margin:0;">On orders above &#8377;2,000</p>
</div></div>
<div class="col-md-3">
<div class="card text-center" style="padding:24px;">
<i class="bi bi-shield-check" style="font-size:2rem; color:var(--gold); margin-bottom:12px; display:block;"></i>
<h6 style="font-size:0.85rem; margin-bottom:4px;">Secure Payments</h6>
<p style="font-size:0.75rem; color:#aaa; margin:0;">100% protected checkout</p>
</div></div>
<div class="col-md-3">
<div class="card text-center" style="padding:24px;">
<i class="bi bi-arrow-repeat" style="font-size:2rem; color:var(--gold); margin-bottom:12px; display:block;"></i>
<h6 style="font-size:0.85rem; margin-bottom:4px;">Easy Returns</h6>
<p style="font-size:0.75rem; color:#aaa; margin:0;">30-day return policy</p>
</div></div>
<div class="col-md-3">
<div class="card text-center" style="padding:24px;">
<i class="bi bi-headset" style="font-size:2rem; color:var(--gold); margin-bottom:12px; display:block;"></i>
<h6 style="font-size:0.85rem; margin-bottom:4px;">24/7 Support</h6>
<p style="font-size:0.75rem; color:#aaa; margin:0;">Dedicated customer service</p>
</div></div>
</div>

<!-- Account Info -->
<div class="card">
<div class="card-header"><h5 class="mb-0" style="font-size:1.1rem;">My Account</h5></div>
<div class="card-body">
<div class="row">
<div class="col-md-6">
<table style="width:100%; font-size:0.9rem;">
<tr><td style="padding:8px 0; color:#888; width:120px;">Name</td><td style="padding:8px 0; font-weight:600;"><%= currentUser.getName() %></td></tr>
<tr><td style="padding:8px 0; color:#888;">Email</td><td style="padding:8px 0; font-weight:600;"><%= currentUser.getEmail() %></td></tr>
<tr><td style="padding:8px 0; color:#888;">Role</td><td style="padding:8px 0;"><span class="badge bg-warning"><%= currentUser.getRole() %></span></td></tr>
<tr><td style="padding:8px 0; color:#888;">Phone</td><td style="padding:8px 0;"><%= currentUser.getPhone() != null ? currentUser.getPhone() : "Not set" %></td></tr>
<tr><td style="padding:8px 0; color:#888;">Address</td><td style="padding:8px 0;"><%= currentUser.getAddress() != null ? currentUser.getAddress() : "Not set" %></td></tr>
<tr><td style="padding:8px 0; color:#888;">Member Since</td><td style="padding:8px 0;"><%= currentUser.getCreatedAt() %></td></tr>
</table>
</div>
<div class="col-md-6">
<div style="background:var(--cream); padding:24px; height:100%;">
<h6 style="font-size:0.85rem; margin-bottom:16px; color:var(--brown);"><i class="bi bi-info-circle me-1"></i> Shopping Tips</h6>
<ul style="font-size:0.82rem; color:#666; line-height:2; padding-left:16px; margin:0;">
<li>Add items to your wishlist to track price changes</li>
<li>Free delivery on orders above &#8377;2,000</li>
<li>Use code <strong>SHOP2024</strong> for extra 10% off</li>
<li>Check flash sales for the best deals</li>
<li>Track your orders in real-time from Orders page</li>
</ul>
</div>
</div>
</div>
</div></div>

</main></div></div>
<%@ include file="../common/footer.jsp" %>
