-- Index homework.
-- Run the marked queries BEFORE creating the extra indexes.
-- Record EXPLAIN ANALYZE results in reports/execution_times.md.
--
-- Existing FK indexes are already created in 01_create_tables.sql.
-- These benchmark indexes target common filtering/sorting patterns.

-- BEFORE:
EXPLAIN (ANALYZE, BUFFERS)
SELECT p.product_id, p.name, p.price_amount
FROM products p
WHERE p.category_id = 1
  AND p.is_active = TRUE
ORDER BY p.price_amount DESC;

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.product_id, p.name, p.price_amount
FROM products p
WHERE p.store_id = 2
  AND p.is_active = TRUE
ORDER BY p.price_amount DESC;

-- Create indexes:
CREATE INDEX IF NOT EXISTS idx_products_category_active_price
ON products(category_id, is_active, price_amount DESC);

CREATE INDEX IF NOT EXISTS idx_products_store_active_price
ON products(store_id, is_active, price_amount DESC);

-- AFTER:
EXPLAIN (ANALYZE, BUFFERS)
SELECT p.product_id, p.name, p.price_amount
FROM products p
WHERE p.category_id = 1
  AND p.is_active = TRUE
ORDER BY p.price_amount DESC;

EXPLAIN (ANALYZE, BUFFERS)
SELECT p.product_id, p.name, p.price_amount
FROM products p
WHERE p.store_id = 2
  AND p.is_active = TRUE
ORDER BY p.price_amount DESC;

-- Update planner statistics after major data/index changes:
ANALYZE products;
ANALYZE inventory;
