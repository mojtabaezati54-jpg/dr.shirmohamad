# Index Documentation — Team 2

| Index | Target query | Reason |
|---|---|---|
| `idx_products_store_id` | JOIN/filter by `products.store_id` | Speed up store-product joins |
| `idx_products_category_id` | JOIN/filter by `products.category_id` | Speed up category-product joins |
| `idx_products_active` | Filter active products | Support active-product filtering |
| `idx_inventory_product_id` | Join inventory to products | Support product-inventory join |
| `idx_products_category_active_price` | Category + active + price sort | Composite index for category product listing |
| `idx_products_store_active_price` | Store + active + price sort | Composite index for store product listing |

> Do not claim an index is beneficial without measuring the actual workload with `EXPLAIN ANALYZE`.
