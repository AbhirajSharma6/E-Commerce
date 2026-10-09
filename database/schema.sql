-- ============================================================
-- E-Commerce Platform Database Schema
-- Database: MySQL
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- -----------------------------------------------------------
-- Users Table: Stores Admin, Seller, and Buyer accounts
-- -----------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'SELLER', 'BUYER') NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------------------------------------
-- Products Table: Stores product listings by sellers
-- -----------------------------------------------------------
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category VARCHAR(100),
    image_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Orders Table: Stores order header information
-- -----------------------------------------------------------
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    shipping_address TEXT NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'COD',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Order Items Table: Stores individual items within an order
-- -----------------------------------------------------------
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Cart Items Table: Stores buyer's shopping cart
-- -----------------------------------------------------------
CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (buyer_id, product_id)
);

-- -----------------------------------------------------------
-- Wishlist Table: Stores buyer's wishlist items
-- -----------------------------------------------------------
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,
    product_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_wishlist_item (buyer_id, product_id)
);

-- -----------------------------------------------------------
-- Insert default admin user (password: admin123)
-- -----------------------------------------------------------
INSERT INTO users (name, email, password, role) VALUES
('Admin', 'admin@ecommerce.com', 'admin123', 'ADMIN');

-- -----------------------------------------------------------
-- Sample data for testing
-- -----------------------------------------------------------
INSERT INTO users (name, email, password, role, phone, address) VALUES
('John Seller', 'seller@test.com', 'seller123', 'SELLER', '9876543210', '123 Seller Street'),
('Jane Buyer', 'buyer@test.com', 'buyer123', 'BUYER', '9876543211', '456 Buyer Avenue');

INSERT INTO products (seller_id, name, description, price, stock_quantity, category, image_url) VALUES
(2, 'Wireless Headphones', 'High-quality wireless headphones with noise cancellation', 2999.00, 50, 'Electronics', 'headphones.jpg'),
(2, 'Running Shoes', 'Comfortable sports running shoes', 1499.00, 100, 'Footwear', 'shoes.jpg'),
(2, 'Laptop Backpack', 'Waterproof laptop backpack with USB charging port', 899.00, 75, 'Accessories', 'backpack.jpg'),
(2, 'Smart Watch', 'Fitness tracker smart watch with heart rate monitor', 3499.00, 30, 'Electronics', 'smartwatch.jpg'),
(2, 'Cotton T-Shirt', 'Premium cotton round neck t-shirt', 499.00, 200, 'Clothing', 'tshirt.jpg');
