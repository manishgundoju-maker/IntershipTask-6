-- 1. Subquery in WHERE with IN
SELECT customer_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id 
    FROM Orders
);

-- 2. Scalar subquery in WHERE with =
SELECT customer_name
FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM Orders
    ORDER BY amount DESC
    LIMIT 1
);

-- 3. Subquery in FROM (derived table)
SELECT customer_id, AVG(amount) AS avg_order
FROM (
    SELECT customer_id, amount
    FROM Orders
) AS order_data
GROUP BY customer_id;

-- 4. Subquery in SELECT (scalar subquery)
SELECT c.customer_name,
       (SELECT COUNT(*)
        FROM Orders o
        WHERE o.customer_id = c.customer_id) AS total_orders
FROM Customers c;

-- 5. Correlated subquery with EXISTS
SELECT customer_name
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
      AND o.amount > 300
);
