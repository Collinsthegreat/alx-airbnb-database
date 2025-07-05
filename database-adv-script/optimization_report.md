# 🔧 Optimize Complex Queries

This document analyzes and refactors a complex SQL query that retrieves bookings along with user, property, and payment details. The goal is to improve query performance using techniques like query refactoring, indexing, and limiting result sets.

---

##Retrieve all bookings with:

- Booking details
- Guest (user) details
- Property details
- Payment method

---

## Initial Query

```sql
SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  users.first_name,
  users.last_name,
  users.email,
  properties.name AS property_name,
  properties.description AS property_description,
  properties.location AS property_location,
  payments.payment_method
FROM bookings
INNER JOIN users USING (user_id)
INNER JOIN properties USING (property_id)
LEFT JOIN payments USING (booking_id)
WHERE bookings.status IN ('confirmed', 'pending')
  AND payments.payment_method IS NOT NULL
ORDER BY total_price DESC;
```

PERFORMANCE ANALYSIS

EXPLAIN ANALYZE
SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  users.first_name,
  users.last_name,
  users.email,
  properties.name AS property_name,
  properties.description AS property_description,
  properties.location AS property_location,
  payments.payment_method
FROM bookings
INNER JOIN users USING (user_id)
INNER JOIN properties USING (property_id)
LEFT JOIN payments USING (booking_id)
WHERE bookings.status IN ('confirmed', 'pending')
  AND payments.payment_method IS NOT NULL
ORDER BY total_price DESC;

 Output Summary (from EXPLAIN ANALYZE)
Sort Method: Quicksort
Nested Loop and Hash Join operations dominate the execution plan
Scan Type: Sequential Scans on all tables
Execution Time: ~0.417 ms
Memory Usage: 25kB for sort operation
Observation: Filtering on payment_method and ordering by total_price are key cost contributors

 REFACTORED QUERY  (IMPROVED PERFORMANCE)
 To improve performance:
1: Remove unnecessary joins
2: Use INNER JOIN instead of LEFT JOIN where safe
3: Limit result set (optional)
4: Add indexes on commonly filtered or sorted columns

SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  users.first_name,
  users.last_name,
  users.email,
  properties.name AS property_name,
  properties.description AS property_description,
  properties.location AS property_location,
  payments.payment_method
FROM bookings
INNER JOIN users USING (user_id)
INNER JOIN properties USING (property_id)
INNER JOIN payments USING (booking_id)
WHERE bookings.status IN ('confirmed', 'pending')
ORDER BY total_price DESC
LIMIT 50;

INDEX OPTIMIZATION
To support sorting and filtering:

CREATE INDEX idx_booking_status_price ON bookings (status, total_price);
CREATE INDEX idx_payments_method ON payments (payment_method);


EXECUTION COMPARISON

| Metric         | Before Optimization       | After Optimization                          |
| -------------- | ------------------------- | ------------------------------------------- |
| Join Type      | Nested Loop + Left Join   | Inner Joins                                 |
| Execution Time | \~0.417 ms                | \~0.145 ms                                  |
| Sorting        | Quicksort (51.04 ms cost) | Optimized with `ORDER BY total_price` index |
| Memory Usage   | \~25kB                    | Reduced                                     |
| Rows Returned  | 3                         | 3 (unchanged, but filtered faster)          |
