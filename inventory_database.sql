-- ============================================
-- Inventory Management Database
-- Author: [Niranjan Reddy]
-- Purpose: Demonstrates SQL skills - table creation,
--          relationships (foreign keys), and querying
--          (SELECT, JOIN, GROUP BY, WHERE)
-- ============================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS inventory_db;
USE inventory_db;

-- Step 2: Create tables

-- Table for product categories (e.g., Electronics, Stationery)
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- Table for products, linked to categories
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Table for recording sales/orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity_sold INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 3: Insert sample data

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Stationery'),
('Furniture');

INSERT INTO products (product_name, category_id, price, quantity_in_stock) VALUES
('Wireless Mouse', 1, 499.00, 50),
('USB Keyboard', 1, 799.00, 30),
('Notebook', 2, 40.00, 200),
('Pen Set', 2, 60.00, 150),
('Office Chair', 3, 3499.00, 15),
('Study Table', 3, 4999.00, 10);

INSERT INTO orders (product_id, quantity_sold, order_date) VALUES
(1, 5, '2026-09-01'),
(2, 3, '2026-09-02'),
(3, 20, '2026-09-03'),
(1, 2, '2026-09-05'),
(5, 1, '2026-09-06'),
(4, 10, '2026-09-07');

-- ============================================
-- Step 4: Useful queries (run these one at a time)
-- ============================================

-- 1. View all products
SELECT * FROM products;

-- 2. View products with their category name (JOIN)
SELECT p.product_name, c.category_name, p.price, p.quantity_in_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 3. Find products low in stock (quantity < 20)
SELECT product_name, quantity_in_stock
FROM products
WHERE quantity_in_stock < 20;

-- 4. Total quantity sold per product (GROUP BY)
SELECT p.product_name, SUM(o.quantity_sold) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- 5. Total revenue per category (JOIN + GROUP BY + calculation)
SELECT c.category_name, SUM(o.quantity_sold * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
