-- Airbnb Database Seed Data
-- This script populates the database with realistic sample data for testing and development

USE airbnb;

-- Disable foreign key checks for bulk insert
SET FOREIGN_KEY_CHECKS = 0;

-- Insert Users (20 users: mix of hosts and guests)
INSERT INTO users (first_name, last_name, email, password_hash, phone, created_at) VALUES
('John', 'Doe', 'john.doe@email.com', '$2b$10$hashed_password_1', '+1-555-0101', '2023-01-15 10:00:00'),
('Jane', 'Smith', 'jane.smith@email.com', '$2b$10$hashed_password_2', '+1-555-0102', '2023-02-20 14:30:00'),
('Bob', 'Johnson', 'bob.johnson@email.com', '$2b$10$hashed_password_3', '+1-555-0103', '2023-03-10 09:15:00'),
('Alice', 'Williams', 'alice.williams@email.com', '$2b$10$hashed_password_4', '+1-555-0104', '2023-04-05 16:45:00'),
('Charlie', 'Brown', 'charlie.brown@email.com', '$2b$10$hashed_password_5', '+1-555-0105', '2023-05-12 11:20:00'),
('Diana', 'Davis', 'diana.davis@email.com', '$2b$10$hashed_password_6', '+1-555-0106', '2023-06-18 13:10:00'),
('Edward', 'Miller', 'edward.miller@email.com', '$2b$10$hashed_password_7', '+1-555-0107', '2023-07-22 15:30:00'),
('Fiona', 'Wilson', 'fiona.wilson@email.com', '$2b$10$hashed_password_8', '+1-555-0108', '2023-08-08 12:00:00'),
('George', 'Moore', 'george.moore@email.com', '$2b$10$hashed_password_9', '+1-555-0109', '2023-09-14 10:45:00'),
('Helen', 'Taylor', 'helen.taylor@email.com', '$2b$10$hashed_password_10', '+1-555-0110', '2023-10-01 14:20:00'),
('Ian', 'Anderson', 'ian.anderson@email.com', '$2b$10$hashed_password_11', '+1-555-0111', '2023-10-15 09:30:00'),
('Julia', 'Thomas', 'julia.thomas@email.com', '$2b$10$hashed_password_12', '+1-555-0112', '2023-11-02 16:15:00'),
('Kevin', 'Jackson', 'kevin.jackson@email.com', '$2b$10$hashed_password_13', '+1-555-0113', '2023-11-20 11:45:00'),
('Laura', 'White', 'laura.white@email.com', '$2b$10$hashed_password_14', '+1-555-0114', '2023-12-05 13:30:00'),
('Michael', 'Harris', 'michael.harris@email.com', '$2b$10$hashed_password_15', '+1-555-0115', '2023-12-18 15:00:00'),
('Nancy', 'Martin', 'nancy.martin@email.com', '$2b$10$hashed_password_16', '+1-555-0116', '2024-01-10 10:30:00'),
('Oliver', 'Thompson', 'oliver.thompson@email.com', '$2b$10$hashed_password_17', '+1-555-0117', '2024-02-14 14:45:00'),
('Paula', 'Garcia', 'paula.garcia@email.com', '$2b$10$hashed_password_18', '+1-555-0118', '2024-03-01 12:15:00'),
('Quinn', 'Martinez', 'quinn.martinez@email.com', '$2b$10$hashed_password_19', '+1-555-0119', '2024-03-15 09:00:00'),
('Rachel', 'Robinson', 'rachel.robinson@email.com', '$2b$10$hashed_password_20', '+1-555-0120', '2024-04-01 16:30:00');

-- Insert Properties (15 properties across different locations and hosts)
INSERT INTO properties (host_id, name, description, location, price_per_night, max_guests, bedrooms, bathrooms, amenities, created_at) VALUES
(1, 'Cozy Downtown Apartment', 'Modern apartment in the heart of downtown with city views', 'New York, NY', 150.00, 4, 2, 1, '["wifi", "kitchen", "air_conditioning", "gym_access"]', '2023-01-20 10:00:00'),
(2, 'Beachfront Villa', 'Luxurious villa with private beach access and infinity pool', 'Miami, FL', 450.00, 8, 4, 3, '["wifi", "pool", "ocean_view", "kitchen", "parking", "balcony"]', '2023-02-25 14:00:00'),
(1, 'Mountain Cabin Retreat', 'Rustic cabin in the mountains with fireplace and hiking trails', 'Aspen, CO', 220.00, 6, 3, 2, '["fireplace", "hiking_trails", "wifi", "kitchen", "parking"]', '2023-03-15 11:30:00'),
(3, 'Urban Loft', 'Industrial-style loft in trendy neighborhood with rooftop access', 'Austin, TX', 180.00, 4, 1, 1, '["wifi", "kitchen", "rooftop_access", "parking"]', '2023-04-10 16:00:00'),
(4, 'Lake House', 'Charming house by the lake with boat dock and fishing gear', 'Lake Tahoe, CA', 300.00, 6, 3, 2, '["lake_access", "boat_dock", "fishing_gear", "fireplace", "wifi", "kitchen"]', '2023-05-05 13:15:00'),
(2, 'Desert Oasis', 'Adobe-style home with desert landscaping and stargazing deck', 'Sedona, AZ', 190.00, 4, 2, 2, '["desert_views", "stargazing", "fireplace", "wifi", "kitchen", "parking"]', '2023-06-01 09:45:00'),
(5, 'Historic Brownstone', 'Beautifully restored 19th-century brownstone in historic district', 'Boston, MA', 280.00, 6, 3, 2, '["historic", "fireplace", "wifi", "kitchen", "parking", "garden"]', '2023-06-20 15:30:00'),
(3, 'Tropical Bungalow', 'Colorful bungalow with tropical garden and hammocks', 'Honolulu, HI', 250.00, 4, 2, 1, '["tropical_garden", "hammocks", "wifi", "kitchen", "ocean_breeze"]', '2023-07-10 12:00:00'),
(6, 'Ski Chalet', 'Cozy chalet near ski slopes with hot tub and game room', 'Vail, CO', 350.00, 8, 4, 3, '["ski_access", "hot_tub", "game_room", "fireplace", "wifi", "kitchen"]', '2023-08-15 10:30:00'),
(4, 'Vineyard Cottage', 'Quaint cottage on a working vineyard with wine tasting', 'Napa Valley, CA', 320.00, 4, 2, 1, '["wine_tasting", "vineyard_views", "fireplace", "wifi", "kitchen"]', '2023-09-01 14:20:00'),
(7, 'City Penthouse', 'Luxury penthouse with panoramic city views and private terrace', 'Chicago, IL', 400.00, 4, 2, 2, '["city_views", "private_terrace", "wifi", "kitchen", "concierge", "parking"]', '2023-09-20 11:45:00'),
(5, 'Forest Cabin', 'Secluded cabin in the forest with wildlife viewing and hiking', 'Portland, OR', 160.00, 4, 2, 1, '["forest_views", "hiking_trails", "wildlife", "fireplace", "wifi", "kitchen"]', '2023-10-05 16:10:00'),
(8, 'Island Resort', 'Overwater bungalow with crystal clear waters and marine life', 'Maui, HI', 500.00, 2, 1, 1, '["overwater", "marine_life", "snorkeling", "wifi", "kitchen"]', '2023-10-25 13:30:00'),
(6, 'Ranch House', 'Spacious ranch house with horse stables and riding trails', 'Jackson, WY', 290.00, 8, 4, 3, '["horse_stables", "riding_trails", "fireplace", "wifi", "kitchen", "parking"]', '2023-11-10 09:15:00'),
(9, 'Art Deco Apartment', 'Stunning art deco apartment in cultural district', 'Los Angeles, CA', 240.00, 4, 2, 1, '["art_deco", "cultural_district", "wifi", "kitchen", "parking", "rooftop"]', '2023-12-01 15:45:00');

-- Insert Bookings (30 bookings with various statuses and dates)
INSERT INTO bookings (user_id, property_id, checkin_date, checkout_date, total_price, guests_count, status, created_at) VALUES
(10, 1, '2024-01-15', '2024-01-20', 750.00, 2, 'completed', '2023-12-15 10:00:00'),
(11, 2, '2024-02-01', '2024-02-08', 3150.00, 4, 'completed', '2023-12-20 14:30:00'),
(12, 3, '2024-03-10', '2024-03-15', 1100.00, 3, 'completed', '2024-01-10 09:15:00'),
(13, 4, '2024-04-05', '2024-04-10', 900.00, 2, 'completed', '2024-02-05 16:45:00'),
(14, 5, '2024-05-20', '2024-05-27', 2100.00, 4, 'completed', '2024-03-20 11:20:00'),
(15, 6, '2024-06-15', '2024-06-20', 950.00, 2, 'completed', '2024-04-15 13:10:00'),
(16, 7, '2024-07-01', '2024-07-08', 1960.00, 3, 'completed', '2024-05-01 15:30:00'),
(17, 8, '2024-08-10', '2024-08-15', 1250.00, 2, 'completed', '2024-06-10 12:00:00'),
(18, 9, '2024-09-05', '2024-09-12', 2450.00, 5, 'completed', '2024-07-05 10:45:00'),
(19, 10, '2024-10-01', '2024-10-06', 1600.00, 2, 'completed', '2024-08-01 14:20:00'),
(10, 11, '2024-11-15', '2024-11-20', 2000.00, 2, 'confirmed', '2024-09-15 09:30:00'),
(11, 12, '2024-12-20', '2024-12-27', 1120.00, 3, 'confirmed', '2024-10-20 16:15:00'),
(12, 13, '2025-01-05', '2025-01-10', 2500.00, 2, 'pending', '2024-11-05 11:45:00'),
(13, 14, '2025-02-14', '2025-02-21', 2030.00, 4, 'pending', '2024-12-14 13:30:00'),
(14, 15, '2025-03-01', '2025-03-06', 1200.00, 2, 'pending', '2025-01-01 15:00:00'),
(15, 1, '2024-12-15', '2024-12-20', 750.00, 2, 'confirmed', '2024-10-15 10:30:00'),
(16, 3, '2025-01-20', '2025-01-25', 1100.00, 3, 'pending', '2024-11-20 14:45:00'),
(17, 5, '2024-11-25', '2024-12-02', 2100.00, 4, 'confirmed', '2024-09-25 12:15:00'),
(18, 7, '2025-02-01', '2025-02-08', 1960.00, 3, 'pending', '2024-12-01 09:00:00'),
(19, 9, '2024-12-10', '2024-12-17', 2450.00, 5, 'confirmed', '2024-10-10 16:30:00'),
(10, 2, '2025-03-15', '2025-03-22', 3150.00, 4, 'pending', '2025-01-15 10:00:00'),
(11, 4, '2024-12-01', '2024-12-06', 900.00, 2, 'confirmed', '2024-10-01 14:30:00'),
(12, 6, '2025-04-01', '2025-04-06', 950.00, 2, 'pending', '2025-02-01 09:15:00'),
(13, 8, '2024-11-20', '2024-11-25', 1250.00, 2, 'cancelled', '2024-09-20 16:45:00'),
(14, 10, '2025-01-15', '2025-01-20', 1600.00, 2, 'confirmed', '2024-11-15 11:20:00'),
(15, 12, '2024-12-25', '2025-01-01', 1120.00, 3, 'confirmed', '2024-10-25 13:10:00'),
(16, 14, '2025-03-10', '2025-03-17', 2030.00, 4, 'pending', '2025-01-10 15:30:00'),
(17, 1, '2025-02-20', '2025-02-25', 750.00, 2, 'pending', '2024-12-20 12:00:00'),
(18, 3, '2024-12-05', '2024-12-10', 1100.00, 3, 'cancelled', '2024-10-05 10:45:00'),
(19, 5, '2025-04-10', '2025-04-17', 2100.00, 4, 'pending', '2025-02-10 14:20:00');

-- Insert Reviews (20 reviews for completed bookings)
INSERT INTO reviews (user_id, property_id, booking_id, rating, comment, created_at) VALUES
(10, 1, 1, 5, 'Amazing location and very clean apartment. John was a great host!', '2024-01-21 10:00:00'),
(11, 2, 2, 4, 'Beautiful beachfront property with stunning views. Highly recommended!', '2024-02-09 14:00:00'),
(12, 3, 3, 5, 'Perfect mountain retreat. Cozy cabin with everything we needed.', '2024-03-16 11:00:00'),
(13, 4, 4, 4, 'Great urban loft in a trendy neighborhood. Very comfortable stay.', '2024-04-11 16:00:00'),
(14, 5, 5, 5, 'Incredible lake house with amazing amenities. Will definitely return!', '2024-05-28 13:00:00'),
(15, 6, 6, 4, 'Peaceful desert retreat with beautiful views. Very relaxing.', '2024-06-21 09:00:00'),
(16, 7, 7, 5, 'Historic brownstone that exceeded our expectations. Perfect location.', '2024-07-09 15:00:00'),
(17, 8, 8, 4, 'Charming tropical bungalow with great ocean breezes. Loved it!', '2024-08-16 12:00:00'),
(18, 9, 9, 5, 'Fantastic ski chalet with everything you need for a winter getaway.', '2024-09-13 10:00:00'),
(19, 10, 10, 4, 'Beautiful vineyard cottage with excellent wine selection. Romantic getaway.', '2024-10-07 14:00:00'),
(10, 1, 16, 5, 'Second stay at this wonderful apartment. Always consistent quality.', '2024-12-21 10:00:00'),
(17, 5, 17, 4, 'Great lake house for our family vacation. Kids loved the boat dock.', '2024-12-03 13:00:00'),
(19, 9, 19, 5, 'Outstanding chalet with hot tub and game room. Perfect for families.', '2024-12-18 10:00:00'),
(11, 4, 21, 4, 'Nice urban loft with good amenities. Convenient location.', '2024-12-07 16:00:00'),
(14, 10, 24, 5, 'Stunning vineyard property with incredible views and wine tasting.', '2025-01-21 14:00:00'),
(15, 12, 25, 4, 'Cozy forest cabin with beautiful surroundings. Very peaceful.', '2025-01-02 13:00:00'),
(10, 11, 1, 4, 'Modern apartment with great city views. Comfortable and clean.', '2024-01-21 10:00:00'),
(11, 2, 2, 5, 'Luxury beachfront villa that exceeded all expectations. Worth every penny!', '2024-02-09 14:00:00'),
(12, 3, 3, 4, 'Excellent mountain cabin with working fireplace. Perfect winter getaway.', '2024-03-16 11:00:00'),
(13, 4, 4, 5, 'Trendy loft with rooftop access. Loved the industrial vibe and location.', '2024-04-11 16:00:00');

-- Insert Payments (30 payments corresponding to bookings)
INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id, payment_date) VALUES
(1, 750.00, 'credit_card', 'completed', 'txn_001_20240115', '2024-01-15 10:00:00'),
(2, 3150.00, 'paypal', 'completed', 'txn_002_20240201', '2024-02-01 14:00:00'),
(3, 1100.00, 'credit_card', 'completed', 'txn_003_20240310', '2024-03-10 11:00:00'),
(4, 900.00, 'debit_card', 'completed', 'txn_004_20240405', '2024-04-05 16:00:00'),
(5, 2100.00, 'credit_card', 'completed', 'txn_005_20240520', '2024-05-20 13:00:00'),
(6, 950.00, 'paypal', 'completed', 'txn_006_20240615', '2024-06-15 09:00:00'),
(7, 1960.00, 'credit_card', 'completed', 'txn_007_20240701', '2024-07-01 15:00:00'),
(8, 1250.00, 'credit_card', 'completed', 'txn_008_20240810', '2024-08-10 12:00:00'),
(9, 2450.00, 'paypal', 'completed', 'txn_009_20240905', '2024-09-05 10:00:00'),
(10, 1600.00, 'credit_card', 'completed', 'txn_010_20241001', '2024-10-01 14:00:00'),
(11, 2000.00, 'credit_card', 'pending', 'txn_011_20241115', '2024-11-15 09:00:00'),
(12, 1120.00, 'paypal', 'pending', 'txn_012_20241220', '2024-12-20 16:00:00'),
(13, 2500.00, 'credit_card', 'pending', 'txn_013_20250105', '2025-01-05 11:00:00'),
(14, 2030.00, 'debit_card', 'pending', 'txn_014_20250214', '2025-02-14 13:00:00'),
(15, 1200.00, 'credit_card', 'pending', 'txn_015_20250301', '2025-03-01 15:00:00'),
(16, 750.00, 'credit_card', 'completed', 'txn_016_20241215', '2024-12-15 10:00:00'),
(17, 2100.00, 'paypal', 'completed', 'txn_017_20241125', '2024-11-25 12:00:00'),
(18, 2450.00, 'credit_card', 'pending', 'txn_018_20241210', '2024-12-10 09:00:00'),
(19, 900.00, 'credit_card', 'completed', 'txn_019_20241201', '2024-12-01 14:00:00'),
(20, 1600.00, 'paypal', 'completed', 'txn_020_20250115', '2025-01-15 14:00:00'),
(21, 3150.00, 'credit_card', 'pending', 'txn_021_20250315', '2025-03-15 10:00:00'),
(22, 950.00, 'debit_card', 'pending', 'txn_022_20250401', '2025-04-01 09:00:00'),
(23, 1250.00, 'credit_card', 'refunded', 'txn_023_20241120', '2024-11-20 16:00:00'),
(24, 1120.00, 'paypal', 'completed', 'txn_024_20241225', '2024-12-25 13:00:00'),
(25, 2030.00, 'credit_card', 'pending', 'txn_025_20250310', '2025-03-10 15:00:00'),
(26, 750.00, 'credit_card', 'pending', 'txn_026_20250220', '2025-02-20 12:00:00'),
(27, 1100.00, 'paypal', 'refunded', 'txn_027_20241205', '2024-12-05 10:00:00'),
(28, 2100.00, 'credit_card', 'pending', 'txn_028_20250410', '2025-04-10 14:00:00'),
(29, 750.00, 'credit_card', 'completed', 'txn_029_20240115', '2024-01-15 10:00:00'),
(30, 3150.00, 'paypal', 'completed', 'txn_030_20240201', '2024-02-01 14:00:00');

-- Insert Messages (15 sample messages between users)
INSERT INTO messages (sender_id, receiver_id, booking_id, message, sent_at, is_read) VALUES
(10, 1, 1, 'Hi John, we are excited for our stay! Do you have any recommendations for restaurants nearby?', '2024-01-10 14:00:00', true),
(1, 10, 1, 'Hello! There are several great restaurants within walking distance. I recommend trying the Italian place on 5th street.', '2024-01-10 15:30:00', true),
(11, 2, 2, 'The villa looks amazing! Is the pool heated?', '2024-01-25 10:00:00', true),
(2, 11, 2, 'Yes, the pool is heated year-round. You will find it very comfortable!', '2024-01-25 11:15:00', true),
(12, 1, 3, 'Can we check-in early if possible? Our flight arrives at 2 PM.', '2024-03-05 16:00:00', true),
(1, 12, 3, 'I can arrange early check-in for you. Please let me know your flight details.', '2024-03-05 17:45:00', true),
(13, 3, 4, 'Is parking included with the loft?', '2024-04-01 12:00:00', true),
(3, 13, 4, 'Yes, there is one assigned parking space included in your booking.', '2024-04-01 13:20:00', false),
(14, 4, 5, 'Do you provide fishing gear or should we bring our own?', '2024-05-15 09:00:00', true),
(4, 14, 5, 'I provide basic fishing gear for guests. Let me know if you need anything specific.', '2024-05-15 10:30:00', true),
(15, 2, 6, 'Are there any beach activities you recommend?', '2024-06-10 14:00:00', false),
(16, 5, 7, 'The brownstone is beautiful! Can we have a late checkout?', '2024-06-28 11:00:00', true),
(5, 16, 7, 'I can arrange late checkout until 2 PM if that works for you.', '2024-06-28 12:15:00', false),
(17, 3, 8, 'Is the tropical garden maintained regularly?', '2024-08-05 15:00:00', true),
(3, 17, 8, 'Yes, the garden is maintained daily. You will find it beautiful and relaxing.', '2024-08-05 16:45:00', false);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Create some additional test data for edge cases

-- Add a user with multiple bookings
INSERT INTO bookings (user_id, property_id, checkin_date, checkout_date, total_price, guests_count, status, created_at) VALUES
(10, 3, '2025-05-01', '2025-05-06', 1100.00, 2, 'pending', '2025-03-01 10:00:00'),
(10, 5, '2025-06-15', '2025-06-22', 2100.00, 3, 'pending', '2025-04-15 14:00:00');

-- Add payments for the additional bookings
INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id, payment_date) VALUES
(31, 1100.00, 'credit_card', 'pending', 'txn_031_20250501', '2025-05-01 10:00:00'),
(32, 2100.00, 'paypal', 'pending', 'txn_032_20250615', '2025-06-15 14:00:00');

-- Add a property with no bookings yet
INSERT INTO properties (host_id, name, description, location, price_per_night, max_guests, bedrooms, bathrooms, amenities, created_at) VALUES
(20, 'Luxury Treehouse', 'Unique treehouse retreat with modern amenities and forest views', 'Seattle, WA', 275.00, 2, 1, 1, '["treehouse", "forest_views", "modern_amenities", "wifi", "kitchen"]', '2024-12-01 10:00:00');

-- Verify data integrity with some test queries
SELECT 'Users count:' as info, COUNT(*) as count FROM users
UNION ALL
SELECT 'Properties count:', COUNT(*) FROM properties
UNION ALL
SELECT 'Bookings count:', COUNT(*) FROM bookings
UNION ALL
SELECT 'Reviews count:', COUNT(*) FROM reviews
UNION ALL
SELECT 'Payments count:', COUNT(*) FROM payments
UNION ALL
SELECT 'Messages count:', COUNT(*) FROM messages;