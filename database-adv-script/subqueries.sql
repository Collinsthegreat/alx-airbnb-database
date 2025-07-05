-- ========================================================
-- Airbnb Clone – SQL Subqueries (Correlated and Non-Correlated)
-- File: subqueries.sql
-- Description: Demonstrates advanced SQL querying using both 
--              non-correlated and correlated subqueries.
-- ========================================================

-- ========================================================
-- 1. NON-CORRELATED SUBQUERY:
-- Find all properties where the average rating is greater than 4.0
-- ========================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.price_per_night,
    p.created_at
FROM property p
WHERE p.property_id IN (
    SELECT 
        r.property_id
    FROM review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.created_at DESC;

-- - The inner query computes average rating per property.
-- - The outer query selects only those properties whose average rating > 4.0.

-- ========================================================
-- 2. CORRELATED SUBQUERY:
-- Find users who have made more than 3 bookings
-- ========================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    (
        SELECT COUNT(*) 
        FROM booking b 
        WHERE b.user_id = u.user_id
    ) AS booking_count
FROM "user" u
WHERE (
    SELECT COUNT(*) 
    FROM booking b 
    WHERE b.user_id = u.user_id
) > 3
ORDER BY booking_count DESC;

-- - The inner subquery is correlated with each user.
-- - It counts bookings made by each user.
-- - Only users with more than 3 bookings are returned.

-- ========================================================
-- End of Subqueries Script
-- ========================================================

