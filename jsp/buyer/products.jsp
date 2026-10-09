<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>

<%
    Random rand = new Random();
    int flashDiscount = 20 + rand.nextInt(31);
    int timerH = 2 + rand.nextInt(10);
    int timerM = rand.nextInt(60);
    int timerS = rand.nextInt(60);

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
%>

<style>
    .products-page { background: #fff; min-height: 100vh; }
    .search-box { border: 2px solid #000; display: flex; max-width: 400px; }
    .search-box input { border: none; padding: 14px 20px; font-size: 0.9rem; flex: 1; outline: none; font-family: 'Poppins'; }
    .search-box button { background: var(--black); color: #fff; border: none; padding: 0 24px; cursor: pointer; }

    .filter-tabs { display: flex; gap: 10px; margin-bottom: 30px; flex-wrap: wrap; }
    .filter-tab { padding: 8px 18px; border: 1px solid #ddd; font-size: 0.75rem; cursor: pointer; letter-spacing: 1.5px; text-transform: uppercase; font-weight: 500; background: #fff; transition: all 0.3s; text-decoration: none; color: #888; font-family: 'Poppins'; }
    .filter-tab:hover, .filter-tab.active { background: var(--black); color: #fff; border-color: var(--black); }

    .sale-strip { background: linear-gradient(90deg, var(--black) 0%, var(--brown) 100%); padding: 16px 30px; margin-bottom: 35px; display: flex; justify-content: space-between; align-items: center; }

    .prod-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
    @media (max-width: 1200px) { .prod-grid { grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 768px) { .prod-grid { grid-template-columns: repeat(2, 1fr); } }

    .p-card { background: #fff; border: 1px solid #eee; transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94); position: relative; overflow: hidden; }
    .p-card:hover { box-shadow: 0 25px 60px rgba(0,0,0,0.12); transform: translateY(-8px); }

    .p-img { height: 300px; overflow: hidden; position: relative; background: #f5f5f5; }
    .p-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; }
    .p-card:hover .p-img img { transform: scale(1.08); }

    .p-badge { position: absolute; top: 14px; left: 14px; background: var(--gold); color: var(--black); font-size: 0.6rem; padding: 5px 14px; font-weight: 700; letter-spacing: 2px; font-family: 'Poppins'; z-index: 2; }
    .p-badge.new { background: #000; color: #fff; }
    .p-badge.hot { background: #ef4444; color: #fff; }

    .p-actions { position: absolute; top: 14px; right: 14px; display: flex; flex-direction: column; gap: 6px; z-index: 2; transform: translateX(60px); transition: transform 0.3s ease; }
    .p-card:hover .p-actions { transform: translateX(0); }
    .p-action-btn { background: rgba(255,255,255,0.95); border: none; width: 38px; height: 38px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s; font-size: 0.95rem; text-decoration: none; color: #000; }
    .p-action-btn:hover { background: var(--black); color: #fff; }

    .p-add-bar { position: absolute; bottom: 0; left: 0; right: 0; background: var(--gold); height: 0; overflow: hidden; transition: height 0.3s ease; display: flex; align-items: center; justify-content: center; }
    .p-card:hover .p-add-bar { height: 48px; }
    .p-add-bar form { display: flex; align-items: center; gap: 10px; height: 100%; }
    .p-add-bar input[type=number] { width: 45px; text-align: center; border: 1px solid rgba(0,0,0,0.2); background: rgba(255,255,255,0.8); padding: 6px; font-family: 'Poppins'; font-size: 0.85rem; }
    .p-add-bar button { background: var(--black); color: #fff; border: none; padding: 8px 20px; font-weight: 600; font-size: 0.7rem; letter-spacing: 2px; cursor: pointer; font-family: 'Poppins'; }

    .p-info { padding: 18px 18px 20px; }
    .p-cat { font-size: 0.6rem; color: #bbb; letter-spacing: 3px; text-transform: uppercase; font-weight: 600; margin-bottom: 5px; font-family: 'Poppins'; }
    .p-name { font-family: 'Playfair Display', serif; font-size: 1.05rem; margin-bottom: 3px; font-weight: 600; color: #1a1a1a; }
    .p-desc { font-size: 0.78rem; color: #aaa; margin-bottom: 12px; line-height: 1.5; font-family: 'Poppins'; }
    .p-prices { display: flex; align-items: baseline; gap: 8px; margin-bottom: 6px; }
    .p-now { font-family: 'Playfair Display',serif; font-size: 1.25rem; font-weight: 700; color: var(--brown); }
    .p-was { font-size: 0.8rem; color: #ccc; text-decoration: line-through; }
    .p-off { font-size: 0.68rem; color: #10b981; font-weight: 600; font-family: 'Poppins'; }
    .p-meta { font-size: 0.7rem; color: #ccc; font-family: 'Poppins'; }
    .p-meta .low { color: #ef4444; font-weight: 600; }
</style>

<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-bag"></i>My Bag</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>

<main class="col-md-10 p-4 products-page">

<div class="d-flex justify-content-between align-items-start mb-4">
<div><h2 class="page-title mb-1">New Arrivals</h2><p style="color:#aaa;font-size:0.85rem;margin:0;font-family:'Poppins';">Curated picks from top sellers</p></div>
<form action="${pageContext.request.contextPath}/buyer/products" method="get">
<div class="search-box"><input type="text" name="search" placeholder="Search products..." value="<%= request.getAttribute("searchQuery")!=null?request.getAttribute("searchQuery"):"" %>">
<button type="submit"><i class="bi bi-search"></i></button></div></form></div>

<div class="filter-tabs">
<a href="${pageContext.request.contextPath}/buyer/products" class="filter-tab active">All</a>
<a href="${pageContext.request.contextPath}/buyer/products?search=Electronics" class="filter-tab">Electronics</a>
<a href="${pageContext.request.contextPath}/buyer/products?search=Footwear" class="filter-tab">Footwear</a>
<a href="${pageContext.request.contextPath}/buyer/products?search=Clothing" class="filter-tab">Clothing</a>
<a href="${pageContext.request.contextPath}/buyer/products?search=Accessories" class="filter-tab">Accessories</a>
<a href="${pageContext.request.contextPath}/buyer/products?search=Fashion" class="filter-tab">Fashion</a>
</div>

<div class="sale-strip">
<div><span style="color:var(--gold);font-size:0.7rem;letter-spacing:3px;text-transform:uppercase;font-weight:700;font-family:'Poppins';">&#9889; FLASH SALE &mdash; UP TO <%= flashDiscount %>% OFF</span>
<span style="color:#aaa;font-size:0.8rem;margin-left:16px;font-family:'Poppins';">Selected items only</span></div>
<div style="font-family:'Playfair Display',serif;color:var(--gold);font-size:1.1rem;" id="timer"><%= String.format("%02d",timerH) %>:<%= String.format("%02d",timerM) %>:<%= String.format("%02d",timerS) %></div>
</div>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    int idx = 0;
%>

<% if (products != null && !products.isEmpty()) { %>
<p style="color:#aaa;font-size:0.8rem;margin-bottom:20px;font-family:'Poppins';"><%= products.size() %> products</p>
<div class="prod-grid">
<% for (Product p : products) {
    // Random discount per product (changes on reload)
    int disc = 0;
    String badge = "";
    String badgeCls = "";
    int r = rand.nextInt(10);
    if (r < 3) { disc = 10 + rand.nextInt(35); badge = disc + "% OFF"; }
    else if (r < 5) { badge = "NEW"; badgeCls = "new"; }
    else if (r < 6) { disc = 15 + rand.nextInt(20); badge = "HOT"; badgeCls = "hot"; }
    double oldPrice = disc > 0 ? p.getPrice() * (1 + disc / 100.0) : 0;

    // Match product name to image
    String imgFile = "headphones.jpg"; // default
    String nameLower = p.getName().toLowerCase();
    for (Map.Entry<String, String> entry : imgMap.entrySet()) {
        if (nameLower.contains(entry.getKey())) { imgFile = entry.getValue(); break; }
    }
%>
<div class="p-card">
<div class="p-img">
<img src="${pageContext.request.contextPath}/images/<%= imgFile %>" alt="<%= p.getName() %>">
<% if (!badge.isEmpty()) { %><div class="p-badge <%= badgeCls %>"><%= badge %></div><% } %>
<div class="p-actions">
<form action="${pageContext.request.contextPath}/buyer/wishlist/add" method="post"><input type="hidden" name="productId" value="<%= p.getId() %>">
<button type="submit" class="p-action-btn"><i class="bi bi-heart"></i></button></form>
<a href="${pageContext.request.contextPath}/buyer/products/view?id=<%= p.getId() %>" class="p-action-btn"><i class="bi bi-eye"></i></a>
</div>
<div class="p-add-bar"><form action="${pageContext.request.contextPath}/buyer/cart/add" method="post">
<input type="hidden" name="productId" value="<%= p.getId() %>">
<input type="number" name="quantity" value="1" min="1" max="<%= p.getStockQuantity() %>">
<button type="submit">ADD TO BAG</button></form></div>
</div>
<div class="p-info">
<div class="p-cat"><%= p.getCategory() != null ? p.getCategory() : "GENERAL" %></div>
<div class="p-name"><%= p.getName() %></div>
<div class="p-desc"><%= p.getDescription() != null ? (p.getDescription().length() > 55 ? p.getDescription().substring(0,55) + "..." : p.getDescription()) : "" %></div>
<div class="p-prices">
<span class="p-now">&#8377;<%= String.format("%.0f", p.getPrice()) %></span>
<% if (disc > 0) { %><span class="p-was">&#8377;<%= String.format("%.0f", oldPrice) %></span><span class="p-off"><%= disc %>% OFF</span><% } %>
</div>
<div class="p-meta"><%= p.getSellerName() %> &bull; <% if(p.getStockQuantity()<10){%><span class="low">Only <%= p.getStockQuantity() %> left!</span><%}else{%><%= p.getStockQuantity() %> in stock<%}%></div>
</div></div>
<% idx++; } %>
</div>
<% } else { %>
<div style="text-align:center;padding:80px 0;">
<i class="bi bi-search" style="font-size:4rem;color:#ddd;"></i>
<h3 style="font-family:'Playfair Display',serif;color:#888;margin-top:20px;">No products found</h3>
<a href="${pageContext.request.contextPath}/buyer/products" style="color:var(--brown);font-weight:600;">View all products</a>
</div><% } %>
</main></div></div>

<script>
var h=<%= timerH %>,m=<%= timerM %>,s=<%= timerS %>;
setInterval(function(){s--;if(s<0){s=59;m--;}if(m<0){m=59;h--;}if(h<0){h=23;m=59;s=59;}
document.getElementById('timer').textContent=(h<10?'0':'')+h+':'+(m<10?'0':'')+m+':'+(s<10?'0':'')+s;},1000);
</script>
<%@ include file="../common/footer.jsp" %>
