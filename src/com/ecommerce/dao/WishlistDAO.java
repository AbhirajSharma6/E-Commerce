package com.ecommerce.dao;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Wishlist operations.
 */
public class WishlistDAO {

    /** Get all wishlist products for a buyer */
    public List<Product> getWishlistProducts(int buyerId) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, u.name AS seller_name FROM wishlist w " +
                     "JOIN products p ON w.product_id = p.id " +
                     "JOIN users u ON p.seller_id = u.id " +
                     "WHERE w.buyer_id = ? ORDER BY w.added_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setSellerId(rs.getInt("seller_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStockQuantity(rs.getInt("stock_quantity"));
                    p.setCategory(rs.getString("category"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setActive(rs.getBoolean("is_active"));
                    p.setSellerName(rs.getString("seller_name"));
                    products.add(p);
                }
            }
        }
        return products;
    }

    /** Add product to wishlist */
    public boolean addToWishlist(int buyerId, int productId) throws SQLException {
        String sql = "INSERT IGNORE INTO wishlist (buyer_id, product_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Remove product from wishlist */
    public boolean removeFromWishlist(int buyerId, int productId) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE buyer_id = ? AND product_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        }
    }

    /** Check if a product is in buyer's wishlist */
    public boolean isInWishlist(int buyerId, int productId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE buyer_id = ? AND product_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        }
        return false;
    }
}
