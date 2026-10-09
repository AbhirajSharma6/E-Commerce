<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/products"><i class="bi bi-box-seam"></i>My Products</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/seller/inventory"><i class="bi bi-clipboard-data"></i>Inventory</a></li>
</ul></nav>
<main class="col-md-10 p-4">
<h2 class="mb-4">Inventory Management</h2>
<% if(request.getAttribute("success")!=null){%><div class="alert alert-success"><%=request.getAttribute("success")%></div><%}%>

<% List<Product> lowStock=(List<Product>)request.getAttribute("lowStockProducts"); if(lowStock!=null&&!lowStock.isEmpty()){ %>
<div class="alert alert-warning"><i class="bi bi-exclamation-triangle"></i> <strong><%= lowStock.size() %></strong> products have low stock (below 10 units)!</div>
<% } %>

<div class="card"><div class="card-header"><h5 class="mb-0">Inventory Overview</h5></div>
<div class="card-body"><div class="table-responsive">
<table class="table table-hover"><thead><tr><th>Product</th><th>Category</th><th>Price</th><th>Current Stock</th><th>Status</th><th>Update Stock</th></tr></thead><tbody>
<% List<Product> products=(List<Product>)request.getAttribute("products"); if(products!=null){for(Product p:products){ %>
<tr><td><%= p.getName() %></td><td><%= p.getCategory()!=null?p.getCategory():"-" %></td>
<td>&#8377;<%= String.format("%.2f",p.getPrice()) %></td>
<td><span class="badge bg-<%= p.getStockQuantity()<10?"danger":p.getStockQuantity()<30?"warning":"success" %>" style="font-size:0.9rem"><%= p.getStockQuantity() %></span></td>
<td><%= p.getStockQuantity()==0?"Out of Stock":p.getStockQuantity()<10?"Low":"In Stock" %></td>
<td><form action="${pageContext.request.contextPath}/seller/inventory/update" method="post" class="d-flex gap-1">
<input type="hidden" name="productId" value="<%= p.getId() %>">
<input type="number" name="stockQuantity" value="<%= p.getStockQuantity() %>" class="form-control form-control-sm" style="width:80px" min="0">
<button type="submit" class="btn btn-sm btn-primary">Update</button></form></td></tr>
<% }} %></tbody></table></div></div></div>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
