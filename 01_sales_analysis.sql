-- 1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Total units sold
SELECT SUM(Quantity) AS total_units_sold
FROM orders;

-- 3. Total revenue
SELECT SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
ON o.Product_ID = p.Product_ID;

-- 4. Revenue by product category
SELECT
p.Category,
SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY total_revenue DESC;

-- 5. Revenue by country
SELECT
c.Country,
SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN customers c
ON o.Customer_ID = c.Customer_ID
JOIN products p
ON o.Product_ID = p.Product_ID
GROUP BY c.Country
ORDER BY total_revenue DESC;