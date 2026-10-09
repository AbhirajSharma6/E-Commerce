package com.ecommerce.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * CartItem model representing a product in a buyer's shopping cart.
 */
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int buyerId;
    private int productId;
    private int quantity;
    private Timestamp addedAt;

    // Display fields (joined from products table)
    private String productName;
    private double productPrice;
    private int stockQuantity;

    public CartItem() {
        this.quantity = 1;
    }

    public CartItem(int buyerId, int productId, int quantity) {
        this.buyerId = buyerId;
        this.productId = productId;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBuyerId() { return buyerId; }
    public void setBuyerId(int buyerId) { this.buyerId = buyerId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getProductPrice() { return productPrice; }
    public void setProductPrice(double productPrice) { this.productPrice = productPrice; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    /** Get subtotal for this cart item */
    public double getSubtotal() {
        return productPrice * quantity;
    }
}
