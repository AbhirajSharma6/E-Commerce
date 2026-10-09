<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse Products</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-cart3"></i>Cart</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>My Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>
<main class="col-md-10 p-4">
<h2 class="mb-4"><i class="bi bi-cart3"></i> Shopping Cart</h2>
<% List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
   Double cartTotal = (Double) request.getAttribute("cartTotal"); %>
<% if(cartItems != null && !cartItems.isEmpty()) { %>
<div class="card mb-3"><div class="card-body"><div class="table-responsive">
<table class="table align-middle"><thead><tr><th>Product</th><th>Price</th><th>Quantity</th><th>Subtotal</th><th>Action</th></tr></thead><tbody>
<% for(CartItem ci : cartItems) { %>
<tr><td><strong><%= ci.getProductName() %></strong></td>
<td>&#8377;<%= String.format("%.2f", ci.getProductPrice()) %></td>
<td><form action="${pageContext.request.contextPath}/buyer/cart/update" method="post" class="d-flex gap-1">
<input type="hidden" name="cartItemId" value="<%= ci.getId() %>">
<input type="number" name="quantity" value="<%= ci.getQuantity() %>" min="1" max="<%= ci.getStockQuantity() %>" class="form-control form-control-sm" style="width:70px">
<button type="submit" class="btn btn-sm btn-outline-primary"><i class="bi bi-arrow-clockwise"></i></button></form></td>
<td><strong>&#8377;<%= String.format("%.2f", ci.getSubtotal()) %></strong></td>
<td><form action="${pageContext.request.contextPath}/buyer/cart/remove" method="post" style="display:inline">
<input type="hidden" name="cartItemId" value="<%= ci.getId() %>">
<button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></button></form></td></tr>
<% } %>
</tbody>
<tfoot><tr><td colspan="3" class="text-end"><strong>Total:</strong></td>
<td><h4 class="text-primary mb-0">&#8377;<%= String.format("%.2f", cartTotal) %></h4></td><td></td></tr></tfoot>
</table></div></div></div>
<div class="d-flex justify-content-between">
<a href="${pageContext.request.contextPath}/buyer/products" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> Continue Shopping</a>
<a href="${pageContext.request.contextPath}/buyer/checkout" class="btn btn-success btn-lg"><i class="bi bi-credit-card"></i> Proceed to Checkout</a>
</div>
<% } else { %>
<div class="card"><div class="card-body text-center py-5">
<i class="bi bi-cart-x" style="font-size:4rem;color:#ccc;"></i>
<h4 class="mt-3">Your cart is empty</h4>
<a href="${pageContext.request.contextPath}/buyer/products" class="btn btn-primary mt-2">Browse Products</a>
</div></div><% } %>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
