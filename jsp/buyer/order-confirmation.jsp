<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<% Order order = (Order) request.getAttribute("order"); %>
<div class="container mt-5">
<div class="text-center">
<i class="bi bi-check-circle-fill text-success" style="font-size:5rem;"></i>
<h2 class="mt-3">Order Placed Successfully!</h2>
<% if(order!=null){ %>
<p class="lead">Your Order ID: <strong>#<%= order.getId() %></strong></p>
<p>Total Amount: <strong>&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></strong></p>
<p>Payment: <strong><%= order.getPaymentMethod() %></strong></p>
<p>Status: <span class="badge bg-warning"><%= order.getStatus() %></span></p>
<% } %>
<div class="mt-4">
<a href="${pageContext.request.contextPath}/buyer/orders" class="btn btn-primary me-2"><i class="bi bi-receipt"></i> View Orders</a>
<a href="${pageContext.request.contextPath}/buyer/products" class="btn btn-outline-secondary"><i class="bi bi-shop-window"></i> Continue Shopping</a>
</div></div></div>
<%@ include file="../common/footer.jsp" %>
