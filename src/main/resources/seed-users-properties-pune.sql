-- Seed data for FlatFinder: 10 users (8 owners + 2 seekers) and 9 Pune-area properties
-- Note: Only one owner (rahul.owner@flatfinder.in) is assigned 2 properties.

START TRANSACTION;

-- =========================================================
-- USERS (idempotent by unique email)
-- =========================================================

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Rahul Patil', 'rahul.owner@flatfinder.in', 'Owner@123', '9876543201', 'Baner, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'rahul.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Sneha Kulkarni', 'sneha.owner@flatfinder.in', 'Owner@123', '9876543202', 'Wakad, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'sneha.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Amit Jadhav', 'amit.owner@flatfinder.in', 'Owner@123', '9876543203', 'Hinjewadi, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'amit.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Neha Shinde', 'neha.owner@flatfinder.in', 'Owner@123', '9876543204', 'Kothrud, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'neha.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Prasad Deshmukh', 'prasad.owner@flatfinder.in', 'Owner@123', '9876543205', 'Viman Nagar, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'prasad.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Pooja Nair', 'pooja.owner@flatfinder.in', 'Owner@123', '9876543206', 'Hadapsar, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'pooja.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Kunal More', 'kunal.owner@flatfinder.in', 'Owner@123', '9876543207', 'Kharadi, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'kunal.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Vaishali Joshi', 'vaishali.owner@flatfinder.in', 'Owner@123', '9876543208', 'Pimple Saudagar, Pune', 'OWNER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'vaishali.owner@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Rohan Salvi', 'rohan.seeker@flatfinder.in', 'Seeker@123', '9876543209', 'Magarpatta, Pune', 'SEEKER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'rohan.seeker@flatfinder.in');

INSERT INTO users (name, email, password, phone_number, address, role, is_verified, otp_code)
SELECT 'Priya Pawar', 'priya.seeker@flatfinder.in', 'Seeker@123', '9876543210', 'Kalyani Nagar, Pune', 'SEEKER', 1, NULL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'priya.seeker@flatfinder.in');

-- =========================================================
-- PROPERTIES (idempotent by title + location + owner)
-- image_url kept empty as requested
-- =========================================================

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Spacious 1BHK near Balewadi High Street',
    'Well-ventilated 1BHK flat with modular kitchen and good connectivity to IT parks.',
    18000,
    'Baner, Pune',
    'Pune',
    '1',
    '1',
    '620',
    'Lift, Security, Parking, WiFi',
    (SELECT id FROM users WHERE email = 'rahul.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Spacious 1BHK near Balewadi High Street'
      AND location = 'Baner, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'rahul.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Studio Apartment close to Aundh IT Hub',
    'Compact studio for working professionals with quick access to Aundh and Baner roads.',
    14500,
    'Aundh, Pune',
    'Pune',
    '1',
    '1',
    '450',
    'Power Backup, CCTV, RO Water',
    (SELECT id FROM users WHERE email = 'rahul.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Studio Apartment close to Aundh IT Hub'
      AND location = 'Aundh, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'rahul.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Modern 2BHK in Wakad Prime Zone',
    'Family-friendly 2BHK with balcony and covered parking near metro connectivity.',
    26000,
    'Wakad, Pune',
    'Pune',
    '2',
    '2',
    '980',
    'Gym, Lift, Security, Covered Parking',
    (SELECT id FROM users WHERE email = 'sneha.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Modern 2BHK in Wakad Prime Zone'
      AND location = 'Wakad, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'sneha.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    '1RK for IT Professionals in Hinjewadi Phase 1',
    'Affordable 1RK with furnished setup and shuttle access to nearby tech companies.',
    12000,
    'Hinjewadi Phase 1, Pune',
    'Pune',
    '1',
    '1',
    '380',
    'Furnished, WiFi, Security',
    (SELECT id FROM users WHERE email = 'amit.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = '1RK for IT Professionals in Hinjewadi Phase 1'
      AND location = 'Hinjewadi Phase 1, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'amit.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Semi-Furnished 1BHK in Kothrud',
    'Quiet residential lane, ideal for couples and students, near bus and market.',
    17000,
    'Kothrud, Pune',
    'Pune',
    '1',
    '1',
    '590',
    'Geyser, Balcony, 24x7 Water',
    (SELECT id FROM users WHERE email = 'neha.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Semi-Furnished 1BHK in Kothrud'
      AND location = 'Kothrud, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'neha.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Premium 2BHK near Phoenix Marketcity',
    'Spacious flat in Viman Nagar with easy airport and office access.',
    32000,
    'Viman Nagar, Pune',
    'Pune',
    '2',
    '2',
    '1100',
    'Clubhouse, Lift, Security, Parking',
    (SELECT id FROM users WHERE email = 'prasad.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Premium 2BHK near Phoenix Marketcity'
      AND location = 'Viman Nagar, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'prasad.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Budget 1RK near Magarpatta',
    'Cost-effective option in Hadapsar with quick access to Magarpatta city.',
    11000,
    'Hadapsar, Pune',
    'Pune',
    '1',
    '1',
    '350',
    'Security, Water Supply, Bike Parking',
    (SELECT id FROM users WHERE email = 'pooja.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Budget 1RK near Magarpatta'
      AND location = 'Hadapsar, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'pooja.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Fully Furnished 1BHK in Kharadi EON Zone',
    'Ready-to-move-in flat with modern furniture and excellent society amenities.',
    24000,
    'Kharadi, Pune',
    'Pune',
    '1',
    '1',
    '680',
    'Furnished, AC, Lift, Security, Gym',
    (SELECT id FROM users WHERE email = 'kunal.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Fully Furnished 1BHK in Kharadi EON Zone'
      AND location = 'Kharadi, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'kunal.owner@flatfinder.in')
);

INSERT INTO properties (
    title, description, price, location, city, bedrooms, bathrooms, area, amenities,
    owner_id, image_url, created_at, updated_at, is_available, approval_status
)
SELECT
    'Family 2BHK in Pimple Saudagar',
    'Large 2BHK with natural light, near schools and daily convenience stores.',
    28000,
    'Pimple Saudagar, Pune',
    'Pune',
    '2',
    '2',
    '1020',
    'Lift, Parking, Garden, Security',
    (SELECT id FROM users WHERE email = 'vaishali.owner@flatfinder.in'),
    '',
    NOW(),
    NOW(),
    1,
    'APPROVED'
WHERE NOT EXISTS (
    SELECT 1
    FROM properties
    WHERE title = 'Family 2BHK in Pimple Saudagar'
      AND location = 'Pimple Saudagar, Pune'
      AND owner_id = (SELECT id FROM users WHERE email = 'vaishali.owner@flatfinder.in')
);

COMMIT;

-- Quick verification queries:
-- SELECT role, COUNT(*) FROM users GROUP BY role;
-- SELECT owner_id, COUNT(*) AS total_properties FROM properties GROUP BY owner_id ORDER BY total_properties DESC;
-- SELECT title, location, owner_id, image_url FROM properties ORDER BY id DESC;
