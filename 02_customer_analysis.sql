-- 1. Revenue per customer
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Country,
    SUM(o.Quantity * p.Price) AS total_spent
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Country
ORDER BY total_spent DESC;


-- 2. Number of orders per customer
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY total_orders DESC;

-- 3. Average order value
SELECT
    ROUND(
        SUM(o.Quantity * p.Price) * 1.0
        / COUNT(DISTINCT o.Order_ID),
        2
    ) AS average_order_value
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID;

-- 4. Customer segmentation by total spending
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Quantity * p.Price) AS total_spent,
    CASE
        WHEN SUM(o.Quantity * p.Price) >= 100 THEN 'High Value'
        WHEN SUM(o.Quantity * p.Price) >= 50 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY total_spent DESC;

---5. Number of customers in each segment

SELECT
    customer_segment,
    COUNT(*) AS customer_count
FROM (
    SELECT
        c.Customer_ID,
        CASE
            WHEN SUM(o.Quantity * p.Price) >= 100 THEN 'High Value'
            WHEN SUM(o.Quantity * p.Price) >= 50 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customers c
    JOIN orders o
        ON c.Customer_ID = o.Customer_ID
    JOIN products p
        ON o.Product_ID = p.Product_ID
    GROUP BY c.Customer_ID
)
GROUP BY customer_segment
ORDER BY customer_count DESC;