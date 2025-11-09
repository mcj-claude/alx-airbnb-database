-- Create partitioned table for bookings based on checkin_date
-- Assuming PostgreSQL syntax for partitioning

-- First, create the partitioned table
CREATE TABLE bookings_partitioned (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (checkin_date);

-- Create partitions for different date ranges
CREATE TABLE bookings_2023_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE bookings_2023_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE bookings_2023_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE bookings_2023_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

CREATE TABLE bookings_2024_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE bookings_2024_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE bookings_2024_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE bookings_2024_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Create indexes on partitioned tables
CREATE INDEX idx_bookings_2023_q1_user_id ON bookings_2023_q1(user_id);
CREATE INDEX idx_bookings_2023_q1_property_id ON bookings_2023_q1(property_id);
CREATE INDEX idx_bookings_2023_q2_user_id ON bookings_2023_q2(user_id);
CREATE INDEX idx_bookings_2023_q2_property_id ON bookings_2023_q2(property_id);
-- Add similar indexes for other partitions...

-- Example query that benefits from partitioning
-- This will only scan the relevant partition(s)
SELECT * FROM bookings_partitioned
WHERE checkin_date BETWEEN '2023-06-01' AND '2023-08-31';

-- Query to get booking statistics by quarter
SELECT
    CASE
        WHEN checkin_date >= '2023-01-01' AND checkin_date < '2023-04-01' THEN '2023 Q1'
        WHEN checkin_date >= '2023-04-01' AND checkin_date < '2023-07-01' THEN '2023 Q2'
        WHEN checkin_date >= '2023-07-01' AND checkin_date < '2023-10-01' THEN '2023 Q3'
        WHEN checkin_date >= '2023-10-01' AND checkin_date < '2024-01-01' THEN '2023 Q4'
        ELSE 'Other'
    END AS quarter,
    COUNT(*) AS booking_count,
    SUM(total_price) AS total_revenue
FROM bookings_partitioned
WHERE checkin_date >= '2023-01-01' AND checkin_date < '2024-01-01'
GROUP BY
    CASE
        WHEN checkin_date >= '2023-01-01' AND checkin_date < '2023-04-01' THEN '2023 Q1'
        WHEN checkin_date >= '2023-04-01' AND checkin_date < '2023-07-01' THEN '2023 Q2'
        WHEN checkin_date >= '2023-07-01' AND checkin_date < '2023-10-01' THEN '2023 Q3'
        WHEN checkin_date >= '2023-10-01' AND checkin_date < '2024-01-01' THEN '2023 Q4'
        ELSE 'Other'
    END
ORDER BY quarter;