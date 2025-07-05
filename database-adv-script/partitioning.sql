-- Connect to the airbnb database
\c airbnb

-- STEP 1: Create a new partitioned table for Bookings, partitioned by RANGE on start_date
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status status_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- STEP 2: Create yearly partitions (you can modify these or add more as needed)
CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- STEP 3: (Optional but recommended) Create local indexes on key columns inside each partition
-- Improves filtering, joins, and sorting within each partition
CREATE INDEX idx_bookings_2022_user ON bookings_2022(user_id);
CREATE INDEX idx_bookings_2023_user ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user ON bookings_2025(user_id);

CREATE INDEX idx_bookings_2022_property ON bookings_2022(property_id);
CREATE INDEX idx_bookings_2023_property ON bookings_2023(property_id);
CREATE INDEX idx_bookings_2024_property ON bookings_2024(property_id);
CREATE INDEX idx_bookings_2025_property ON bookings_2025(property_id);

-- STEP 4: Migrate data from the original bookings table to the partitioned table
INSERT INTO bookings_partitioned
SELECT * FROM bookings
WHERE start_date IS NOT NULL;

-- STEP 5: (Optional) Test performance improvement with EXPLAIN ANALYZE
-- Example: Query to fetch bookings within a specific year
EXPLAIN ANALYZE
SELECT 
    booking_id, start_date, end_date, total_price, status
FROM 
    bookings_partitioned
WHERE 
    start_date BETWEEN '2024-01-01' AND '2024-12-31';

