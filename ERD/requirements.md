ERD (Entity Relationship Diagram)

Description:
User (user_id) ↳ 1:N with Property (host_id) ↳ 1:N with Booking (user_id) ↳ 1:N with Review (user_id) ↳ 1:N with Message (sender_id & recipient_id)

Property (property_id) ↳ 1:N with Booking ↳ 1:N with Review

Booking (booking_id) ↳ 1:1 with Payment
ERD Summary
 Entities & Attributes
 1. User
user_id (PK)
first_name
last_name
email (Unique, Indexed)
password_hash
phone_number
role (guest, host, admin)
created_at

2. Property
property_id (PK)
host_id (FK → User.user_id)
name
description
location
pricepernight
created_at
updated_at

3. Booking
booking_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
start_date
end_date
total_price
status (pending, confirmed, canceled)
created_at

4. Payment
payment_id (PK)
booking_id (FK → Booking.booking_id)
amount
payment_date
payment_method (credit_card, paypal, stripe)

5. Review
review_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
rating (1–5)
comment
created_at

6. Message
message_id (PK)
sender_id (FK → User.user_id)
recipient_id (FK → User.user_id)
message_body
sent_at

 Relationships Between Entities
Entity A	Relationship	Entity B	Cardinality
User	hosts	Property	1:N (one user can host many properties)

ER diagram
The image can be found in ERD/erd.png
User	makes	Booking	1:N (one user can make many bookings)
Property	is booked in	Booking	1:N (one property can appear in many bookings)
Booking	has	Payment	1:1 (each booking has one payment)
User	writes	Review	1:N (a user can write many reviews)
Property	is reviewed in	Review	1:N (a property can have many reviews)
User	sends	Message	1:N (each user can send many messages)
User	receives	Message	1:N (each user can receive many messages)
