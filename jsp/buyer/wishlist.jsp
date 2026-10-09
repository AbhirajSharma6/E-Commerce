<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<%
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
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-bag"></i>My Bag</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>
<main class="col-md-10 p-4" style="background:#fff;">
<h2 class="page-title mb-1"><i class="bi bi-heart-fill" style="color:#ef4444;"></i> My Wishlist</h2>
<p style="color:#aaa; font-size:0.85rem; margin-bottom:30px;">Products you've saved for later</p>

<div class="row g-4">
<%
    List<Product> wishlist = (List<Product>) request.getAttribute("wishlistProducts");
    if (wishlist != null && !wishlist.isEmpty()) {
        for (Product p : wishlist) {
            String imgFile = "headphones.jpg";
            String nameLower = p.getName().toLowerCase();
            for (Map.Entry<String, String> entry : imgMap.entrySet()) {
                if (nameLower.contains(entry.getKey())) { imgFile = entry.getValue(); break; }
            }
%>
<div class="col-md-3">
<div class="card" style="border:1px solid #eee; overflow:hidden; transition:all 0.4s;">
<div style="height:220px; overflow:hidden; background:var(--cream);">
<img src="${pageContext.request.contextPath}/images/<%= imgFile %>" alt="<%= p.getName() %>"
     style="width:100%; height:100%; object-fit:cover; transition:transform 0.4s;">
</div>
<div style="padding:18px;">
<div style="font-size:0.6rem; color:#bbb; letter-spacing:3px; text-transform:uppercase; font-weight:600; margin-bottom:4px;"><%= p.getCategory()!=null?p.getCategory():"" %></div>
<h5 style="font-family:'Playfair Display',serif; font-size:1rem; margin-bottom:4px;"><%= p.getName() %></h5>
<div style="font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; color:var(--brown); margin-bottom:8px;">&#8377;<%= String.format("%.0f",p.getPrice()) %></div>
<p style="font-size:0.75rem; color:#aaa; margin-bottom:12px;">
<% if(p.getStockQuantity()>0){ %><span style="color:#10b981;"><%= p.getStockQuantity() %> in stock</span>
<% }else{ %><span style="color:#ef4444;">Out of stock</span><% } %>
</p>
<% if(p.getStockQuantity()>0){ %>
<form action="${pageContext.request.contextPath}/buyer/cart/add" method="post" class="mb-2">
<input type="hidden" name="productId" value="<%= p.getId() %>"><input type="hidden" name="quantity" value="1">
<button type="submit" class="btn w-100" style="background:var(--black);color:#fff;font-size:0.8rem;letter-spacing:1.5px;font-weight:600;padding:10px;">
<i class="bi bi-bag-plus me-1"></i> ADD TO BAG</button></form>
<% } %>
<form action="${pageContext.request.contextPath}/buyer/wishlist/remove" method="post">
<input type="hidden" name="productId" value="<%= p.getId() %>">
<button type="submit" class="btn w-100" style="border:1px solid #eee;color:#ef4444;font-size:0.8rem;letter-spacing:1px;padding:10px;background:#fff;">
<i class="bi bi-trash me-1"></i> REMOVE</button></form>
</div></div></div>
<% }
    } else { %>
<div class="col-12">
<div style="text-align:center; padding:80px 0;">
<i class="bi bi-heart" style="font-size:4rem; color:#ddd;"></i>
<h3 style="font-family:'Playfair Display',serif; color:#888; margin-top:16px;">Your wishlist is empty</h3>
<p style="color:#bbb; font-size:0.9rem;">Save products you love and come back to them anytime</p>
<a href="${pageContext.request.contextPath}/buyer/products" class="btn mt-2" style="background:var(--black);color:#fff;padding:12px 30px;font-size:0.85rem;letter-spacing:1.5px;">BROWSE PRODUCTS</a>
</div></div>
<% } %>
</div>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
