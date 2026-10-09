<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.*" %>
<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 sidebar py-3">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i>Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i>Users</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i>Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-receipt"></i>Orders</a></li>
            </ul>
        </nav>

        <main class="col-md-10 p-4">
            <h2 class="mb-4">User Management</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <!-- Add/Edit User Form -->
            <%
                User editUser = (User) request.getAttribute("editUser");
                boolean isEdit = (editUser != null);
            %>
            <div class="card mb-4">
                <div class="card-header"><h5 class="mb-0"><%= isEdit ? "Edit User" : "Add New User" %></h5></div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/users/<%= isEdit ? "update" : "add" %>" method="post">
                        <% if (isEdit) { %>
                            <input type="hidden" name="id" value="<%= editUser.getId() %>">
                        <% } %>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required
                                       value="<%= isEdit ? editUser.getName() : "" %>">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required
                                       value="<%= isEdit ? editUser.getEmail() : "" %>">
                            </div>
                            <% if (!isEdit) { %>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <% } %>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="BUYER" <%= isEdit && editUser.getRole() == User.Role.BUYER ? "selected" : "" %>>Buyer</option>
                                    <option value="SELLER" <%= isEdit && editUser.getRole() == User.Role.SELLER ? "selected" : "" %>>Seller</option>
                                    <option value="ADMIN" <%= isEdit && editUser.getRole() == User.Role.ADMIN ? "selected" : "" %>>Admin</option>
                                </select>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" name="phone"
                                       value="<%= isEdit && editUser.getPhone() != null ? editUser.getPhone() : "" %>">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" class="form-control" name="address"
                                   value="<%= isEdit && editUser.getAddress() != null ? editUser.getAddress() : "" %>">
                        </div>
                        <button type="submit" class="btn btn-primary"><%= isEdit ? "Update" : "Add" %> User</button>
                        <% if (isEdit) { %>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                        <% } %>
                    </form>
                </div>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-header"><h5 class="mb-0">All Users</h5></div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Phone</th><th>Joined</th><th>Actions</th></tr>
                            </thead>
                            <tbody>
                                <%
                                    List<User> users = (List<User>) request.getAttribute("users");
                                    if (users != null) {
                                        for (User u : users) {
                                %>
                                <tr>
                                    <td><%= u.getId() %></td>
                                    <td><%= u.getName() %></td>
                                    <td><%= u.getEmail() %></td>
                                    <td><span class="badge bg-<%= u.getRole() == User.Role.ADMIN ? "danger" : u.getRole() == User.Role.SELLER ? "primary" : "success" %>"><%= u.getRole() %></span></td>
                                    <td><%= u.getPhone() != null ? u.getPhone() : "-" %></td>
                                    <td><%= u.getCreatedAt() %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/users/edit?id=<%= u.getId() %>" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                                        <form action="${pageContext.request.contextPath}/admin/users/delete" method="post" style="display:inline;"
                                              onsubmit="return confirm('Delete this user?')">
                                            <input type="hidden" name="id" value="<%= u.getId() %>">
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
