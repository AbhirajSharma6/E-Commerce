<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<% Order order = (Order) request.getAttribute("order"); %>
<div class="container mt-4">
<a href="${pageContext.request.contextPath}/buyer/orders" class="btn btn-outline-secondary mb-3"><i class="bi bi-arrow-left"></i> Back to Orders</a>
<% if(order!=null){ %>
<div class="card"><div class="card-header d-flex justify-content-between">
<h4 class="mb-0">Order #<%= order.getId() %></h4>
<span class="badge bg-<%= order.getStatus()==Order.Status.DELIVERED?"success":order.getStatus()==Order.Status.CANCELLED?"danger":order.getStatus()==Order.Status.SHIPPED?"info":"warning" %>" style="font-size:1rem"><%= order.getStatus() %></span>
</div><div class="card-body">
<div class="row mb-3">
<div class="col-md-4"><strong>Order Date:</strong><br><%= order.getCreatedAt() %></div>
<div class="col-md-4"><strong>Payment:</strong><br><%= order.getPaymentMethod() %></div>
<div class="col-md-4"><strong>Shipping Address:</strong><br><%= order.getShippingAddress() %></div>
</div><hr>
<h5>Items</h5>
<table class="table"><thead><tr><th>Product</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr></thead><tbody>
<% if(order.getItems()!=null){for(OrderItem item:order.getItems()){ %>
<tr><td><%= item.getProductName() %></td><td>&#8377;<%= String.format("%.2f",item.getPrice()) %></td>
<td><%= item.getQuantity() %></td><td>&#8377;<%= String.format("%.2f",item.getSubtotal()) %></td></tr>
<% }} %>
</tbody><tfoot><tr><td colspan="3" class="text-end"><strong>Total:</strong></td>
<td><h5 class="text-primary">&#8377;<%= String.format("%.2f",order.getTotalAmount()) %></h5></td></tr></tfoot></table>

<!-- Order Tracking Timeline -->
<h5 class="mt-4">Order Tracking</h5>
<div class="d-flex justify-content-between mt-3 px-4">
<% String[] statuses={"PENDING","CONFIRMED","SHIPPED","DELIVERED"}; 
   int currentIdx=java.util.Arrays.asList(statuses).indexOf(order.getStatus().name());
   for(int i=0;i<statuses.length;i++){ %>
<div class="text-center">
<div class="rounded-circle d-inline-flex align-items-center justify-content-center <%= i<=currentIdx?"bg-success":"bg-secondary" %>" style="width:40px;height:40px;">
<i class="bi bi-check text-white"></i></div>
<div class="small mt-1 <%= i<=currentIdx?"fw-bold":"text-muted" %>"><%= statuses[i] %></div>
</div><% } %>
</div>
</div></div><% } %>
</div>
<%@ include file="../common/footer.jsp" %>
