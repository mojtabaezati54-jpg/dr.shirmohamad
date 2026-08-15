-- Quick verification script

SELECT 'stores' AS table_name, COUNT(*) AS row_count FROM stores
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory;

SELECT
    COUNT(*) AS products_without_inventory
FROM products p
LEFT JOIN inventory i ON i.product_id = p.product_id
WHERE i.product_id IS NULL;

SELECT
    COUNT(*) AS invalid_prices
FROM products
WHERE price_amount < 0 OR exchange_rate_to_irr <= 0;

SELECT
    COUNT(*) AS invalid_stock
FROM inventory
WHERE quantity < 0 OR reorder_level < 0;
