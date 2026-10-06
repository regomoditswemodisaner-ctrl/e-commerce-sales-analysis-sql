-- 1. Units sold by product
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(o.Quantity) AS total_units_sold
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category
ORDER BY total_units_sold DESC;


-- 2. Revenue by product
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category
ORDER BY total_revenue DESC;


-- 3. Revenue by product category
SELECT
    p.Category,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY total_revenue DESC;


-- 4. Product performance: units sold and revenue
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(o.Quantity) AS total_units_sold,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category
ORDER BY total_revenue DESC;

-- 5. Products generating less than $50 in revenue
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category
HAVING total_revenue < 50
ORDER BY total_revenue ASC;