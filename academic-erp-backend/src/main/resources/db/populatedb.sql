-- ============================================================
-- Database Population Script for Academic ERP / Placement System
-- Context: IIIT-B (Indian Institute of Information Technology Bangalore)
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;

-- Clear existing data
TRUNCATE TABLE placement_student;
TRUNCATE TABLE placement_filter;
TRUNCATE TABLE placement;
TRUNCATE TABLE students;
TRUNCATE TABLE employees;
TRUNCATE TABLE specialisation;
TRUNCATE TABLE domains;
TRUNCATE TABLE departments;
TRUNCATE TABLE organisations;

SET FOREIGN_KEY_CHECKS=1;

-- ============================================================
-- 1. Insert Master Data
-- ============================================================

-- Departments
INSERT INTO departments (department_id, name, capacity) VALUES
(1, 'OUTREACH', 10),
(2, 'ACCOUNTS', 5),
(3, 'ADMIN', 8),
(4, 'ESTATE', 6);

-- Organisations (Real companies hiring from IIIT-B)
INSERT INTO organisations (id, name, address) VALUES
(1, 'Cisco Systems', 'Bangalore, Karnataka'),
(2, 'Amazon', 'Bangalore, Karnataka'),
(3, 'Microsoft', 'Hyderabad, Telangana'),
(4, 'Google', 'Bangalore, Karnataka'),
(5, 'Goldman Sachs', 'Bangalore, Karnataka'),
(6, 'Flipkart', 'Bangalore, Karnataka'),
(7, 'Uber', 'Bangalore, Karnataka'),
(8, 'Swiggy', 'Bangalore, Karnataka'),
(9, 'PhonePe', 'Bangalore, Karnataka'),
(10, 'Zoho', 'Chennai, Tamil Nadu'),
(11, 'Morgan Stanley', 'Mumbai, Maharashtra'),
(12, 'Samsung R&D', 'Bangalore, Karnataka');

-- Domains (Academic Programs)
INSERT INTO domains (domain_id, program, batch, capacity, qualification) VALUES
(1, 'MTECH-CSE', '2024', 150, 'M.Tech'),
(2, 'MTECH-ECE', '2024', 30, 'M.Tech'),
(3, 'iMTECH', '2024', 120, 'Integrated M.Tech'),
(4, 'MS-Research', '2024', 20, 'Master of Science');

-- Specialisations
INSERT INTO specialisation (specialisation_id, code, name, description, year, credits_required) VALUES
(1, 'TS', 'Theory & Systems', 'Computer Science Theory and Systems', 2024, 20),
(2, 'DS', 'Data Science', 'Data Analytics and AI', 2024, 20),
(3, 'NC', 'Networking & Comm', 'Computer Networks and Communication', 2024, 20),
(4, 'VLSI', 'VLSI Systems', 'Very Large Scale Integration', 2024, 20),
(5, 'DT', 'Digital Society', 'Technology and Society', 2024, 20),
(6, 'AI', 'Artificial Intelligence', 'Machine Learning and Deep Learning', 2024, 20);

-- ============================================================
-- 2. Insert Employees
-- ============================================================

INSERT INTO employees (first_name, last_name, email, title, role, department_id) VALUES
('Siddhesh', 'Abhang', 'iiitbbhai@gmail.com', 'Placement Officer', 'OUTREACH', 1),
('Rahul', 'Verma', 'rahul.verma@iiitb.ac.in', 'Outreach Manager', 'MANAGER', 1),
('Suresh', 'Reddy', 'suresh.reddy@iiitb.ac.in', 'System Admin', 'ADMIN', 3),
('Anjali', 'Nair', 'anjali.nair@iiitb.ac.in', 'Accounts Officer', 'ACCOUNTANT', 2);

-- ============================================================
-- 3. Insert Students (Indian Names)
-- ============================================================

INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
-- M.Tech CSE - Theory & Systems
(1, 'MT2024001', 'Aarav', 'Patel', 'aarav.patel@iiitb.ac.in', 3.8, 64, 2024, 1, 1),
(2, 'MT2024002', 'Vihaan', 'Gowda', 'vihaan.gowda@iiitb.ac.in', 3.5, 64, 2024, 1, 1),

-- M.Tech CSE - Data Science
(3, 'MT2024010', 'Ishita', 'Gupta', 'ishita.gupta@iiitb.ac.in', 3.9, 64, 2024, 1, 2),
(4, 'MT2024011', 'Rohan', 'Mehta', 'rohan.mehta@iiitb.ac.in', 3.2, 64, 2024, 1, 2),
(5, 'MT2024012', 'Ananya', 'Iyer', 'ananya.iyer@iiitb.ac.in', 3.6, 64, 2024, 1, 2),

-- M.Tech ECE - VLSI
(6, 'MT2024050', 'Aditya', 'Rao', 'aditya.rao@iiitb.ac.in', 3.7, 64, 2024, 2, 4),
(7, 'MT2024051', 'Kavya', 'Krishnan', 'kavya.krishnan@iiitb.ac.in', 3.4, 64, 2024, 2, 4),

-- iMTech - AI
(8, 'IMT2019001', 'Arjun', 'Singh', 'arjun.singh@iiitb.ac.in', 3.95, 120, 2024, 3, 6),
(9, 'IMT2019002', 'Sanya', 'Malhotra', 'sanya.malhotra@iiitb.ac.in', 3.85, 120, 2024, 3, 6),

-- MS Research - Networking
(10, 'MS2024001', 'Vikram', 'Chopra', 'vikram.chopra@iiitb.ac.in', 3.3, 40, 2024, 4, 3);

-- ============================================================
-- 4. Insert Placements (Job Offers)
-- ============================================================

INSERT INTO placement (id, organisation_id, profile, description, intake, minimum_grade) VALUES
(1, 4, 'Software Engineer', 'Core systems development role', 5, 3.5), -- Google
(2, 2, 'SDE-1', 'Backend development for e-commerce', 10, 3.0), -- Amazon
(3, 5, 'Analyst', 'Quantitative analysis and financial modeling', 3, 3.8), -- Goldman Sachs
(4, 1, 'Network Engineer', 'Networking protocols and embedded systems', 6, 3.2), -- Cisco
(5, 6, 'Data Scientist', 'Machine Learning and Product Analytics', 4, 3.6), -- Flipkart
(6, 12, 'R&D Engineer', 'Research in AI/ML', 2, 3.7); -- Samsung

-- ============================================================
-- 5. Insert Placement Filters (Eligibility)
-- ============================================================

-- Google: Open to CSE and iMTech, High CGPA
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(1, 1, NULL), -- M.Tech CSE (Any Spec)
(1, 3, NULL); -- iMTech (Any Spec)

-- Amazon: Open to all
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(2, NULL, NULL);

-- Goldman Sachs: Preference for Data Science and AI
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(3, NULL, 2), -- Data Science
(3, NULL, 6); -- AI

-- Cisco: Networking and VLSI focus
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(4, NULL, 3), -- Networking
(4, 2, 4);    -- M.Tech ECE - VLSI

-- ============================================================
-- 6. Insert Applications
-- ============================================================

-- Google Applications
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(1, 1, 'cv_aarav.pdf', 'Strong in algorithms', FALSE, '2024-08-01'),
(1, 8, 'cv_arjun.pdf', 'Competitive programmer', TRUE, '2024-08-01'); -- Arjun Selected

-- Amazon Applications
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(2, 2, 'cv_vihaan.pdf', 'Full stack developer', FALSE, '2024-08-05'),
(2, 4, 'cv_rohan.pdf', 'Backend enthusiast', FALSE, '2024-08-05'),
(2, 7, 'cv_kavya.pdf', 'Good problem solver', FALSE, '2024-08-05');

-- Goldman Sachs Applications
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(3, 3, 'cv_ishita.pdf', 'Statistics expert', TRUE, '2024-08-10'), -- Ishita Selected
(3, 9, 'cv_sanya.pdf', 'ML researcher', FALSE, '2024-08-10');

-- Cisco Applications
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(4, 6, 'cv_aditya.pdf', 'VLSI design project', TRUE, '2024-08-15'), -- Aditya Selected
(4, 10, 'cv_vikram.pdf', 'Network protocols research', FALSE, '2024-08-15');
