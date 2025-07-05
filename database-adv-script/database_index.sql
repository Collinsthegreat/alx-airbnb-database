-- =====================================================
-- Airbnb Clone – CREATE INDEX Commands for Optimization
-- File: database_index.sql
-- Description:
--     Indexes created on high-usage columns to improve
--     query performance for JOINs, WHERE, and ORDER BY.
-- =====================================================

-- Connect to the target database (PostgreSQL)
-- \c airbnb

-- Enable expanded output for EXPLAIN results
-- \x

-- ================================
-- INDEX CREATION
-- ================================

-- 🔹 USER table
CREATE UNIQUE INDEX idx_user_email ON "user" (email);
CREATE INDEX idx_user_user_id ON "user" (user_id);

-- 🔹 BOOKING table
CREATE INDEX idx_booking_user_id ON booking (user_id);
CREATE INDEX idx_booking_property_id ON booking (property_id);
CREATE INDEX idx_booking_status ON booking (status);
CREATE INDEX idx_booking_created_at ON booking (created_at);

-- 🔹 PROPERTY table
CREATE INDEX idx_property_property_id ON property (property_id);
CREATE INDEX idx_property_host_id ON property (host_id);
CREATE INDEX idx_property_created_at ON property (created_at);

-- Optional additional indexes if needed
-- CREATE INDEX idx_review_property_id ON review (property_id);
-- CREATE INDEX idx_payment_booking_id ON payment (booking_id);

-- =====================================================
-- Example Queries for Benchmarking (Run with EXPLAIN ANALYZE)
-- =====================================================

-- Query: Count properties per user
EXPLAIN ANALYZE
SELECT
  u.user_id,
  u.first_name,
  u.last_name,
  COUNT(p.property_id) AS owned_properties
FROM property p
JOIN "user" u ON u.user_id = p.host_id
GROUP BY u.user_id;

-- Query: Properties owned by a specific user
EXPLAIN ANALYZE
SELECT *
FROM property
WHERE host_id = 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12';

-- Query: All bookings by a specific user
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  p.name AS property_name,
  p.description,
  b.total_price,
  u.first_name,
  u.last_name
FROM booking b
JOIN property p ON b.property_id = p.property_id
JOIN "user" u ON b.user_id = u.user_id
WHERE b.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';

-- =====================================================
-- End of Indexing Script
-- =====================================================

