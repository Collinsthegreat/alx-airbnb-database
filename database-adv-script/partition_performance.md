# Partitioning Large Tables

## Objective
To improve performance for querying large datasets in the `bookings` table by implementing **range partitioning** on the `start_date` column.
---
## Partitioned Table Structure

```sql
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
```
YEARLY PARTITIONS

CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

  INSERT DATA

  INSERT INTO bookings_partitioned
SELECT * FROM bookings
WHERE start_date IS NOT NULL;

OPTIONAL: ADD LOCAL INDEXES FOR OPTIMIZATION

CREATE INDEX idx_bookings_2023_user ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2023_property ON bookings_2023(property_id);

 QUERY PERFORMANCE TESTS
Example Query: August–October 2023
Non-Partitioned Table:

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-08-01' AND '2023-10-31';
```
Execution Time: 0.073 ms

Partitioned Table:
```sql
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2023-08-01' AND '2023-10-31';
```
 Execution Time: 0.147 ms

 Example Query: June 2023
 
Non-Partitioned Table:
```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
```
⏱ Execution Time: 0.115 ms

Partitioned Table:
```sql
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
```
⏱ Execution Time: 0.086 ms

