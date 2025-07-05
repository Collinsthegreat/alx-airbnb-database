-- Initial Query: Retrieve all bookings with user, property, and payment details

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date
FROM
    bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- Performance analysis using EXPLAIN
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date
FROM
    bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- Refactored Optimized Query
-- Only selecting necessary fields, assumes indexing on booking_id, user_id, property_id

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name || ' ' || u.last_name AS guest_name,
    u.email,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date DESC;

