package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Order;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet handling all Seller operations:
 * - Dashboard with sales overview
 * - Product listing (CRUD)
 * - Inventory management
 * - Order processing
 */
@WebServlet("/seller/*")
public class SellerServlet extends HttpServlet {

    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/dashboard";
        User seller = (User) request.getSession().getAttribute("user");

        try {
            switch (pathInfo) {
                case "/dashboard":
                    showDashboard(request, response, seller);
                    break;
                case "/products":
                    showProducts(request, response, seller);
                    break;
                case "/products/edit":
                    showEditProduct(request, response, seller);
                    break;
                case "/orders":
                    showOrders(request, response, seller);
                    break;
                case "/inventory":
                    showInventory(request, response, seller);
                    break;
                default:
                    showDashboard(request, response, seller);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/jsp/seller/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        User seller = (User) request.getSession().getAttribute("user");

        try {
            switch (pathInfo) {
                case "/products/add":
                    addProduct(request, response, seller);
                    break;
                case "/products/update":
                    updateProduct(request, response, seller);
                    break;
                case "/products/delete":
                    deleteProduct(request, response, seller);
                    break;
                case "/orders/update-status":
                    updateOrderStatus(request, response, seller);
                    break;
                case "/inventory/update":
                    updateInventory(request, response, seller);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/seller/dashboard");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            try { showDashboard(request, response, seller); }
            catch (Exception ex) { throw new ServletException(ex); }
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        List<Product> products = productDAO.findBySellerId(seller.getId());
        List<Order> orders = orderDAO.findBySellerProducts(seller.getId());
        List<Product> lowStock = productDAO.getLowStockProducts(seller.getId());
        double revenue = orderDAO.getSellerRevenue(seller.getId());

        request.setAttribute("totalProducts", products.size());
        request.setAttribute("totalOrders", orders.size());
        request.setAttribute("revenue", revenue);
        request.setAttribute("lowStockProducts", lowStock);
        request.setAttribute("recentOrders", orders.size() > 5 ? orders.subList(0, 5) : orders);
        request.getRequestDispatcher("/jsp/seller/dashboard.jsp").forward(request, response);
    }

    private void showProducts(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        request.setAttribute("products", productDAO.findBySellerId(seller.getId()));
        request.getRequestDispatcher("/jsp/seller/products.jsp").forward(request, response);
    }

    private void showEditProduct(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(productId);
        // Verify ownership
        if (product != null && product.getSellerId() == seller.getId()) {
            request.setAttribute("editProduct", product);
        }
        request.setAttribute("products", productDAO.findBySellerId(seller.getId()));
        request.getRequestDispatcher("/jsp/seller/products.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        List<Order> orders = orderDAO.findBySellerProducts(seller.getId());
        for (Order order : orders) {
            order.setItems(orderDAO.findOrderItems(order.getId()));
        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/jsp/seller/orders.jsp").forward(request, response);
    }

    private void showInventory(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        request.setAttribute("products", productDAO.findBySellerId(seller.getId()));
        request.setAttribute("lowStockProducts", productDAO.getLowStockProducts(seller.getId()));
        request.getRequestDispatcher("/jsp/seller/inventory.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        Product product = new Product();
        product.setSellerId(seller.getId());
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        product.setCategory(request.getParameter("category"));
        product.setImageUrl(request.getParameter("imageUrl"));

        if (productDAO.insert(product)) {
            request.setAttribute("success", "Product added successfully.");
        } else {
            request.setAttribute("error", "Failed to add product.");
        }
        showProducts(request, response, seller);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(productId);

        if (product == null || product.getSellerId() != seller.getId()) {
            request.setAttribute("error", "Product not found or access denied.");
            showProducts(request, response, seller);
            return;
        }

        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        product.setCategory(request.getParameter("category"));
        product.setImageUrl(request.getParameter("imageUrl"));

        if (productDAO.update(product)) {
            request.setAttribute("success", "Product updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update product.");
        }
        showProducts(request, response, seller);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(productId);

        if (product != null && product.getSellerId() == seller.getId()) {
            if (productDAO.delete(productId)) {
                request.setAttribute("success", "Product deleted successfully.");
            } else {
                request.setAttribute("error", "Failed to delete product.");
            }
        } else {
            request.setAttribute("error", "Access denied.");
        }
        showProducts(request, response, seller);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order.Status status = Order.Status.valueOf(request.getParameter("status"));
        orderDAO.updateStatus(orderId, status);
        request.setAttribute("success", "Order status updated.");
        showOrders(request, response, seller);
    }

    private void updateInventory(HttpServletRequest request, HttpServletResponse response, User seller)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int newStock = Integer.parseInt(request.getParameter("stockQuantity"));
        Product product = productDAO.findById(productId);

        if (product != null && product.getSellerId() == seller.getId()) {
            product.setStockQuantity(newStock);
            productDAO.update(product);
            request.setAttribute("success", "Inventory updated.");
        }
        showInventory(request, response, seller);
    }
}
