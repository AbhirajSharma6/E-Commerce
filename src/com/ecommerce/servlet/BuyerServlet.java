package com.ecommerce.servlet;

import com.ecommerce.dao.*;
import com.ecommerce.model.*;
import com.ecommerce.model.Order.Status;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet handling all Buyer operations:
 * - Dashboard with order overview
 * - Product browsing and search
 * - Shopping cart
 * - Checkout and order placement
 * - Order tracking
 * - Wishlist management
 */
@WebServlet("/buyer/*")
public class BuyerServlet extends HttpServlet {

    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private CartDAO cartDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/dashboard";
        User buyer = (User) request.getSession().getAttribute("user");

        try {
            switch (pathInfo) {
                case "/dashboard":
                    showDashboard(request, response, buyer);
                    break;
                case "/products":
                    browseProducts(request, response);
                    break;
                case "/products/view":
                    viewProduct(request, response, buyer);
                    break;
                case "/cart":
                    showCart(request, response, buyer);
                    break;
                case "/checkout":
                    showCheckout(request, response, buyer);
                    break;
                case "/orders":
                    showOrders(request, response, buyer);
                    break;
                case "/orders/view":
                    viewOrder(request, response, buyer);
                    break;
                case "/wishlist":
                    showWishlist(request, response, buyer);
                    break;
                default:
                    showDashboard(request, response, buyer);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/jsp/buyer/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        User buyer = (User) request.getSession().getAttribute("user");

        try {
            switch (pathInfo) {
                case "/cart/add":
                    addToCart(request, response, buyer);
                    break;
                case "/cart/update":
                    updateCart(request, response, buyer);
                    break;
                case "/cart/remove":
                    removeFromCart(request, response, buyer);
                    break;
                case "/checkout/place-order":
                    placeOrder(request, response, buyer);
                    break;
                case "/wishlist/add":
                    addToWishlist(request, response, buyer);
                    break;
                case "/wishlist/remove":
                    removeFromWishlist(request, response, buyer);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/buyer/dashboard");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            try { showDashboard(request, response, buyer); }
            catch (Exception ex) { throw new ServletException(ex); }
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        List<Order> orders = orderDAO.findByBuyerId(buyer.getId());
        int cartCount = cartDAO.getCartCount(buyer.getId());
        List<Product> wishlist = wishlistDAO.getWishlistProducts(buyer.getId());

        request.setAttribute("totalOrders", orders.size());
        request.setAttribute("cartCount", cartCount);
        request.setAttribute("wishlistCount", wishlist.size());
        request.setAttribute("recentOrders", orders.size() > 5 ? orders.subList(0, 5) : orders);
        request.getRequestDispatcher("/jsp/buyer/dashboard.jsp").forward(request, response);
    }

    private void browseProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String search = request.getParameter("search");
        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            products = productDAO.searchProducts(search.trim());
            request.setAttribute("searchQuery", search);
        } else {
            products = productDAO.findActiveProducts();
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("/jsp/buyer/products.jsp").forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(productId);
        boolean inWishlist = wishlistDAO.isInWishlist(buyer.getId(), productId);

        request.setAttribute("product", product);
        request.setAttribute("inWishlist", inWishlist);
        request.getRequestDispatcher("/jsp/buyer/product-detail.jsp").forward(request, response);
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        List<CartItem> cartItems = cartDAO.getCartItems(buyer.getId());
        double cartTotal = cartDAO.getCartTotal(buyer.getId());

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.getRequestDispatcher("/jsp/buyer/cart.jsp").forward(request, response);
    }

    private void showCheckout(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        List<CartItem> cartItems = cartDAO.getCartItems(buyer.getId());
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/buyer/cart");
            return;
        }
        double cartTotal = cartDAO.getCartTotal(buyer.getId());
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("buyer", buyer);
        request.getRequestDispatcher("/jsp/buyer/checkout.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        List<Order> orders = orderDAO.findByBuyerId(buyer.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/jsp/buyer/orders.jsp").forward(request, response);
    }

    private void viewOrder(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.findById(orderId);

        // Verify ownership
        if (order != null && order.getBuyerId() == buyer.getId()) {
            request.setAttribute("order", order);
            request.getRequestDispatcher("/jsp/buyer/order-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/buyer/orders");
        }
    }

    private void showWishlist(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        List<Product> wishlist = wishlistDAO.getWishlistProducts(buyer.getId());
        request.setAttribute("wishlistProducts", wishlist);
        request.getRequestDispatcher("/jsp/buyer/wishlist.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cartDAO.addToCart(buyer.getId(), productId, quantity);
        response.sendRedirect(request.getContextPath() + "/buyer/cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        if (quantity <= 0) {
            cartDAO.removeFromCart(cartItemId);
        } else {
            cartDAO.updateQuantity(cartItemId, quantity);
        }
        response.sendRedirect(request.getContextPath() + "/buyer/cart");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        cartDAO.removeFromCart(cartItemId);
        response.sendRedirect(request.getContextPath() + "/buyer/cart");
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        List<CartItem> cartItems = cartDAO.getCartItems(buyer.getId());
        if (cartItems.isEmpty()) {
            request.setAttribute("error", "Cart is empty.");
            showCart(request, response, buyer);
            return;
        }

        // Build order
        double total = cartDAO.getCartTotal(buyer.getId());
        Order order = new Order(buyer.getId(), total, shippingAddress);
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "COD");

        // Add order items from cart
        for (CartItem ci : cartItems) {
            OrderItem oi = new OrderItem(ci.getProductId(), ci.getQuantity(), ci.getProductPrice());
            order.addItem(oi);
        }

        // Place order (with transaction)
        if (orderDAO.insert(order)) {
            cartDAO.clearCart(buyer.getId()); // Clear cart after successful order
            request.setAttribute("success", "Order placed successfully! Order ID: #" + order.getId());
            request.setAttribute("order", order);
            request.getRequestDispatcher("/jsp/buyer/order-confirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to place order. Please try again.");
            showCheckout(request, response, buyer);
        }
    }

    private void addToWishlist(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        wishlistDAO.addToWishlist(buyer.getId(), productId);
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/buyer/products");
    }

    private void removeFromWishlist(HttpServletRequest request, HttpServletResponse response, User buyer)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        wishlistDAO.removeFromWishlist(buyer.getId(), productId);
        response.sendRedirect(request.getContextPath() + "/buyer/wishlist");
    }
}
