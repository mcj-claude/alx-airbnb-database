-- Airbnb Database Schema
-- This script creates all tables, constraints, and indexes for the Airbnb database

-- Enable foreign key constraints
SET FOREIGN_KEY_CHECKS = 1;

-- Create Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_users_email (email),
    INDEX idx_users_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Properties table
CREATE TABLE properties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    host_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL CHECK (price_per_night > 0),
    max_guests INT NOT NULL CHECK (max_guests > 0),
    bedrooms INT CHECK (bedrooms >= 0),
    bathrooms INT CHECK (bathrooms >= 0),
    amenities JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_properties_host_id (host_id),
    INDEX idx_properties_location (location),
    INDEX idx_properties_price_per_night (price_per_night),
    INDEX idx_properties_location_price (location, price_per_night)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Bookings table
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    guests_count INT NOT NULL CHECK (guests_count > 0),
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    CHECK (checkout_date > checkin_date),
    INDEX idx_bookings_user_id (user_id),
    INDEX idx_bookings_property_id (property_id),
    INDEX idx_bookings_checkin_date (checkin_date),
    INDEX idx_bookings_checkout_date (checkout_date),
    INDEX idx_bookings_status (status),
    INDEX idx_bookings_user_checkin (user_id, checkin_date),
    INDEX idx_bookings_property_dates (property_id, checkin_date, checkout_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Reviews table
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    booking_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    UNIQUE KEY unique_booking_review (booking_id),
    INDEX idx_reviews_user_id (user_id),
    INDEX idx_reviews_property_id (property_id),
    INDEX idx_reviews_rating (rating),
    INDEX idx_reviews_property_rating (property_id, rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Payments table
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer') NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    transaction_id VARCHAR(100) UNIQUE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    INDEX idx_payments_booking_id (booking_id),
    INDEX idx_payments_status (status),
    INDEX idx_payments_date (payment_date),
    INDEX idx_payments_transaction (transaction_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Messages table
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    booking_id INT,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE SET NULL,
    CHECK (sender_id != receiver_id),
    INDEX idx_messages_sender_id (sender_id),
    INDEX idx_messages_receiver_id (receiver_id),
    INDEX idx_messages_booking_id (booking_id),
    INDEX idx_messages_sent_at (sent_at),
    INDEX idx_messages_is_read (is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create computed columns for performance (if supported)
-- Note: These would be added as generated columns in MySQL 5.7+ or MariaDB 10.2+
-- ALTER TABLE properties ADD COLUMN average_rating DECIMAL(3,2) GENERATED ALWAYS AS (
--     (SELECT COALESCE(AVG(rating), 0) FROM reviews WHERE property_id = properties.id)
-- ) STORED;

-- Create triggers for data consistency
DELIMITER //

-- Trigger to update updated_at timestamp
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

CREATE TRIGGER update_properties_updated_at
    BEFORE UPDATE ON properties
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

CREATE TRIGGER update_bookings_updated_at
    BEFORE UPDATE ON bookings
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

-- Trigger to prevent booking conflicts
CREATE TRIGGER check_booking_conflict
    BEFORE INSERT ON bookings
    FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM bookings
        WHERE property_id = NEW.property_id
        AND status IN ('confirmed', 'completed')
        AND (
            (NEW.checkin_date BETWEEN checkin_date AND DATE_SUB(checkout_date, INTERVAL 1 DAY))
            OR (NEW.checkout_date BETWEEN DATE_ADD(checkin_date, INTERVAL 1 DAY) AND checkout_date)
            OR (checkin_date BETWEEN NEW.checkin_date AND DATE_SUB(NEW.checkout_date, INTERVAL 1 DAY))
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Booking conflict: Property is already booked for these dates';
    END IF;
END //

-- Trigger to validate review after booking completion
CREATE TRIGGER validate_review_timing
    BEFORE INSERT ON reviews
    FOR EACH ROW
BEGIN
    DECLARE booking_status ENUM('pending', 'confirmed', 'cancelled', 'completed');
    SELECT status INTO booking_status FROM bookings WHERE id = NEW.booking_id;
    IF booking_status != 'completed' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reviews can only be added for completed bookings';
    END IF;
END //

DELIMITER ;

-- Create views for common queries
CREATE VIEW active_bookings AS
SELECT
    b.id,
    b.checkin_date,
    b.checkout_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.status IN ('confirmed', 'pending');

CREATE VIEW property_reviews AS
SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(r.id) AS review_count,
    COALESCE(AVG(r.rating), 0) AS average_rating
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
GROUP BY p.id, p.name;

-- Grant permissions (adjust as needed for your setup)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON airbnb.* TO 'app_user'@'localhost' IDENTIFIED BY 'password';
-- GRANT ALL PRIVILEGES ON airbnb.* TO 'admin'@'localhost' IDENTIFIED BY 'admin_password';

-- Insert sample data for testing
INSERT INTO users (first_name, last_name, email, password_hash, phone) VALUES
('John', 'Doe', 'john.doe@email.com', 'hashed_password_1', '+1234567890'),
('Jane', 'Smith', 'jane.smith@email.com', 'hashed_password_2', '+1234567891'),
('Bob', 'Johnson', 'bob.johnson@email.com', 'hashed_password_3', '+1234567892');

INSERT INTO properties (host_id, name, description, location, price_per_night, max_guests, bedrooms, bathrooms, amenities) VALUES
(1, 'Cozy Apartment', 'A beautiful apartment in the city center', 'New York, NY', 150.00, 4, 2, 1, '["wifi", "kitchen", "air_conditioning"]'),
(2, 'Beach House', 'Stunning beachfront property', 'Miami, FL', 300.00, 6, 3, 2, '["wifi", "pool", "ocean_view"]'),
(1, 'Mountain Cabin', 'Peaceful cabin in the mountains', 'Aspen, CO', 200.00, 4, 2, 1, '["fireplace", "hiking_trails", "wifi"]');