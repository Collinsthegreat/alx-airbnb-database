Airbnb Database Normalization to 3NF

  Goal: This document explains how the Airbnb database schema was normalized up to the Third Normal Form (3NF)

 Step 1: First Normal Form (1NF)

  Criteria:
  - Atomic (indivisible) values
  - No repeating groups or arrays

 Application:
  - All attributes in `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message` are atomic.
  - No multi-valued fields (e.g., `phone_number` is a single value, not a list).

All tables satisfy 1NF.

 Step 2: Second Normal Form (2NF)

 Criteria:
  - Must satisfy 1NF
  - No partial dependencies (i.e., non-key attributes must depend on the whole primary key)

Application:
  - All tables have single-column primary keys (e.g., `user_id`, `property_id`, `booking_id`)
  - No partial dependencies exist because there are no composite keys.

All tables satisfy 2NF.

Step 3: Third Normal Form (3NF)

Criteria:
  - Must satisfy 2NF
  - No transitive dependencies (i.e., non-key attributes should not depend on other non-key attributes)

 Review & Adjustments:

   # `User` Table:
  - `email` is unique, but not dependent on any other non-key.
  - `role` is atomic and appropriate as ENUM.
    No transitive dependencies.

  # `Property` Table:
  - `host_id` is a foreign key, not derived from any non-key attribute.
  - All other attributes describe the property directly.
 Compliant with 3NF.

  # `Booking` Table:
  - `total_price` depends on duration × `pricepernight`, which is in `Property`. This may seem derived, but:
  - **Reason to keep:** Pricing may vary over time, and total price should be stored as a **snapshot** of cost at the time of booking.
  - It's **contextual** and not a transitive dependency.
   3NF respected.
    
  # `Payment` Table:
  - No transitive dependencies.
  - All fields relate directly to the payment instance.
   Clean 3NF structure.

  # `Review` Table:
  - `rating` and `comment` are direct attributes of the review.
  - No dependencies on non-key fields.
   Satisfies 3NF.

  # `Message` Table:
  -  `sender_id` and `recipient_id` are both foreign keys to `User`.
  - `message_body` and `sent_at` relate directly to the message.
   No transitive dependency found.

  # Final Verdict
  All tables are normalized to 3NF.  
  - Redundancies have been avoided  
  - Data integrity is preserved  
  - Relationships are maintained using foreign keys
  No restructuring of tables was required beyond validation.
