# Database Schema Script

## Overview
This directory contains the complete SQL schema definition for the Airbnb database, including table creation, constraints, indexes, triggers, and sample data.

## Files

- `schema.sql`: Complete database schema with all tables, constraints, indexes, triggers, and sample data

## Database Design

### Tables Created

1. **users**: User account information
2. **properties**: Property listings
3. **bookings**: Reservation records
4. **reviews**: User reviews and ratings
5. **payments**: Payment transaction records
6. **messages**: Communication between users

### Key Features

#### Data Integrity
- **Primary Keys**: Auto-incrementing IDs for all tables
- **Foreign Keys**: Proper referential integrity with CASCADE/SET NULL actions
- **Check Constraints**: Data validation (positive prices, valid ratings, date logic)
- **Unique Constraints**: Email uniqueness, transaction IDs, booking-review relationships

#### Performance Optimization
- **Indexes**: Strategic indexes on foreign keys and commonly queried columns
- **Composite Indexes**: Multi-column indexes for complex queries
- **Engine Selection**: InnoDB for transactional support and foreign keys

#### Business Logic
- **Triggers**: Automated timestamp updates and business rule enforcement
- **Views**: Pre-defined queries for common data access patterns
- **Enums**: Controlled vocabularies for status fields

## Installation

### Prerequisites
- MySQL 5.7+ or MariaDB 10.2+
- Database user with CREATE, ALTER, and INSERT privileges

### Setup Steps

1. **Create Database**
   ```sql
   CREATE DATABASE airbnb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   USE airbnb;
   ```

2. **Run Schema Script**
   ```bash
   mysql -u username -p airbnb < schema.sql
   ```

3. **Verify Installation**
   ```sql
   SHOW TABLES;
   DESCRIBE users;
   SELECT * FROM users;
   ```

## Schema Details

### Table Relationships

```
users (1) ──── (N) properties
  │                    │
  ├── (N) bookings ────┘
  │         │
  │         ├── (1) reviews
  │         └── (N) payments
  │
  └── (N) messages ────┐
           │           │
           └───────────┘
```

### Indexes Created

#### Single Column Indexes
- `users.email`
- `users.created_at`
- `properties.location`
- `properties.price_per_night`
- `bookings.checkin_date`
- `bookings.checkout_date`
- `reviews.rating`
- `payments.payment_date`

#### Composite Indexes
- `properties.location_price` (location, price_per_night)
- `bookings.user_checkin` (user_id, checkin_date)
- `bookings.property_dates` (property_id, checkin_date, checkout_date)
- `reviews.property_rating` (property_id, rating)

### Triggers Implemented

1. **Timestamp Updates**: Automatic `updated_at` field updates
2. **Booking Conflict Prevention**: Checks for overlapping bookings
3. **Review Validation**: Ensures reviews are only for completed bookings

### Views Created

1. **active_bookings**: Current and pending reservations with user/property details
2. **property_reviews**: Aggregated review statistics per property

## Sample Data

The schema includes sample data for testing:
- 3 users (John Doe, Jane Smith, Bob Johnson)
- 3 properties (Apartment, Beach House, Mountain Cabin)

## Usage Examples

### Basic Queries
```sql
-- Find available properties in New York
SELECT * FROM properties WHERE location LIKE '%New York%';

-- Get user's booking history
SELECT * FROM active_bookings WHERE user_id = 1;

-- Calculate property average ratings
SELECT * FROM property_reviews;
```

### Advanced Queries
```sql
-- Find top-rated properties
SELECT * FROM property_reviews
WHERE average_rating >= 4.0
ORDER BY average_rating DESC;

-- Get booking revenue by month
SELECT
    DATE_FORMAT(checkin_date, '%Y-%m') as month,
    SUM(total_price) as revenue
FROM bookings
WHERE status = 'completed'
GROUP BY month
ORDER BY month;
```

## Maintenance

### Regular Tasks
1. **Index Maintenance**: `ANALYZE TABLE` and `OPTIMIZE TABLE` monthly
2. **Backup**: Regular database backups
3. **Monitor Performance**: Use `EXPLAIN` on slow queries

### Scaling Considerations
- **Partitioning**: Consider partitioning large tables by date
- **Archiving**: Move old data to archive tables
- **Read Replicas**: For high-read applications

## Security Notes

- Passwords are stored as hashes (implement proper hashing in application)
- Sensitive data should be encrypted at rest
- Use parameterized queries to prevent SQL injection
- Implement proper access controls in application layer

## Troubleshooting

### Common Issues

1. **Foreign Key Errors**: Ensure parent records exist before inserting children
2. **Check Constraint Violations**: Validate data before insertion
3. **Index Performance**: Use `EXPLAIN` to analyze query execution plans

### Performance Tuning

1. **Slow Queries**: Add missing indexes based on `EXPLAIN` output
2. **Large Tables**: Consider partitioning or archiving old data
3. **Memory Issues**: Adjust InnoDB buffer pool size

## Contributing

When modifying the schema:
1. Update this README with changes
2. Test migrations on a copy of production data
3. Document any breaking changes
4. Update indexes if new query patterns are introduced