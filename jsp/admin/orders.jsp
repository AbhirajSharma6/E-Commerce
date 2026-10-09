<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 sidebar py-3">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i>Users</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i>Products</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-receipt"></i>Orders</a></li>
            </ul>
        </nav>

        <main class="col-md-10 p-4">
            <h2 class="mb-4">Order Management</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr><th>Order ID</th><th>Buyer</th><th>Items</th><th>Total</th><th>Status</th><th>Date</th><th>Update Status</th></tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                                    if (orders != null) {
                                        for (Order o : orders) {
                                %>
                                <tr>
                                    <td>#<%= o.getId() %></td>
                                    <td><%= o.getBuyerName() %></td>
                                    <td>
                                        <% for (OrderItem item : o.getItems()) { %>
                                            <%= item.getProductName() %> x<%= item.getQuantity() %><br>
                                        <% } %>
                                    </td>
                                    <td>&#8377;<%= String.format("%.2f", o.getTotalAmount()) %></td>
                                    <td>
                                        <span class="badge bg-<%= o.getStatus() == Order.Status.DELIVERED ? "success" : o.getStatus() == Order.Status.CANCELLED ? "danger" : o.getStatus() == Order.Status.SHIPPED ? "info" : "warning" %>">
                                            <%= o.getStatus() %>
                                        </span>
                                    </td>
                                    <td><%= o.getCreatedAt() %></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" class="d-flex gap-1">
                                            <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                            <select name="status" class="form-select form-select-sm" style="width:130px;">
                                                <option value="PENDING" <%= o.getStatus() == Order.Status.PENDING ? "selected" : "" %>>Pending</option>
                                                <option value="CONFIRMED" <%= o.getStatus() == Order.Status.CONFIRMED ? "selected" : "" %>>Confirmed</option>
                                                <option value="SHIPPED" <%= o.getStatus() == Order.Status.SHIPPED ? "selected" : "" %>>Shipped</option>
                                                <option value="DELIVERED" <%= o.getStatus() == Order.Status.DELIVERED ? "selected" : "" %>>Delivered</option>
                                                <option value="CANCELLED" <%= o.getStatus() == Order.Status.CANCELLED ? "selected" : "" %>>Cancelled</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-primary">Update</button>
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
