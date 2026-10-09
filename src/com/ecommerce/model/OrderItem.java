package com.ecommerce.model;

import java.io.Serializable;

/**
 * OrderItem model representing a single line item within an order.
 */
public class OrderItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private double price;

    // Display fields
    private String productName;

    public OrderItem() {}

    public OrderItem(int productId, int quantity, double price) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    /** Get subtotal for this line item */
    public double getSubtotal() {
        return price * quantity;
    }

    @Override
    public String toString() {
        return "OrderItem{productId=" + productId + ", qty=" + quantity + ", price=" + price + "}";
    }
}
