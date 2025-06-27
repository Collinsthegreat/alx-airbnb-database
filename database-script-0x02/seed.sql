-- Airbnb Data Seed Script

-- Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  ('u001', 'Alice', 'Wong', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
  ('u002', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '0987654321', 'host'),
  ('u003', 'Clara', 'Nguyen', 'clara@example.com', 'hashed_pw3', NULL, 'admin');

-- Properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES 
  ('p001', 'u002', 'Modern Loft', 'A sunny downtown loft perfect for couples.', 'Lagos', 150.00),
  ('p002', 'u002', 'Cozy Cabin', 'Quiet escape in the hills, ideal for retreats.', 'Abuja', 90.00);

-- Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
  ('b001', 'p001', 'u001', '2024-08-01', '2024-08-05', 600.00, 'confirmed'),
  ('b002', 'p002', 'u001', '2024-12-20', '2024-12-23', 270.00, 'pending');

-- Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES 
  ('pay001', 'b001', 600.00, 'credit_card');

-- Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES 
  ('r001', 'p001', 'u001', 5, 'Loved the natural light and location!'),
  ('r002', 'p002', 'u001', 4, 'Very peaceful, though the Wi-Fi was spotty.');

-- Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES 
  ('m001', 'u001', 'u002', 'Hi, is early check-in possible?'),
  ('m002', 'u002', 'u001', 'Yes, you can check in from 11 AM.');
