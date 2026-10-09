<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/products"><i class="bi bi-shop-window"></i>Browse Products</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/cart"><i class="bi bi-cart3"></i>Cart</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/buyer/orders"><i class="bi bi-receipt"></i>My Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/buyer/wishlist"><i class="bi bi-heart"></i>Wishlist</a></li>
</ul></nav>
<main class="col-md-10 p-4">
<h2 class="mb-4">My Orders</h2>
<div class="card"><div class="card-body"><div class="table-responsive">
<table class="table table-hover"><thead><tr><th>Order ID</th><th>Amount</th><th>Payment</th><th>Status</th><th>Date</th><th>Details</th></tr></thead><tbody>
<% List<Order> orders = (List<Order>) request.getAttribute("orders");
   if(orders!=null&&!orders.isEmpty()){for(Order o:orders){ %>
<tr><td>#<%= o.getId() %></td>
<td>&#8377;<%= String.format("%.2f",o.getTotalAmount()) %></td>
<td><%= o.getPaymentMethod() %></td>
<td><span class="badge bg-<%= o.getStatus()==Order.Status.DELIVERED?"success":o.getStatus()==Order.Status.CANCELLED?"danger":o.getStatus()==Order.Status.SHIPPED?"info":"warning" %>"><%= o.getStatus() %></span></td>
<td><%= o.getCreatedAt() %></td>
<td><a href="${pageContext.request.contextPath}/buyer/orders/view?id=<%= o.getId() %>" class="btn btn-sm btn-outline-primary">View</a></td></tr>
<% }}else{ %><tr><td colspan="6" class="text-center text-muted">No orders yet.</td></tr><% } %>
</tbody></table></div></div></div>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
