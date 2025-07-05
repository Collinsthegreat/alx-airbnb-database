-- ======================================================
-- Airbnb Clone – Advanced SQL Join Queries
-- Author: [Your Name]
-- Description: INNER JOIN, LEFT JOIN, and FULL OUTER JOIN
-- ======================================================

-- ======================================================
-- 1. INNER JOIN: Retrieve all bookings with the users who made them
-- Only bookings with valid users will be included.
-- ======================================================

SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name || ' ' || u.last_name AS guest_name,
    u.email AS guest_email,
    u.phone_number
FROM booking b
INNER JOIN "user" u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- ======================================================
-- 2. LEFT JOIN: Retrieve all properties and their reviews
-- Includes properties that have not been reviewed yet.
-- ======================================================

SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    COALESCE(r.user_id, 'No Reviewer') AS reviewer_id
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
ORDER BY p.name ASC, r.created_at DESC;

-- ======================================================
-- 3. FULL OUTER JOIN: Retrieve all users and all bookings
-- Includes:
--   - Users without bookings
--   - Bookings not linked to any user (e.g., orphaned rows)
-- ======================================================

SELECT
    COALESCE(u.user_id::TEXT, 'ORPHANED_BOOKING') AS user_identifier,
    COALESCE(u.first_name || ' ' || u.last_name, 'Unknown User') AS user_name,
    COALESCE(u.email, 'N/A') AS email,
    COALESCE(u.role, 'N/A') AS role,
    COALESCE(b.booking_id::TEXT, 'NO_BOOKING') AS booking_identifier,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN u.user_id IS NULL THEN 'Orphaned Booking'
        WHEN b.booking_id IS NULL THEN 'User Without Booking'
        ELSE 'Active User'
    END AS booking_status
FROM "user" u
FULL OUTER JOIN booking b ON u.user_id = b.user_id
ORDER BY booking_status, COALESCE(b.created_at, u.created_at) DESC;

-- ======================================================
-- End of Advanced Join Queries
-- ======================================================

