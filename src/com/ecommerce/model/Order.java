package com.ecommerce.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Order model representing a purchase order placed by a buyer.
 * Uses a List of OrderItem to demonstrate Collections usage.
 */
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    /** Enum defining order status lifecycle */
    public enum Status {
        PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED
    }

    private int id;
    private int buyerId;
    private double totalAmount;
    private Status status;
    private String shippingAddress;
    private String paymentMethod;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Associated order items (demonstrates Collections)
    private List<OrderItem> items = new ArrayList<>();

    // Display field
    private String buyerName;

    public Order() {
        this.status = Status.PENDING;
        this.paymentMethod = "COD";
    }

    public Order(int buyerId, double totalAmount, String shippingAddress) {
        this.buyerId = buyerId;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = Status.PENDING;
        this.paymentMethod = "COD";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBuyerId() { return buyerId; }
    public void setBuyerId(int buyerId) { this.buyerId = buyerId; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    public String getBuyerName() { return buyerName; }
    public void setBuyerName(String buyerName) { this.buyerName = buyerName; }

    /** Add an item to this order */
    public void addItem(OrderItem item) {
        this.items.add(item);
    }

    /** Calculate total from items */
    public double calculateTotal() {
        return items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    @Override
    public String toString() {
        return "Order{id=" + id + ", buyerId=" + buyerId + ", total=" + totalAmount + ", status=" + status + "}";
    }
}
