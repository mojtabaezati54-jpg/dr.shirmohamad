-- Session 2: analytical queries
-- Main required query: JOIN of at least 3 tables.

-- 1) Required 4-table JOIN: store + product + category + inventory
SELECT
    s.name AS store_name,
    p.name AS product_name,
    c.name AS category_name,
    p.currency_code,
    p.price_amount,
    p.exchange_rate_to_irr,
    ROUND(p.price_amount * p.exchange_rate_to_irr, 0) AS price_irr,
    i.quantity,
    i.reorder_level
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN categories c ON c.category_id = p.category_id
JOIN inventory i ON i.product_id = p.product_id
WHERE p.is_active = TRUE
ORDER BY s.name, c.name, p.name;

-- 2) Products needing replenishment
SELECT
    s.name AS store_name,
    p.name AS product_name,
    i.quantity,
    i.reorder_level
FROM inventory i
JOIN products p ON p.product_id = i.product_id
JOIN stores s ON s.store_id = p.store_id
WHERE i.quantity <= i.reorder_level
ORDER BY i.quantity ASC;

-- 3) Category summary
SELECT
    c.name AS category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.price_amount), 2) AS avg_price
FROM categories c
LEFT JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY product_count DESC, c.name;

-- 4) Store inventory value in IRR
SELECT
    s.name AS store_name,
    ROUND(SUM(i.quantity * p.price_amount * p.exchange_rate_to_irr), 0) AS inventory_value_irr
FROM stores s
JOIN products p ON p.store_id = s.store_id
JOIN inventory i ON i.product_id = p.product_id
GROUP BY s.store_id, s.name
ORDER BY inventory_value_irr DESC;
