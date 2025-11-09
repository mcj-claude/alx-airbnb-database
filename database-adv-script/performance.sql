-- Initial complex query: Retrieve all bookings with user, property, and payment details
SELECT
    b.id AS booking_id,
    b.checkin_date,
    b.checkout_date,
    b.total_price,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.checkin_date DESC;

-- Optimized version: Select only necessary columns and use more efficient joins
SELECT
    b.id AS booking_id,
    b.checkin_date,
    b.checkout_date,
    b.total_price,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.payment_date
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.checkin_date >= '2023-01-01'
ORDER BY b.checkin_date DESC
LIMIT 100;