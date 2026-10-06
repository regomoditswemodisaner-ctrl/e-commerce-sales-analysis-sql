-- 1. Revenue by month
SELECT
    strftime('%Y-%m', o.Order_Date) AS order_month,
    SUM(o.Quantity * p.Price) AS monthly_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY order_month
ORDER BY order_month;

-- 2. Number of orders by month
SELECT
    strftime('%Y-%m', Order_Date) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- 3. Units sold by month
SELECT
    strftime('%Y-%m', Order_Date) AS order_month,
    SUM(Quantity) AS total_units_sold
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- 4. Average order value by month
SELECT
    strftime('%Y-%m', o.Order_Date) AS order_month,
    ROUND(
        SUM(o.Quantity * p.Price) * 1.0
        / COUNT(DISTINCT o.Order_ID),
        2
    ) AS average_order_value
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY order_month
ORDER BY order_month;

-- 5. Revenue by quarter
SELECT
    strftime('%Y', o.Order_Date) AS order_year,
    CASE
        WHEN CAST(strftime('%m', o.Order_Date) AS INTEGER) BETWEEN 1 AND 3
            THEN 'Q1'
        WHEN CAST(strftime('%m', o.Order_Date) AS INTEGER) BETWEEN 4 AND 6
            THEN 'Q2'
        WHEN CAST(strftime('%m', o.Order_Date) AS INTEGER) BETWEEN 7 AND 9
            THEN 'Q3'
        ELSE 'Q4'
    END AS quarter,
    SUM(o.Quantity * p.Price) AS total_revenue
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    order_year,
    quarter
ORDER BY
    order_year,
    quarter;
