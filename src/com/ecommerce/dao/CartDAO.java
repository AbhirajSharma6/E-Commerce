package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for CartItem entity.
 * Manages shopping cart operations.
 */
public class CartDAO {

    /** Get all cart items for a buyer, joined with product details */
    public List<CartItem> getCartItems(int buyerId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT c.*, p.name AS product_name, p.price AS product_price, p.stock_quantity " +
                     "FROM cart_items c JOIN products p ON c.product_id = p.id " +
                     "WHERE c.buyer_id = ? ORDER BY c.added_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setBuyerId(rs.getInt("buyer_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddedAt(rs.getTimestamp("added_at"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductPrice(rs.getDouble("product_price"));
                    item.setStockQuantity(rs.getInt("stock_quantity"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    /** Add an item to cart (or update quantity if already exists) */
    public boolean addToCart(int buyerId, int productId, int quantity) throws SQLException {
        String sql = "INSERT INTO cart_items (buyer_id, product_id, quantity) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    /** Update cart item quantity */
    public boolean updateQuantity(int cartItemId, int quantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Remove an item from cart */
    public boolean removeFromCart(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Clear all items from a buyer's cart */
    public boolean clearCart(int buyerId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE buyer_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Get cart item count for a buyer */
    public int getCartCount(int buyerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE buyer_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    /** Calculate cart total */
    public double getCartTotal(int buyerId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(c.quantity * p.price), 0) FROM cart_items c " +
                     "JOIN products p ON c.product_id = p.id WHERE c.buyer_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        }
        return 0;
    }
}
