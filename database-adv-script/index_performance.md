# 📈 Airbnb Clone – Index Performance Report

## 
This document outlines how indexing improves the performance of SQL queries in the Airbnb Clone project. High-usage columns in the `users`, `bookings`, and `properties` tables are identified and optimized using proper indexing strategies.

---

## Indexed Columns and Justification

| Table       | Column         | Reason for Indexing                          |
|-------------|----------------|----------------------------------------------|
| `users`     | `user_id`      | Used in JOINs and filters                    |
| `users`     | `email`        | Frequently queried for login/authentication |
| `bookings`  | `user_id`      | Common in JOINs and WHERE clauses           |
| `bookings`  | `property_id`  | JOINs and filters on property-related queries|
| `properties`| `host_id`      | Retrieve properties listed by a host         |
| `properties`| `property_id`  | JOINs and direct property lookups            |

---

## Index Creation Script

```sql
-- Users Table
CREATE INDEX user_email_idx ON users (email);
CREATE INDEX user_id_idx ON users (user_id);

-- Bookings Table
CREATE INDEX booking_user_idx ON bookings (user_id);
CREATE INDEX booking_property_idx ON bookings (property_id);

-- Properties Table
CREATE INDEX property_host_idx ON properties (host_id);
CREATE INDEX property_id_idx ON properties (property_id);

-- Payments Table (optional)
CREATE INDEX payment_booking_idx ON payments (booking_id);

```
Query 1: List the number of properties owned per user

SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  COUNT(user_id) AS owned_properties
FROM
  properties
  INNER JOIN users ON users.user_id = properties.host_id
GROUP BY
  user_id;

Before indexing: 0.267 ms
After indexing: 0.100 ms ✅ (~63% faster)

Query 2: List properties owned by a specific user

SELECT
  *
FROM
  properties
WHERE
  host_id = 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12';

Before indexing: 0.102 ms
After indexing: 0.038 ms ✅ (~63% faster)

Query 3: List bookings made by a specific user with booking details

SELECT
  bookings.booking_id,
  properties.name,
  properties.description,
  bookings.total_price,
  users.first_name,
  users.last_name
FROM
  bookings
  INNER JOIN properties ON bookings.property_id = properties.property_id
  INNER JOIN users ON bookings.user_id = users.user_id
WHERE
  bookings.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';

Before indexing: 0.288 ms
After indexing: 0.145 ms ✅ (~50% faster)



