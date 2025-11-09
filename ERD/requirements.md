# Airbnb Database ER Diagram Requirements

## Overview
This document outlines the Entity-Relationship (ER) diagram for the Airbnb database system, including all entities, their attributes, and relationships.

## Entities and Attributes

### 1. User
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- first_name (VARCHAR(50), NOT NULL)
- last_name (VARCHAR(50), NOT NULL)
- email (VARCHAR(100), UNIQUE, NOT NULL)
- password_hash (VARCHAR(255), NOT NULL)
- phone (VARCHAR(20))
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE)

### 2. Property
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- host_id (INT, Foreign Key → User.id, NOT NULL)
- name (VARCHAR(100), NOT NULL)
- description (TEXT)
- location (VARCHAR(100), NOT NULL)
- price_per_night (DECIMAL(10,2), NOT NULL)
- max_guests (INT, NOT NULL)
- bedrooms (INT)
- bathrooms (INT)
- amenities (JSON/TEXT)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE)

### 3. Booking
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- user_id (INT, Foreign Key → User.id, NOT NULL)
- property_id (INT, Foreign Key → Property.id, NOT NULL)
- checkin_date (DATE, NOT NULL)
- checkout_date (DATE, NOT NULL)
- total_price (DECIMAL(10,2), NOT NULL)
- guests_count (INT, NOT NULL)
- status (ENUM: 'pending', 'confirmed', 'cancelled', 'completed', DEFAULT 'pending')
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE)

### 4. Review
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- user_id (INT, Foreign Key → User.id, NOT NULL)
- property_id (INT, Foreign Key → Property.id, NOT NULL)
- booking_id (INT, Foreign Key → Booking.id, NOT NULL)
- rating (INT, NOT NULL, CHECK: 1-5)
- comment (TEXT)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 5. Payment
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- booking_id (INT, Foreign Key → Booking.id, NOT NULL)
- amount (DECIMAL(10,2), NOT NULL)
- payment_method (ENUM: 'credit_card', 'debit_card', 'paypal', 'bank_transfer')
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- status (ENUM: 'pending', 'completed', 'failed', 'refunded', DEFAULT 'pending')
- transaction_id (VARCHAR(100), UNIQUE)

### 6. Message (Optional - for host-guest communication)
**Primary Key:** id
**Attributes:**
- id (INT, Primary Key, Auto-increment)
- sender_id (INT, Foreign Key → User.id, NOT NULL)
- receiver_id (INT, Foreign Key → User.id, NOT NULL)
- booking_id (INT, Foreign Key → Booking.id)
- message (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- is_read (BOOLEAN, DEFAULT FALSE)

## Relationships

### One-to-Many Relationships
1. **User → Property** (1:N)
   - One user can list multiple properties as a host
   - Foreign Key: Property.host_id → User.id

2. **User → Booking** (1:N)
   - One user can make multiple bookings
   - Foreign Key: Booking.user_id → User.id

3. **Property → Booking** (1:N)
   - One property can have multiple bookings
   - Foreign Key: Booking.property_id → Property.id

4. **User → Review** (1:N)
   - One user can write multiple reviews
   - Foreign Key: Review.user_id → User.id

5. **Property → Review** (1:N)
   - One property can have multiple reviews
   - Foreign Key: Review.property_id → Property.id

6. **Booking → Review** (1:1)
   - One booking can have at most one review
   - Foreign Key: Review.booking_id → Booking.id

7. **Booking → Payment** (1:N)
   - One booking can have multiple payments (partial payments, refunds)
   - Foreign Key: Payment.booking_id → Booking.id

8. **User → Message** (1:N) - as sender
   - One user can send multiple messages
   - Foreign Key: Message.sender_id → User.id

9. **User → Message** (1:N) - as receiver
   - One user can receive multiple messages
   - Foreign Key: Message.receiver_id → User.id

10. **Booking → Message** (1:N)
    - One booking can have multiple related messages
    - Foreign Key: Message.booking_id → Booking.id

## ER Diagram Notation

### Entity Representation
- **Rectangles**: Represent entities
- **Bold Text**: Primary key attributes
- **Italic Text**: Foreign key attributes
- **Regular Text**: Other attributes

### Relationship Representation
- **Lines**: Connect related entities
- **Crow's Foot**: Indicates "many" side of relationship
- **Single Line**: Indicates "one" side of relationship
- **Labels**: Describe the relationship nature

### Cardinality
- **1:1**: One-to-One (e.g., Booking-Review)
- **1:N**: One-to-Many (e.g., User-Booking)
- **M:N**: Many-to-Many (if any exist, would require junction table)

## Business Rules

1. A user must be registered before they can book properties
2. A property must be listed by a host (user) before it can be booked
3. Bookings cannot overlap for the same property on the same dates
4. Reviews can only be written after booking completion
5. Payments are associated with specific bookings
6. Messages can be sent between users, optionally related to a booking

## Implementation Notes

- Use InnoDB engine for foreign key constraints
- Implement proper indexing on foreign keys and frequently queried columns
- Consider partitioning large tables (e.g., bookings by date)
- Implement triggers for data consistency (e.g., update timestamps)
- Use appropriate data types for performance and storage efficiency

## Tools for ER Diagram Creation

- **Draw.io**: Free online diagramming tool
- **Lucidchart**: Professional diagramming platform
- **Microsoft Visio**: Desktop diagramming software
- **DB Designer**: Database-specific design tool

## File Structure
- `requirements.md`: This specification document
- `airbnb_erd.drawio`: Draw.io diagram file (to be created)
- `airbnb_erd.png`: Exported PNG image of the diagram
- `airbnb_erd.pdf`: Exported PDF version of the diagram