# Database Advanced Script

This directory contains SQL queries and scripts demonstrating advanced database operations, including JOINs, subqueries, aggregations, window functions, and performance optimization through indexing.

## Files

- `joins_queries.sql`: Contains SQL queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
- `subqueries.sql`: Contains SQL queries using non-correlated and correlated subqueries.
- `aggregations_and_window_functions.sql`: Contains SQL queries using aggregation functions and window functions.
- `database_index.sql`: Contains CREATE INDEX statements for performance optimization.
- `index_performance.md`: Documentation on index performance analysis and monitoring.

## Queries

### JOINs
1. **INNER JOIN**: Retrieves all bookings and the respective users who made those bookings.
2. **LEFT JOIN**: Retrieves all properties and their reviews, including properties that have no reviews.
3. **FULL OUTER JOIN**: Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.

### Subqueries
1. **Non-correlated subquery**: Find all properties where the average rating is greater than 4.0.
2. **Correlated subquery**: Find users who have made more than 3 bookings.

### Aggregations and Window Functions
1. **Aggregation**: Find the total number of bookings made by each user using COUNT and GROUP BY.
2. **Window Functions**: Rank properties based on the total number of bookings using ROW_NUMBER and RANK.

### Performance Optimization
- **Indexing**: Strategic indexes on high-usage columns to improve query performance.
- **Performance Analysis**: Guidelines for measuring and monitoring query performance before and after indexing.