# Database Advanced Script

This directory contains SQL queries demonstrating advanced database operations, including JOINs and subqueries.

## Files

- `joins_queries.sql`: Contains SQL queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
- `subqueries.sql`: Contains SQL queries using non-correlated and correlated subqueries.

## Queries

### JOINs
1. **INNER JOIN**: Retrieves all bookings and the respective users who made those bookings.
2. **LEFT JOIN**: Retrieves all properties and their reviews, including properties that have no reviews.
3. **FULL OUTER JOIN**: Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.

### Subqueries
1. **Non-correlated subquery**: Find all properties where the average rating is greater than 4.0.
2. **Correlated subquery**: Find users who have made more than 3 bookings.