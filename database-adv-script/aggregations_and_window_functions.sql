-- ==========================================================
-- Airbnb Clone – Aggregations and Window Functions
-- Author: [Your Name]
-- File: aggregations_and_window_functions.sql
-- Description:
--     1. Aggregate: Total number of bookings per user.
--     2. Window Function: Rank properties by total bookings.
-- ==========================================================

-- ==========================================================
-- 1. TOTAL BOOKINGS PER USER (GROUP BY + COUNT)
-- ==========================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM "user" u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- - We use LEFT JOIN to include users with zero bookings.
-- - GROUP BY groups users, and COUNT calculates total bookings.
-- - Sorted to show most active users first.

-- ==========================================================
-- ==========================================================
-- 2. RANK PROPERTIES BY NUMBER OF BOOKINGS (WINDOW FUNCTION)
-- Objective: Rank properties based on how many times they've been booked
-- ==========================================================

-- 🌟 Using RANK(): Handles ties by assigning the same rank to properties with equal bookings
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank ASC;

-- 🔁 Alternative: Using ROW_NUMBER() instead of RANK()
-- ROW_NUMBER assigns a unique rank even if bookings are tied
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_position
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_position ASC;


