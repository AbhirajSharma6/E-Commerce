USE ecommerce_db;

-- Add 3 more products to make 8 total
INSERT INTO products (seller_id, name, description, price, stock_quantity, category) VALUES
(2, 'Leather Wallet', 'Genuine leather bifold wallet with RFID protection', 1299.00, 60, 'Accessories'),
(2, 'Bluetooth Speaker', 'Portable waterproof speaker with 12hr battery life', 1999.00, 40, 'Electronics'),
(2, 'Sunglasses', 'Polarized UV400 aviator sunglasses with premium case', 799.00, 90, 'Fashion');
