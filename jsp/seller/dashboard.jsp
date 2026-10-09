<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/seller/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/products"><i class="bi bi-box-seam"></i>My Products</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/inventory"><i class="bi bi-clipboard-data"></i>Inventory</a></li>
</ul></nav>
<main class="col-md-10 p-4">
<h2 class="mb-4">Seller Dashboard</h2>
<div class="row mb-4">
<div class="col-md-3"><div class="card stat-card primary p-3"><div class="text-muted small">My Products</div><div class="stat-value text-primary"><%= request.getAttribute("totalProducts") %></div></div></div>
<div class="col-md-3"><div class="card stat-card warning p-3"><div class="text-muted small">Total Orders</div><div class="stat-value text-warning"><%= request.getAttribute("totalOrders") %></div></div></div>
<div class="col-md-3"><div class="card stat-card success p-3"><div class="text-muted small">Revenue</div><div class="stat-value text-success" style="font-size:1.4rem">&#8377;<%= String.format("%.0f", request.getAttribute("revenue")) %></div></div></div>
<div class="col-md-3"><div class="card stat-card danger p-3"><div class="text-muted small">Low Stock</div><div class="stat-value text-danger"><%= ((List)request.getAttribute("lowStockProducts")).size() %></div></div></div>
</div>
<div class="row">
<div class="col-md-7"><div class="card"><div class="card-header"><h5 class="mb-0">Recent Orders</h5></div><div class="card-body">
<table class="table table-sm"><thead><tr><th>Order</th><th>Buyer</th><th>Amount</th><th>Status</th></tr></thead><tbody>
<% List<Order> ro=(List<Order>)request.getAttribute("recentOrders"); if(ro!=null){for(Order o:ro){ %>
<tr><td>#<%= o.getId() %></td><td><%= o.getBuyerName() %></td><td>&#8377;<%= String.format("%.2f",o.getTotalAmount()) %></td>
<td><span class="badge bg-<%= o.getStatus()==Order.Status.DELIVERED?"success":o.getStatus()==Order.Status.CANCELLED?"danger":"warning" %>"><%= o.getStatus() %></span></td></tr>
<% }} %></tbody></table></div></div></div>
<div class="col-md-5"><div class="card"><div class="card-header"><h5 class="mb-0">Low Stock Alerts</h5></div><div class="card-body">
<% List<Product> ls=(List<Product>)request.getAttribute("lowStockProducts"); if(ls!=null&&!ls.isEmpty()){for(Product p:ls){ %>
<div class="d-flex justify-content-between align-items-center mb-2 p-2 bg-light rounded"><span><%= p.getName() %></span><span class="badge bg-danger"><%= p.getStockQuantity() %> left</span></div>
<% }}else{ %><p class="text-muted">All products well-stocked!</p><% } %>
</div></div></div></div>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
