<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 sidebar py-3">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i>Users</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i>Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-receipt"></i>Orders</a></li>
            </ul>
        </nav>

        <main class="col-md-10 p-4">
            <h2 class="mb-4">Product Management</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="card">
                <div class="card-header"><h5 class="mb-0">All Products</h5></div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr><th>ID</th><th>Name</th><th>Seller</th><th>Price</th><th>Stock</th><th>Category</th><th>Status</th><th>Actions</th></tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Product> products = (List<Product>) request.getAttribute("products");
                                    if (products != null) {
                                        for (Product p : products) {
                                %>
                                <tr>
                                    <td><%= p.getId() %></td>
                                    <td><%= p.getName() %></td>
                                    <td><%= p.getSellerName() %></td>
                                    <td>&#8377;<%= String.format("%.2f", p.getPrice()) %></td>
                                    <td>
                                        <span class="<%= p.getStockQuantity() < 10 ? "text-danger fw-bold" : "" %>">
                                            <%= p.getStockQuantity() %>
                                        </span>
                                    </td>
                                    <td><%= p.getCategory() != null ? p.getCategory() : "-" %></td>
                                    <td><span class="badge bg-<%= p.isActive() ? "success" : "secondary" %>"><%= p.isActive() ? "Active" : "Inactive" %></span></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" style="display:inline;"
                                              onsubmit="return confirm('Delete this product?')">
                                            <input type="hidden" name="id" value="<%= p.getId() %>">
                                            <button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
