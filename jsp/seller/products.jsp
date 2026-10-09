<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>
<div class="container-fluid"><div class="row">
<nav class="col-md-2 sidebar py-3"><ul class="nav flex-column">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/seller/products"><i class="bi bi-box-seam"></i>My Products</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/orders"><i class="bi bi-receipt"></i>Orders</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seller/inventory"><i class="bi bi-clipboard-data"></i>Inventory</a></li>
</ul></nav>
<main class="col-md-10 p-4">
<h2 class="mb-4">My Products</h2>
<% if(request.getAttribute("success")!=null){%><div class="alert alert-success"><%=request.getAttribute("success")%></div><%}%>
<% if(request.getAttribute("error")!=null){%><div class="alert alert-danger"><%=request.getAttribute("error")%></div><%}%>

<% Product ep=(Product)request.getAttribute("editProduct"); boolean isEdit=(ep!=null); %>
<div class="card mb-4"><div class="card-header"><h5 class="mb-0"><%= isEdit?"Edit Product":"Add New Product" %></h5></div>
<div class="card-body">
<form action="${pageContext.request.contextPath}/seller/products/<%= isEdit?"update":"add" %>" method="post">
<% if(isEdit){ %><input type="hidden" name="id" value="<%= ep.getId() %>"><% } %>
<div class="row">
<div class="col-md-4 mb-3"><label class="form-label">Product Name *</label>
<input type="text" class="form-control" name="name" required value="<%= isEdit?ep.getName():"" %>"></div>
<div class="col-md-2 mb-3"><label class="form-label">Price (&#8377;) *</label>
<input type="number" step="0.01" class="form-control" name="price" required value="<%= isEdit?ep.getPrice():"" %>"></div>
<div class="col-md-2 mb-3"><label class="form-label">Stock *</label>
<input type="number" class="form-control" name="stockQuantity" required value="<%= isEdit?ep.getStockQuantity():"" %>"></div>
<div class="col-md-2 mb-3"><label class="form-label">Category</label>
<input type="text" class="form-control" name="category" value="<%= isEdit&&ep.getCategory()!=null?ep.getCategory():"" %>"></div>
<div class="col-md-2 mb-3"><label class="form-label">Image URL</label>
<input type="text" class="form-control" name="imageUrl" value="<%= isEdit&&ep.getImageUrl()!=null?ep.getImageUrl():"" %>"></div>
</div>
<div class="mb-3"><label class="form-label">Description</label>
<textarea class="form-control" name="description" rows="2"><%= isEdit&&ep.getDescription()!=null?ep.getDescription():"" %></textarea></div>
<button type="submit" class="btn btn-primary"><%= isEdit?"Update":"Add" %> Product</button>
<% if(isEdit){ %><a href="${pageContext.request.contextPath}/seller/products" class="btn btn-secondary">Cancel</a><% } %>
</form></div></div>

<div class="card"><div class="card-header"><h5 class="mb-0">Product Listings</h5></div>
<div class="card-body"><div class="table-responsive">
<table class="table table-hover"><thead><tr><th>ID</th><th>Name</th><th>Price</th><th>Stock</th><th>Category</th><th>Status</th><th>Actions</th></tr></thead><tbody>
<% List<Product> products=(List<Product>)request.getAttribute("products"); if(products!=null){for(Product p:products){ %>
<tr><td><%= p.getId() %></td><td><%= p.getName() %></td><td>&#8377;<%= String.format("%.2f",p.getPrice()) %></td>
<td><span class="<%= p.getStockQuantity()<10?"text-danger fw-bold":"" %>"><%= p.getStockQuantity() %></span></td>
<td><%= p.getCategory()!=null?p.getCategory():"-" %></td>
<td><span class="badge bg-<%= p.isActive()?"success":"secondary" %>"><%= p.isActive()?"Active":"Inactive" %></span></td>
<td><a href="${pageContext.request.contextPath}/seller/products/edit?id=<%= p.getId() %>" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
<form action="${pageContext.request.contextPath}/seller/products/delete" method="post" style="display:inline" onsubmit="return confirm('Delete?')">
<input type="hidden" name="id" value="<%= p.getId() %>">
<button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></button></form></td></tr>
<% }} %></tbody></table></div></div></div>
</main></div></div>
<%@ include file="../common/footer.jsp" %>
