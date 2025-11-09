# Database Index Performance Analysis

## Overview
This document analyzes the performance impact of adding indexes to the Airbnb database tables.

## Identified High-Usage Columns

### Users Table
- `email`: Used in login/authentication queries
- `created_at`: Used for sorting and filtering recent users

### Bookings Table
- `user_id`: Used in JOINs with users table
- `property_id`: Used in JOINs with properties table
- `checkin_date`, `checkout_date`: Used in date range queries and availability checks

### Properties Table
- `host_id`: Used in JOINs with users table (assuming host is a user)
- `price_per_night`: Used in filtering by price range
- `location`: Used in location-based searches

### Reviews Table
- `property_id`: Used in JOINs with properties table
- `user_id`: Used in JOINs with users table
- `rating`: Used in filtering by rating

## Created Indexes

See `database_index.sql` for the complete list of CREATE INDEX statements.

## Performance Measurement

### Before Adding Indexes
To measure performance before adding indexes, run EXPLAIN on key queries:

```sql
EXPLAIN SELECT * FROM bookings WHERE user_id = 1;
EXPLAIN SELECT * FROM properties WHERE location = 'New York';
EXPLAIN SELECT u.*, b.* FROM users u INNER JOIN bookings b ON u.id = b.user_id;
```

### After Adding Indexes
After creating the indexes, re-run the same EXPLAIN queries to compare execution plans and costs.

### Expected Performance Improvements
- Queries filtering by indexed columns should show reduced cost and faster execution
- JOIN operations on indexed foreign keys should be more efficient
- ORDER BY operations on indexed columns should be faster

## Monitoring and Maintenance
- Regularly analyze query performance using EXPLAIN
- Monitor index usage with database-specific tools
- Consider dropping unused indexes to reduce write overhead
- Rebuild indexes periodically for optimal performance