<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.model.*, java.util.*" %>
<%@ include file="../common/header.jsp" %>
<%
    Product product = (Product) request.getAttribute("product");
    Boolean inWishlist = (Boolean) request.getAttribute("inWishlist");

    // Map product names to image files
    java.util.Map<String, String> imgMap = new java.util.LinkedHashMap<>();
    imgMap.put("headphone", "headphones.jpg");
    imgMap.put("shoe", "shoes.jpg");
    imgMap.put("backpack", "backpack.jpg");
    imgMap.put("watch", "smartwatch.jpg");
    imgMap.put("shirt", "tshirt.jpg");
    imgMap.put("wallet", "wallet.jpg");
    imgMap.put("speaker", "speaker.jpg");
    imgMap.put("sunglass", "sunglasses.jpg");

    String imgFile = "headphones.jpg";
    if (product != null) {
        String nameLower = product.getName().toLowerCase();
        for (Map.Entry<String, String> entry : imgMap.entrySet()) {
            if (nameLower.contains(entry.getKey())) { imgFile = entry.getValue(); break; }
        }
    }
%>

<style>
    .detail-page { background: #fff; min-height: calc(100vh - 56px); }
    .back-link { color: var(--brown); text-decoration: none; font-size: 0.85rem; font-weight: 500; letter-spacing: 1px; font-family: 'Poppins'; }
    .back-link:hover { color: var(--black); }
    .prod-img-box { background: var(--cream); display: flex; align-items: center; justify-content: center; border: 1px solid #eee; min-height: 450px; overflow: hidden; }
    .prod-img-box img { max-width: 100%; max-height: 450px; object-fit: contain; transition: transform 0.4s; }
    .prod-img-box:hover img { transform: scale(1.05); }
    .prod-detail-cat { font-size: 0.7rem; color: #aaa; letter-spacing: 3px; text-transform: uppercase; font-weight: 600; font-family: 'Poppins'; }
    .prod-detail-name { font-family: 'Playfair Display', serif; font-size: 2.2rem; font-weight: 700; color: var(--black); margin: 8px 0; }
    .prod-detail-price { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--brown); font-weight: 700; margin: 16px 0; }
    .prod-detail-desc { color: #666; font-size: 0.95rem; line-height: 1.8; font-family: 'Poppins'; }
    .prod-detail-meta { font-size: 0.85rem; color: #888; font-family: 'Poppins'; margin: 16px 0; }
    .prod-detail-meta strong { color: var(--black); }
    .btn-add-bag { background: var(--black); color: #fff; border: none; padding: 14px 40px; font-weight: 600; font-size: 0.85rem; letter-spacing: 2px; font-family: 'Poppins'; transition: all 0.3s; }
    .btn-add-bag:hover { background: var(--brown); color: #fff; }
    .btn-wishlist { border: 2px solid var(--black); background: #fff; color: var(--black); padding: 14px 30px; font-weight: 600; font-size: 0.85rem; letter-spacing: 1px; font-family: 'Poppins'; transition: all 0.3s; }
    .btn-wishlist:hover { background: var(--black); color: #fff; }
    .features-row { border-top: 1px solid #eee; margin-top: 30px; padding-top: 24px; }
    .feature-item2 { text-align: center; }
    .feature-item2 i { font-size: 1.5rem; color: var(--gold); margin-bottom: 8px; }
    .feature-item2 p { font-size: 0.75rem; color: #888; margin: 0; font-family: 'Poppins'; }
</style>

<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-bag"></i>My Bag</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>

<main class="col-md-10 p-4 detail-page">
<a href="${pageContext.request.contextPath}/buyer/products" class="back-link mb-4 d-inline-block"><i class="bi bi-arrow-left me-1"></i> BACK TO PRODUCTS</a>

<% if (product != null) { %>
<div class="row mt-3">
<div class="col-md-6">
<div class="prod-img-box p-4">
<img src="${pageContext.request.contextPath}/images/<%= imgFile %>" alt="<%= product.getName() %>">
</div>
</div>
<div class="col-md-6 ps-md-5">
<div class="prod-detail-cat"><%= product.getCategory() != null ? product.getCategory() : "" %></div>
<h1 class="prod-detail-name"><%= product.getName() %></h1>
<div class="prod-detail-price">&#8377;<%= String.format("%.2f", product.getPrice()) %></div>
<p class="prod-detail-desc"><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>

<div class="prod-detail-meta">
Sold by: <strong><%= product.getSellerName() %></strong>
</div>
<div class="prod-detail-meta">
Availability:
<% if (product.getStockQuantity() > 0) { %>
<span class="badge" style="background:#10b981;"><%= product.getStockQuantity() %> in stock</span>
<% } else { %>
<span class="badge bg-danger">Out of Stock</span>
<% } %>
</div>

<% if (product.getStockQuantity() > 0) { %>
<form action="${pageContext.request.contextPath}/buyer/cart/add" method="post" class="d-flex gap-3 mt-4 align-items-center">
<input type="hidden" name="productId" value="<%= product.getId() %>">
<input type="number" name="quantity" value="1" min="1" max="<%= product.getStockQuantity() %>" class="form-control" style="width:70px; border-radius:0; border:2px solid #ddd; text-align:center;">
<button type="submit" class="btn btn-add-bag"><i class="bi bi-bag-plus me-2"></i>ADD TO BAG</button>
</form>
<% } %>

<form action="${pageContext.request.contextPath}/buyer/wishlist/<%= inWishlist ? "remove" : "add" %>" method="post" class="mt-3">
<input type="hidden" name="productId" value="<%= product.getId() %>">
<button type="submit" class="btn btn-wishlist">
<i class="bi bi-heart<%= inWishlist ? "-fill" : "" %> me-2"></i><%= inWishlist ? "REMOVE FROM" : "ADD TO" %> WISHLIST
</button>
</form>

<div class="features-row">
<div class="row">
<div class="col-4 feature-item2"><i class="bi bi-truck d-block"></i><p>Free Delivery</p></div>
<div class="col-4 feature-item2"><i class="bi bi-arrow-repeat d-block"></i><p>30-Day Returns</p></div>
<div class="col-4 feature-item2"><i class="bi bi-shield-check d-block"></i><p>Secure Payment</p></div>
</div>
</div>
</div>
</div>
<% } else { %>
<div style="text-align:center; padding:80px 0;">
<h3 style="font-family:'Playfair Display',serif; color:#888;">Product not found</h3>
<a href="${pageContext.request.contextPath}/buyer/products" class="btn btn-add-bag mt-3">BROWSE PRODUCTS</a>
</div>
<% } %>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
