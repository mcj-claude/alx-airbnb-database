-- Aggregation: Find the total number of bookings made by each user
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id
ORDER BY total_bookings DESC;

-- Window function: Rank properties based on the total number of bookings they have received
SELECT property_id, COUNT(*) AS total_bookings,
       ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_number_rank,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;