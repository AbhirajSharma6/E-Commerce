package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.model.User.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet handling all Admin operations:
 * - Dashboard with system overview
 * - User management (CRUD)
 * - Product management
 * - Order management
 */
@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/dashboard";

        try {
            switch (pathInfo) {
                case "/dashboard":
                    showDashboard(request, response);
                    break;
                case "/users":
                    showUsers(request, response);
                    break;
                case "/products":
                    showProducts(request, response);
                    break;
                case "/orders":
                    showOrders(request, response);
                    break;
                case "/users/edit":
                    showEditUser(request, response);
                    break;
                default:
                    showDashboard(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        try {
            switch (pathInfo) {
                case "/users/add":
                    addUser(request, response);
                    break;
                case "/users/update":
                    updateUser(request, response);
                    break;
                case "/users/delete":
                    deleteUser(request, response);
                    break;
                case "/products/delete":
                    deleteProduct(request, response);
                    break;
                case "/orders/update-status":
                    updateOrderStatus(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            try { showDashboard(request, response); }
            catch (Exception ex) { throw new ServletException(ex); }
        }
    }

    /** Admin Dashboard showing system overview */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("totalUsers", userDAO.findAll().size());
        request.setAttribute("totalSellers", userDAO.countByRole(Role.SELLER));
        request.setAttribute("totalBuyers", userDAO.countByRole(Role.BUYER));
        request.setAttribute("totalProducts", productDAO.getTotalCount());
        request.setAttribute("totalOrders", orderDAO.getTotalCount());
        request.setAttribute("totalRevenue", orderDAO.getTotalRevenue());
        request.setAttribute("recentOrders", orderDAO.findAll());
        request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("users", userDAO.findAll());
        request.getRequestDispatcher("/jsp/admin/users.jsp").forward(request, response);
    }

    private void showProducts(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("products", productDAO.findAll());
        request.getRequestDispatcher("/jsp/admin/products.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Order> orders = orderDAO.findAll();
        // Load items for each order
        for (Order order : orders) {
            order.setItems(orderDAO.findOrderItems(order.getId()));
        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/jsp/admin/orders.jsp").forward(request, response);
    }

    private void showEditUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.findById(userId);
        request.setAttribute("editUser", user);
        request.setAttribute("users", userDAO.findAll());
        request.getRequestDispatcher("/jsp/admin/users.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(Role.valueOf(request.getParameter("role")));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        if (userDAO.emailExists(user.getEmail())) {
            request.setAttribute("error", "Email already exists.");
        } else if (userDAO.insert(user)) {
            request.setAttribute("success", "User created successfully.");
        } else {
            request.setAttribute("error", "Failed to create user.");
        }
        showUsers(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setId(Integer.parseInt(request.getParameter("id")));
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setRole(Role.valueOf(request.getParameter("role")));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        if (userDAO.update(user)) {
            request.setAttribute("success", "User updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update user.");
        }
        showUsers(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(request.getParameter("id"));
        if (userDAO.delete(userId)) {
            request.setAttribute("success", "User deleted successfully.");
        } else {
            request.setAttribute("error", "Failed to delete user.");
        }
        showUsers(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        if (productDAO.delete(productId)) {
            request.setAttribute("success", "Product deleted successfully.");
        } else {
            request.setAttribute("error", "Failed to delete product.");
        }
        showProducts(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order.Status status = Order.Status.valueOf(request.getParameter("status"));
        if (orderDAO.updateStatus(orderId, status)) {
            request.setAttribute("success", "Order status updated.");
        } else {
            request.setAttribute("error", "Failed to update order status.");
        }
        showOrders(request, response);
    }
}
