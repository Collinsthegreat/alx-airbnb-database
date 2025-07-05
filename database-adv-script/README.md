# Advanced SQL Queries - Airbnb Clone Database

This directory contains comprehensive SQL scripts showcasing advanced database techniques implemented for the **Airbnb Clone** project. Each script reflects best practices in query optimization, indexing, partitioning, monitoring, and performance tuning.

---

## Table of Contents

* [Overview](#overview)
* [Directory Structure](#directory-structure)
* [Database Schema Summary](#database-schema-summary)
* [Advanced SQL Categories](#advanced-sql-categories)
* [Performance Optimizations](#performance-optimizations)
* [Usage Instructions](#usage-instructions)
* [Best Practices](#best-practices)

---

## Overview

This project demonstrates the use of:

* **JOINs**: INNER, LEFT, FULL OUTER
* **Subqueries**: Correlated & non-correlated
* **Aggregations & Window Functions**: COUNT, RANK, ROW\_NUMBER
* **Indexing**: Performance tuning with CREATE INDEX
* **Query Optimization**: EXPLAIN ANALYZE, schema refactoring
* **Partitioning**: Table partitioning by date
* **Monitoring**: Performance tracking and refinement

---

## Directory Structure

```bash
database-adv-script/
├── joins_queries.sql
├── subqueries.sql
├── aggregations_and_window_functions.sql
├── database_index.sql
├── index_performance.md
├── perfomance.sql
├── optimization_report.md
├── partitioning.sql
├── partition_performance.md
├── performance_monitoring.md
├── README.md
```

---

## Database Schema Summary

```text
Tables:
├── users (user_id, email, ...)
├── properties (property_id, host_id, ...)
├── bookings (booking_id, user_id, property_id, start_date, status, ...)
├── payments (payment_id, booking_id, ...)
├── reviews (review_id, property_id, rating, ...)

Relationships:
├── users → properties (host_id)
├── users → bookings (user_id)
├── bookings → payments (booking_id)
├── properties → bookings, reviews
```

---

## Advanced SQL Categories

### 1. Join Queries (`joins_queries.sql`)

* INNER JOIN: Bookings + Users
* LEFT JOIN: Properties + Reviews
* FULL OUTER JOIN: All Users + All Bookings (even unmatched)

### 2. Subqueries (`subqueries.sql`)

* Non-Correlated: Properties with avg rating > 4.0
* Correlated: Users with more than 3 bookings

### 3. Aggregation & Window Functions (`aggregations_and_window_functions.sql`)

* Aggregation: COUNT(\*) per user
* Window Functions: RANK properties by total bookings

### 4. Indexing (`database_index.sql`, `index_performance.md`)

* Index creation on high-usage columns
* Pre- and post-index `EXPLAIN ANALYZE` performance comparison

### 5. Query Optimization (`perfomance.sql`, `optimization_report.md`)

* Refactored multi-join query with EXPLAIN ANALYZE report

### 6. Partitioning (`partitioning.sql`, `partition_performance.md`)

* Range partitioning of `bookings` table by `start_date`
* Query performance comparison: partitioned vs non-partitioned

### 7. Monitoring (`performance_monitoring.md`)

* Profiling with EXPLAIN ANALYZE
* Identifying bottlenecks and applied improvements

---

## Performance Optimizations

### ✅ Index Strategy

```sql
CREATE INDEX booking_user_idx ON bookings(user_id);
CREATE INDEX property_host_idx ON properties(host_id);
CREATE INDEX booking_property_idx ON bookings(property_id);
CREATE INDEX user_email_idx ON users(email);
CREATE INDEX booking_total_price_idx ON bookings(total_price);
```

### ✅ Partitioning Strategy

Partitioned `bookings` table by month using `start_date` to improve date-range queries.

### ✅ Query Optimization Techniques

* Replaced LEFT JOIN with INNER JOIN when possible
* Filtered early using WHERE before ORDER BY
* Used aggregate subqueries for summary views

---

## Usage Instructions

### 1. Clone & Navigate

```bash
git clone https://github.com/<your-username>/alx-airbnb-database.git
cd alx-airbnb-database/database-adv-script
```

### 2. Connect to PostgreSQL

```bash
psql -U your_user -d airbnb
```

### 3. Execute SQL Scripts

```bash
psql -f joins_queries.sql
psql -f subqueries.sql
psql -f aggregations_and_window_functions.sql
```

### 4. Monitor Performance

```sql
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date BETWEEN '2023-08-01' AND '2023-10-01';
```

---

## Best Practices

* Use `EXPLAIN ANALYZE` frequently
* Apply indexing to JOIN/WHERE/ORDER BY columns
* Avoid unnecessary subqueries
* Partition large tables by range for high-scale datasets
* Use CTEs or materialized views for repeated complex queries
* Document query logic with comments

---

## License

This project is part of the ALX Backend Specialization and follows educational licensing for demonstration purposes.

---
Note: Always validate performance in your production environment before deploying changes.


