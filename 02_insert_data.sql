-- Sample data: 10 stores, 10 categories, 20 products, 20 inventory rows.
-- owner_user_id values assume corresponding users exist in the main DataPulse database.
-- If your team is running independently, keep these values as sample identifiers.

INSERT INTO stores (name, description, owner_user_id, status) VALUES
('Digikala Market', 'General online marketplace', 1, 'active'),
('TechZone', 'Computer and electronics', 2, 'active'),
('HomePlus', 'Home appliances', 3, 'active'),
('BookLand', 'Books and educational products', 4, 'active'),
('SportMax', 'Sports equipment', 5, 'active'),
('FashionHub', 'Clothing and accessories', 6, 'active'),
('BeautyCare', 'Beauty and personal care', 7, 'active'),
('AutoParts Pro', 'Automotive parts', 8, 'active'),
('GameCenter', 'Gaming products', 9, 'active'),
('OfficeLine', 'Office and stationery', 10, 'active');

INSERT INTO categories (name, description) VALUES
('Laptops', 'Laptop computers'),
('Mobile Phones', 'Smartphones and accessories'),
('Home Appliances', 'Appliances for home'),
('Books', 'Books and educational material'),
('Sports', 'Sports equipment'),
('Fashion', 'Clothing and accessories'),
('Beauty', 'Beauty and personal care'),
('Automotive', 'Automotive products'),
('Gaming', 'Gaming hardware and accessories'),
('Office', 'Office and stationery products');

INSERT INTO products
(store_id, category_id, name, description, price_amount, currency_code, exchange_rate_to_irr)
VALUES
(2, 1, 'Lenovo IdeaPad 5', '15-inch productivity laptop', 720, 'USD', 620000),
(2, 1, 'HP Pavilion 15', 'Mid-range laptop', 680, 'USD', 620000),
(2, 2, 'Samsung Galaxy A55', 'Android smartphone', 430, 'USD', 620000),
(1, 2, 'Xiaomi Redmi Note 14', 'Affordable smartphone', 310, 'USD', 620000),
(3, 3, 'Philips Air Fryer', 'Digital air fryer', 95, 'USD', 620000),
(3, 3, 'Bosch Blender', 'Kitchen blender', 80, 'USD', 620000),
(4, 4, 'Database Systems', 'Database textbook', 45, 'USD', 620000),
(4, 4, 'Clean Code', 'Programming book', 38, 'USD', 620000),
(5, 5, 'Nike Football', 'Professional football', 32, 'USD', 620000),
(5, 5, 'Yoga Mat', 'Non-slip exercise mat', 22, 'USD', 620000),
(6, 6, 'Classic T-Shirt', 'Cotton T-shirt', 18, 'USD', 620000),
(6, 6, 'Running Shoes', 'Lightweight running shoes', 75, 'USD', 620000),
(7, 7, 'Face Wash', 'Daily facial cleanser', 14, 'USD', 620000),
(7, 7, 'Skin Moisturizer', 'Hydrating moisturizer', 19, 'USD', 620000),
(8, 8, 'Brake Pad Set', 'Front brake pads', 55, 'USD', 620000),
(8, 8, 'Car Air Filter', 'Engine air filter', 16, 'USD', 620000),
(9, 9, 'Mechanical Keyboard', 'RGB mechanical keyboard', 65, 'USD', 620000),
(9, 9, 'Gaming Mouse', 'High precision mouse', 42, 'USD', 620000),
(10, 10, 'A4 Paper Pack', '500 sheets', 6, 'USD', 620000),
(10, 10, 'Office Notebook', 'Hardcover notebook', 5, 'USD', 620000);

INSERT INTO inventory (product_id, quantity, reorder_level) VALUES
(1, 12, 5),
(2, 18, 6),
(3, 25, 8),
(4, 30, 10),
(5, 14, 5),
(6, 20, 6),
(7, 40, 10),
(8, 35, 10),
(9, 22, 7),
(10, 50, 12),
(11, 60, 15),
(12, 16, 5),
(13, 45, 12),
(14, 32, 10),
(15, 10, 4),
(16, 28, 8),
(17, 24, 7),
(18, 36, 10),
(19, 100, 20),
(20, 80, 20);
