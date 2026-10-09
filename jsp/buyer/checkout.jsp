<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<% List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
   Double cartTotal = (Double) request.getAttribute("cartTotal");
   User buyer = (User) request.getAttribute("buyer"); %>
<div class="container mt-4">
<h2 class="mb-4"><i class="bi bi-credit-card"></i> Checkout</h2>
<% if(request.getAttribute("error")!=null){%><div class="alert alert-danger"><%=request.getAttribute("error")%></div><%}%>
<div class="row">
<div class="col-md-7">
<div class="card mb-3"><div class="card-header"><h5 class="mb-0">Shipping Information</h5></div>
<div class="card-body">
<form action="${pageContext.request.contextPath}/buyer/checkout/place-order" method="post" id="checkoutForm">
<div class="mb-3"><label class="form-label">Shipping Address *</label>
<textarea class="form-control" name="shippingAddress" rows="3" required><%= buyer!=null&&buyer.getAddress()!=null?buyer.getAddress():"" %></textarea></div>
<div class="mb-3"><label class="form-label">Payment Method</label>
<select class="form-select" name="paymentMethod">
<option value="COD">Cash on Delivery</option>
<option value="UPI">UPI</option>
<option value="CARD">Credit/Debit Card</option>
<option value="NETBANKING">Net Banking</option>
</select></div>
<button type="submit" class="btn btn-success btn-lg w-100" onclick="return confirm('Confirm order placement?')">
<i class="bi bi-check-circle"></i> Place Order - &#8377;<%= String.format("%.2f", cartTotal) %></button>
</form></div></div></div>

<div class="col-md-5">
<div class="card"><div class="card-header"><h5 class="mb-0">Order Summary</h5></div>
<div class="card-body">
<% if(cartItems!=null){for(CartItem ci:cartItems){ %>
<div class="d-flex justify-content-between mb-2">
<span><%= ci.getProductName() %> x<%= ci.getQuantity() %></span>
<span>&#8377;<%= String.format("%.2f",ci.getSubtotal()) %></span></div>
<% }} %><hr>
<div class="d-flex justify-content-between"><strong>Total</strong><h5 class="text-primary">&#8377;<%= String.format("%.2f", cartTotal) %></h5></div>
</div></div></div>
</div></div>
<%@ include file="../common/footer.jsp" %>
