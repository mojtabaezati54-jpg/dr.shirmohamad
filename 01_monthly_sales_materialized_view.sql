-- Monthly sales materialized view.
--
-- Team 2 does not own orders/order_items, so the view consumes the
-- transaction tables from Team 3 when those tables exist in the shared
-- DataPulse database.
--
-- Expected columns from Team 3:
-- orders(order_id, created_at, status)
-- order_items(order_id, product_id, quantity, unit_price, discount)
--
-- If Team 3 has not created these tables yet, keep this script documented
-- in the repository and execute it after integration.

DROP MATERIALIZED VIEW IF EXISTS monthly_product_sales;

CREATE MATERIALIZED VIEW monthly_product_sales AS
SELECT
    date_trunc('month', o.created_at)::date AS sales_month,
    p.product_id,
    p.name AS product_name,
    s.store_id,
    s.name AS store_name,
    SUM(oi.quantity) AS units_sold,
    SUM((oi.quantity * oi.unit_price) - COALESCE(oi.discount, 0)) AS gross_sales
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN stores s ON s.store_id = p.store_id
WHERE o.status IN ('paid', 'completed', 'delivered')
GROUP BY
    date_trunc('month', o.created_at)::date,
    p.product_id,
    p.name,
    s.store_id,
    s.name;

CREATE INDEX IF NOT EXISTS idx_monthly_product_sales_month
ON monthly_product_sales(sales_month);

-- Test:
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM monthly_product_sales
WHERE sales_month = DATE '2026-08-01';

-- Refresh after source data changes:
-- REFRESH MATERIALIZED VIEW monthly_product_sales;
