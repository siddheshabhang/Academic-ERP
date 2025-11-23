---------------------------------------
-- ORGANISATIONS
---------------------------------------
INSERT INTO organisations (name, address) VALUES
('Oracle India', 'Bangalore'),
('RingCentral', 'Bangalore'),
('Cohesity', 'Bangalore'),
('Cisco', 'Bangalore');

---------------------------------------
-- EMPLOYEE (Outreach Role)
---------------------------------------
INSERT INTO employees (first_name, last_name, email, password, role)
VALUES ('Outreach', 'Admin', 'outreach@iiitb.ac.in', 'password', 'OUTREACH');

---------------------------------------
-- STUDENTS (8 samples, split names, ERP fields)
---------------------------------------
INSERT INTO students
(roll_number, first_name, last_name, email, photograph_path, cgpa, total_credits, graduation_year, domain, specialisation, placement_id)
VALUES
('IMT2022101', 'Aarav', 'Mehta', 'aarav.mehta@iiitb.ac.in', 'n/a', 3.44, 120, 2025, 'CSE', 'Data Science', NULL),
('IMT2022102', 'Riya', 'Narang', 'riya.narang@iiitb.ac.in', 'n/a', 3.28, 118, 2025, 'CSE', 'AI & ML', NULL),
('IMT2022103', 'Aditya', 'Rao', 'aditya.rao@iiitb.ac.in', 'n/a', 3.60, 122, 2025, 'CSE', 'Systems', NULL),
('IMT2022104', 'Meera', 'Iyer', 'meera.iyer@iiitb.ac.in', 'n/a', 3.64, 119, 2025, 'CSE', 'Data Science', NULL),

('MT2025121', 'Siddhesh', 'Abhang', 'siddhesh.abhang@iiitb.ac.in', 'n/a', 3.48, 40, 2025, 'CSE', 'Data Science', NULL),
('MT2025122', 'Rohan', 'Kulkarni', 'rohan.kulkarni@iiitb.ac.in', 'n/a', 3.32, 42, 2025, 'CSE', 'Systems', NULL),
('MT2025123', 'Sneha', 'Patil', 'sneha.patil@iiitb.ac.in', 'n/a', 3.24, 38, 2025, 'CSE', 'AI & ML', NULL),
('MT2025124', 'Aishwarya', 'Menon', 'aishwarya.menon@iiitb.ac.in', 'n/a', 3.68, 39, 2025, 'CSE', 'Data Science', NULL);

---------------------------------------
-- PLACEMENT OFFERS (2 jobs)
---------------------------------------
INSERT INTO placement (organisation_id, profile, description, minimum_grade) VALUES
(1, 'Software Engineer', 'Backend + Systems Developer Role', 3.20),
(3, 'Machine Learning Engineer', 'ML Engineer for Cohesity AI Team', 3.40);

---------------------------------------
-- PLACEMENT FILTERS (Eligibility)
---------------------------------------
INSERT INTO placement_filter (placement_id, specialisation, domain) VALUES
(1, 'Systems', 'CSE'),
(1, 'AI & ML', 'CSE'),
(1, 'Data Science', 'CSE'),

(2, 'AI & ML', 'CSE'),
(2, 'Data Science', 'CSE');

---------------------------------------
-- PLACEMENT APPLICATIONS (8 samples)
---------------------------------------
INSERT INTO placement_student
(placement_id, student_id, cv_path, acceptance, comments, application_date)
VALUES
(1, 1, 'cv/aarav.pdf', 'PENDING', NULL, '2025-11-01'),
(1, 3, 'cv/aditya.pdf', 'PENDING', NULL, '2025-11-02'),
(1, 5, 'cv/siddhesh.pdf', 'PENDING', NULL, '2025-11-03'),
(1, 6, 'cv/rohan.pdf', 'PENDING', NULL, '2025-11-03'),

(2, 2, 'cv/riya.pdf', 'PENDING', NULL, '2025-11-02'),
(2, 4, 'cv/meera.pdf', 'PENDING', NULL, '2025-11-02'),
(2, 7, 'cv/sneha.pdf', 'PENDING', NULL, '2025-11-04'),
(2, 8, 'cv/aishwarya.pdf', 'PENDING', NULL, '2025-11-04');