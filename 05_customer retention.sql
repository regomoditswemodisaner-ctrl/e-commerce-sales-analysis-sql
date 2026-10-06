-- 1. Last purchase date for each customer
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Country,
    MAX(o.Order_Date) AS last_purchase_date
FROM customers c
LEFT JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Country
ORDER BY last_purchase_date;

-- 2. Customers with no orders
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Country
FROM customers c
LEFT JOIN orders o
    ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;


-- 3. Number of days since each customer's last purchase
SELECT
    c.Customer_ID,
    c.Customer_Name,
    MAX(o.Order_Date) AS last_purchase_date,
    CAST(
        julianday('2026-04-30') - julianday(MAX(o.Order_Date))
        AS INTEGER
    ) AS days_since_purchase
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY days_since_purchase DESC;

-- 4. Customer Activity status

SELECT
    c.Customer_ID,
    c.Customer_Name,
    MAX(o.Order_Date) AS last_purchase_date,
    CAST(
        julianday('2026-04-30') - julianday(MAX(o.Order_Date))
        AS INTEGER
    ) AS days_since_purchase,
    CASE
        WHEN julianday('2026-04-30') - julianday(MAX(o.Order_Date)) <= 30
            THEN 'Active'
        WHEN julianday('2026-04-30') - julianday(MAX(o.Order_Date)) <= 60
            THEN 'At Risk'
        ELSE 'Inactive'
    END AS customer_status
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY days_since_purchase DESC;