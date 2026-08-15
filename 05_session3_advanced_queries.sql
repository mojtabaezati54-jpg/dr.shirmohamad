-- Session 3 advanced SQL examples for Team 2.
-- These queries work on the Team 2 schema alone.

-- ============================================================
-- 1) Window Function #1: rank products by price within category
-- ============================================================
SELECT
    c.name AS category_name,
    p.name AS product_name,
    p.price_amount,
    RANK() OVER (
        PARTITION BY p.category_id
        ORDER BY p.price_amount DESC
    ) AS price_rank
FROM products p
JOIN categories c ON c.category_id = p.category_id;

-- ============================================================
-- 2) Window Function #2: running inventory value by store
-- ============================================================
SELECT
    s.name AS store_name,
    p.name AS product_name,
    i.quantity,
    ROUND(i.quantity * p.price_amount * p.exchange_rate_to_irr, 0) AS inventory_value_irr,
    SUM(i.quantity * p.price_amount * p.exchange_rate_to_irr)
        OVER (PARTITION BY s.store_id ORDER BY p.product_id) AS running_store_value_irr
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN inventory i ON i.product_id = p.product_id;

-- ============================================================
-- 3) Window Function #3: average price by category
-- ============================================================
SELECT
    c.name AS category_name,
    p.name AS product_name,
    p.price_amount,
    ROUND(AVG(p.price_amount) OVER (PARTITION BY p.category_id), 2) AS category_avg_price
FROM products p
JOIN categories c ON c.category_id = p.category_id;

-- ============================================================
-- 4) Window Function #4: compare each product with previous price
-- (The current dataset has one current price per product, so this
-- demonstrates LAG over product ordering; for real price history,
-- create a product_price_history table in a later analytics phase.)
-- ============================================================
SELECT
    store_id,
    product_id,
    name,
    price_amount,
    LAG(price_amount) OVER (PARTITION BY store_id ORDER BY product_id) AS previous_product_price
FROM products;

-- ============================================================
-- CTE #1
-- ============================================================
WITH store_inventory AS (
    SELECT
        s.store_id,
        s.name AS store_name,
        SUM(i.quantity * p.price_amount * p.exchange_rate_to_irr) AS inventory_value_irr
    FROM stores s
    JOIN products p ON p.store_id = s.store_id
    JOIN inventory i ON i.product_id = p.product_id
    GROUP BY s.store_id, s.name
)
SELECT *
FROM store_inventory
ORDER BY inventory_value_irr DESC;

-- ============================================================
-- CTE #2
-- ============================================================
WITH category_stats AS (
    SELECT
        category_id,
        COUNT(*) AS product_count,
        AVG(price_amount) AS avg_price
    FROM products
    GROUP BY category_id
)
SELECT
    c.name,
    cs.product_count,
    ROUND(cs.avg_price, 2) AS avg_price
FROM category_stats cs
JOIN categories c ON c.category_id = cs.category_id
ORDER BY cs.avg_price DESC;

-- ============================================================
-- CTE #3
-- ============================================================
WITH low_stock AS (
    SELECT product_id, quantity, reorder_level
    FROM inventory
    WHERE quantity <= reorder_level
)
SELECT
    p.name,
    s.name AS store_name,
    ls.quantity,
    ls.reorder_level
FROM low_stock ls
JOIN products p ON p.product_id = ls.product_id
JOIN stores s ON s.store_id = p.store_id
ORDER BY ls.quantity;

-- ============================================================
-- ROLLUP
-- ============================================================
SELECT
    s.name AS store_name,
    c.name AS category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.price_amount), 2) AS avg_price
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY ROLLUP (s.name, c.name)
ORDER BY s.name NULLS LAST, c.name NULLS LAST;

-- ============================================================
-- CUBE
-- ============================================================
SELECT
    s.name AS store_name,
    c.name AS category_name,
    COUNT(p.product_id) AS product_count
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY CUBE (s.name, c.name)
ORDER BY s.name NULLS LAST, c.name NULLS LAST;

-- ============================================================
-- EXPLAIN ANALYZE examples
-- ============================================================
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    s.name,
    p.name,
    c.name,
    i.quantity
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN categories c ON c.category_id = p.category_id
JOIN inventory i ON i.product_id = p.product_id
WHERE p.is_active = TRUE;
