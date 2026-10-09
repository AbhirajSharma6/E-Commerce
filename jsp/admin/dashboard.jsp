<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar py-3">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i>Users</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i>Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-receipt"></i>Orders</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="col-md-10 p-4">
            <h2 class="mb-4">Admin Dashboard</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-2">
                    <div class="card stat-card primary p-3">
                        <div class="text-muted small">Total Users</div>
                        <div class="stat-value text-primary"><%= request.getAttribute("totalUsers") %></div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card stat-card success p-3">
                        <div class="text-muted small">Sellers</div>
                        <div class="stat-value text-success"><%= request.getAttribute("totalSellers") %></div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card stat-card warning p-3">
                        <div class="text-muted small">Buyers</div>
                        <div class="stat-value text-warning"><%= request.getAttribute("totalBuyers") %></div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card stat-card primary p-3">
                        <div class="text-muted small">Products</div>
                        <div class="stat-value text-primary"><%= request.getAttribute("totalProducts") %></div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card stat-card danger p-3">
                        <div class="text-muted small">Orders</div>
                        <div class="stat-value text-danger"><%= request.getAttribute("totalOrders") %></div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card stat-card success p-3">
                        <div class="text-muted small">Revenue</div>
                        <div class="stat-value text-success" style="font-size:1.4rem;">&#8377;<%= String.format("%.0f", request.getAttribute("totalRevenue")) %></div>
                    </div>
                </div>
            </div>

            <!-- Recent Orders -->
            <div class="card">
                <div class="card-header"><h5 class="mb-0">Recent Orders</h5></div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr><th>Order ID</th><th>Buyer</th><th>Amount</th><th>Status</th><th>Date</th></tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
                                    if (recentOrders != null) {
                                        int count = 0;
                                        for (Order order : recentOrders) {
                                            if (count++ >= 10) break;
                                %>
                                <tr>
                                    <td>#<%= order.getId() %></td>
                                    <td><%= order.getBuyerName() %></td>
                                    <td>&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></td>
                                    <td>
                                        <span class="badge bg-<%= order.getStatus() == Order.Status.DELIVERED ? "success" : order.getStatus() == Order.Status.CANCELLED ? "danger" : "warning" %>">
                                            <%= order.getStatus() %>
                                        </span>
                                    </td>
                                    <td><%= order.getCreatedAt() %></td>
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
