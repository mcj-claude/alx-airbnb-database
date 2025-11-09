# Database Seed Script

## Overview
This directory contains comprehensive seed data for the Airbnb database, providing realistic sample data for development, testing, and demonstration purposes.

## Files

- `seed.sql`: Complete seed data script with sample users, properties, bookings, reviews, payments, and messages

## Sample Data Overview

### Users (20 total)
- **Diverse profiles**: Mix of hosts and guests from different backgrounds
- **Realistic details**: Names, emails, phone numbers, registration dates
- **Geographic spread**: Users from various locations (implied through property locations)

### Properties (16 total)
- **Variety of types**: Apartments, villas, cabins, lofts, houses, bungalows
- **Location diversity**: 10+ different cities across the US
- **Price range**: $150 - $500 per night
- **Amenity variations**: Different combinations of wifi, pools, fireplaces, etc.
- **Capacity range**: 2-8 guests, 1-4 bedrooms

### Bookings (32 total)
- **Status distribution**:
  - Completed: 20 bookings (past stays with reviews)
  - Confirmed: 8 bookings (upcoming confirmed reservations)
  - Pending: 4 bookings (awaiting confirmation)
- **Date range**: From January 2024 to June 2025
- **Guest counts**: 2-5 guests per booking
- **Price calculations**: Accurate total prices based on nightly rates and duration

### Reviews (20 total)
- **Rating distribution**: Mostly 4-5 stars (realistic positive bias)
- **Detailed comments**: Realistic guest feedback
- **Timely reviews**: Posted shortly after checkout
- **One review per completed booking**: Enforces business rules

### Payments (32 total)
- **Payment methods**: Credit cards, PayPal, debit cards
- **Status alignment**: Matches booking status
- **Transaction IDs**: Unique identifiers for each payment
- **Amount accuracy**: Matches booking totals

### Messages (15 total)
- **Realistic conversations**: Inquiries about amenities, check-in, recommendations
- **Host-guest communication**: Between property owners and renters
- **Read status**: Mix of read and unread messages
- **Booking context**: Most messages related to specific bookings

## Data Relationships

### User Activity Levels
- **High activity users**: Users with multiple bookings (e.g., user 10 has 4 bookings)
- **New users**: Recently registered with no booking history
- **Hosts**: Users who own properties (users 1-9 are hosts)

### Property Performance
- **Popular properties**: Properties with multiple bookings
- **New listings**: Recently added properties with no bookings yet
- **High-rated properties**: Properties with 4+ star average ratings

### Booking Patterns
- **Seasonal trends**: More bookings in summer months
- **Duration variety**: 3-7 night stays
- **Group sizes**: Mix of couples, families, and small groups

## Usage Scenarios

### Development Testing
```sql
-- Test user registration flow
SELECT * FROM users WHERE created_at >= '2024-01-01';

-- Test booking search
SELECT * FROM active_bookings WHERE checkin_date >= CURDATE();

-- Test review system
SELECT * FROM property_reviews WHERE average_rating >= 4.0;
```

### Performance Testing
```sql
-- Test complex joins
SELECT b.*, u.first_name, u.last_name, p.name, p.location
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.status = 'completed';

-- Test aggregation queries
SELECT
    DATE_FORMAT(b.checkin_date, '%Y-%m') as month,
    COUNT(*) as bookings,
    SUM(b.total_price) as revenue
FROM bookings b
WHERE b.status = 'completed'
GROUP BY month
ORDER BY month;
```

### Business Intelligence
```sql
-- Revenue analysis
SELECT
    p.location,
    COUNT(b.id) as total_bookings,
    SUM(b.total_price) as total_revenue,
    AVG(b.total_price) as avg_booking_value
FROM properties p
LEFT JOIN bookings b ON p.id = b.property_id
WHERE b.status = 'completed'
GROUP BY p.location
ORDER BY total_revenue DESC;

-- User engagement metrics
SELECT
    u.id,
    CONCAT(u.first_name, ' ', u.last_name) as user_name,
    COUNT(DISTINCT b.id) as total_bookings,
    COUNT(DISTINCT p.id) as unique_properties,
    SUM(b.total_price) as total_spent,
    AVG(r.rating) as avg_rating_given
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
LEFT JOIN reviews r ON u.id = r.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_spent DESC;
```

## Data Integrity Verification

The seed data includes verification queries at the end to ensure all records were inserted correctly:

```sql
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
```

Expected results:
- Users: 20
- Properties: 16
- Bookings: 32
- Reviews: 20
- Payments: 32
- Messages: 15

## Installation

### Prerequisites
- Airbnb database schema already created (from `database-script-0x01/schema.sql`)
- MySQL/MariaDB user with INSERT privileges

### Setup Steps

1. **Connect to database**
   ```bash
   mysql -u username -p airbnb
   ```

2. **Run seed script**
   ```bash
   mysql -u username -p airbnb < seed.sql
   ```

3. **Verify installation**
   ```sql
   USE airbnb;
   SHOW TABLES;
   SELECT COUNT(*) FROM users;
   SELECT COUNT(*) FROM bookings WHERE status = 'completed';
   ```

## Maintenance

### Adding More Data
When adding additional seed data:
1. Maintain referential integrity
2. Use consistent date ranges
3. Follow existing naming conventions
4. Update this README with new data counts

### Data Refresh
To reset and reseed the database:
```sql
-- WARNING: This will delete all data
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE messages;
TRUNCATE TABLE payments;
TRUNCATE TABLE reviews;
TRUNCATE TABLE bookings;
TRUNCATE TABLE properties;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- Then re-run seed.sql
SOURCE seed.sql;
```

## Edge Cases Covered

### Business Logic Testing
- **Booking conflicts**: Overlapping dates prevented by triggers
- **Review timing**: Reviews only allowed for completed bookings
- **Payment status**: Aligns with booking status

### Data Variety
- **Empty states**: Properties with no bookings, users with no reviews
- **Status diversity**: Mix of pending, confirmed, completed, cancelled bookings
- **Payment methods**: Various payment types and statuses

### Performance Scenarios
- **Large result sets**: Multiple bookings per user/property
- **Complex joins**: Multi-table queries for dashboard views
- **Index usage**: Queries designed to utilize created indexes

## Contributing

When modifying seed data:
1. Maintain data consistency and relationships
2. Update counts in this README
3. Test all foreign key constraints
4. Ensure realistic and diverse data distribution
5. Document any new business rules or edge cases