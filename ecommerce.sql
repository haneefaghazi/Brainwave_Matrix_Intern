CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Adding a New Product
INSERT INTO products (name, description, price, stock)
VALUES ('Cricket Ball', 'Rmax Drive Cricket Leather Ball  (Pack of 1, Red)', 99.99, 100);

-- Registering a New Customer
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code)
VALUES ('Johnny', 'Rose', 'johnny.rose@gmail.com', '123-456-7890', '123 Main St', 'Richardstown', 'Karanataka', '560023');

-- Placing a New Order
-- Step 1: Create the order
INSERT INTO orders (customer_id, total_amount)
VALUES (1, 199.98);

-- Step 2: Add items to the order
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (LAST_INSERT_ID(), 1, 2, 99.99);

-- Step 3: Update the stock
UPDATE products
SET stock = stock - 2
WHERE product_id = 1;

-- Recording a Payment
INSERT INTO payments (order_id, amount, payment_method)
VALUES (1, 199.98, 'Credit Card');

-- Viewing Orders by Customer
SELECT o.order_id, o.order_date, o.total_amount, o.status, p.payment_date, p.amount, p.payment_method
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE o.customer_id = 1;

-- Updating Order Status
UPDATE orders
SET status = 'Shipped'
WHERE order_id = 1;

-- Checking Product Availability
SELECT stock
FROM products
WHERE product_id = 1;





