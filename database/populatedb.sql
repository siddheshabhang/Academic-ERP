-- ============================================================
-- FILE 1: reset_and_delete_all_data.sql
-- PURPOSE: Delete all existing data from all tables
-- ============================================================

-- Disable foreign key checks to allow deletion
SET FOREIGN_KEY_CHECKS=0;

-- Delete all data from all tables
DELETE FROM placement_student;
DELETE FROM placement_filter;
DELETE FROM placement;
DELETE FROM organisations;
DELETE FROM student_payment;
DELETE FROM student_bills;
DELETE FROM grades;
DELETE FROM students;
DELETE FROM domains;
DELETE FROM specialisation;
DELETE FROM employees;
DELETE FROM departments;
DELETE FROM hostel;
DELETE FROM swap_application;
DELETE FROM alumni;
DELETE FROM alumni_education;
DELETE FROM alumni_organisation;

-- Reset AUTO_INCREMENT counters for tables with identity columns
ALTER TABLE placement_student AUTO_INCREMENT = 1;
ALTER TABLE placement_filter AUTO_INCREMENT = 1;
ALTER TABLE organisations AUTO_INCREMENT = 1;
ALTER TABLE student_payment AUTO_INCREMENT = 1;
ALTER TABLE student_bills AUTO_INCREMENT = 1;
ALTER TABLE grades AUTO_INCREMENT = 1;
ALTER TABLE employees AUTO_INCREMENT = 1;
ALTER TABLE departments AUTO_INCREMENT = 1;
ALTER TABLE hostel AUTO_INCREMENT = 1;
ALTER TABLE swap_application AUTO_INCREMENT = 1;
ALTER TABLE alumni AUTO_INCREMENT = 1;
ALTER TABLE alumni_education AUTO_INCREMENT = 1;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- ============================================================
-- FILE 2: insert_fresh_iiitb_test_data.sql
-- PURPOSE: Insert fresh test data with real IIIT-B companies
-- ============================================================

-- ========== INSERT DEPARTMENTS ==========
INSERT INTO departments (department_id, name, capacity) VALUES
(1, 'OUTREACH', 10),
(2, 'ACCOUNTS', 5),
(3, 'ADMIN', 8),
(4, 'ESTATE', 6);

-- ========== INSERT ORGANISATIONS (Real Companies that Hire from IIIT-B) ==========
INSERT INTO organisations (id, name, address) VALUES
(1, 'Cisco Systems India', 'Bangalore, Karnataka'),
(2, 'Amazon India', 'Bangalore, Karnataka'),
(3, 'Microsoft India', 'Bangalore, Karnataka'),
(4, 'Google India', 'Bangalore, Karnataka'),
(5, 'Goldman Sachs India', 'Bangalore, Karnataka'),
(6, 'Flipkart', 'Bangalore, Karnataka'),
(7, 'Uber India', 'Bangalore, Karnataka'),
(8, 'Swiggy', 'Bangalore, Karnataka'),
(9, 'PhonePe', 'Bangalore, Karnataka'),
(10, 'Unacademy', 'Bangalore, Karnataka'),
(11, 'Zoho Corporation', 'Chennai, Tamil Nadu'),
(12, 'PayPal India', 'Bangalore, Karnataka'),
(13, 'Directi', 'Mumbai, Maharashtra'),
(14, 'Atlassian India', 'Bangalore, Karnataka'),
(15, 'Tower Research Capital', 'Bangalore, Karnataka');

-- ========== INSERT DOMAINS (Academic Programs - Updated for IIIT-B) ==========
INSERT INTO domains (domain_id, program, batch, capacity, qualification) VALUES
(1, 'MTECH20', '2020', 80, 'M.Tech'),
(2, 'MS20', '2020', 50, 'M.Sc'),
(3, 'IMTECH20', '2020', 60, 'B.Tech'),
(4, 'MTECH21', '2021', 85, 'M.Tech'),
(5, 'MS21', '2021', 50, 'M.Sc'),
(6, 'IMTECH21', '2021', 65, 'B.Tech'),
(7, 'MTECH22', '2022', 90, 'M.Tech'),
(8, 'MS22', '2022', 55, 'M.Sc'),
(9, 'IMTECH22', '2022', 70, 'B.Tech');

-- ========== INSERT SPECIALISATIONS ==========
INSERT INTO specialisation (specialisation_id, code, name, description, year, credits_required) VALUES
(1, 'CST', 'Theory & Systems', 'Theoretical foundations of computing and systems design', 2, 20),
(2, 'CDS', 'Data Science', 'Data analytics, machine learning and big data technologies', 2, 20),
(3, 'CCV', 'Computer Vision', 'Image processing, computer vision and deep learning', 2, 20),
(4, 'CNS', 'Cyber Security', 'Network security, cryptography and security systems', 2, 20),
(5, 'CML', 'Machine Learning', 'Advanced ML techniques and AI applications', 2, 20),
(6, 'CWD', 'Web Development', 'Full-stack web development and cloud technologies', 2, 20),
(7, 'CCA', 'Cloud & Architecture', 'Cloud computing, microservices and system design', 2, 20),
(8, 'CFI', 'Financial Technology', 'Fintech, blockchain and algorithmic trading', 2, 20);

-- ========== INSERT EMPLOYEES (OUTREACH Staff) ==========
INSERT INTO employees (employee_id, first_name, last_name, email, title, role, department_id) VALUES
(1, 'Priya', 'Kumar', 'priya.outreach@iiitb.ac.in', 'Placement Officer', 'OUTREACH', 1),
(2, 'Rahul', 'Singh', 'rahul.outreach@iiitb.ac.in', 'Placement Coordinator', 'OUTREACH', 1),
(3, 'Anjali', 'Sharma', 'anjali.admin@iiitb.ac.in', 'Administrator', 'ADMIN', 3),
(4, 'Vikram', 'Patel', 'vikram.accounts@iiitb.ac.in', 'Accounts Manager', 'ACCOUNTS', 2);

-- ========== INSERT M.TECH STUDENTS (15 Total - Reduced) ==========
-- MTECH20 Students (8 students)
INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
(1001, 'MTECH20001', 'Aarya', 'Patel', 'aarya.patel@iiitb.ac.in', 3.95, 120, 2022, 1, 1),
(1002, 'MTECH20002', 'Bhavana', 'Sharma', 'bhavana.sharma@iiitb.ac.in', 3.85, 120, 2022, 1, 2),
(1003, 'MTECH20003', 'Chirag', 'Gupta', 'chirag.gupta@iiitb.ac.in', 3.75, 120, 2022, 1, 1),
(1004, 'MTECH20004', 'Deepak', 'Verma', 'deepak.verma@iiitb.ac.in', 3.88, 120, 2022, 1, 3),
(1005, 'MTECH20005', 'Esha', 'Malhotra', 'esha.malhotra@iiitb.ac.in', 3.82, 120, 2022, 1, 2),
(1006, 'MTECH20006', 'Farhan', 'Khan', 'farhan.khan@iiitb.ac.in', 3.70, 120, 2022, 1, 4),
(1007, 'MTECH20007', 'Gita', 'Nair', 'gita.nair@iiitb.ac.in', 3.92, 120, 2022, 1, 5),

-- MTECH21 Students (7 students)
(1008, 'MTECH21001', 'Harsh', 'Yadav', 'harsh.yadav@iiitb.ac.in', 3.91, 120, 2023, 4, 1),
(1009, 'MTECH21002', 'Ishita', 'Sinha', 'ishita.sinha@iiitb.ac.in', 3.84, 120, 2023, 4, 2),
(1010, 'MTECH21003', 'Jatin', 'Desai', 'jatin.desai@iiitb.ac.in', 3.76, 120, 2023, 4, 5),
(1011, 'MTECH21004', 'Karan', 'Singh', 'karan.singh@iiitb.ac.in', 3.80, 120, 2023, 4, 3),
(1012, 'MTECH21005', 'Lakshmi', 'Reddy', 'lakshmi.reddy@iiitb.ac.in', 3.93, 120, 2023, 4, 2),
(1013, 'MTECH21006', 'Meera', 'Iyer', 'meera.iyer@iiitb.ac.in', 3.85, 120, 2023, 4, 1),
(1014, 'MTECH21007', 'Nikhil', 'Sharma', 'nikhil.sharma@iiitb.ac.in', 3.78, 120, 2023, 4, 4);

-- ========== INSERT MS (M.Sc) STUDENTS (10 Total - NEW) ==========
-- MS20 Students (5 students)
INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
(2001, 'MS20001', 'Olivia', 'D\'Souza', 'olivia.dsouza@iiitb.ac.in', 3.89, 100, 2022, 2, 2),
(2002, 'MS20002', 'Priya', 'Rao', 'priya.rao@iiitb.ac.in', 3.87, 100, 2022, 2, 1),
(2003, 'MS20003', 'Quentin', 'Miller', 'quentin.miller@iiitb.ac.in', 3.78, 100, 2022, 2, 4),
(2004, 'MS20004', 'Rishi', 'Kumar', 'rishi.kumar@iiitb.ac.in', 3.81, 100, 2022, 2, 2),
(2005, 'MS20005', 'Samira', 'Khan', 'samira.khan@iiitb.ac.in', 3.84, 100, 2022, 2, 3),

-- MS21 Students (5 students)
(2006, 'MS21001', 'Tushar', 'Joshi', 'tushar.joshi@iiitb.ac.in', 3.90, 100, 2023, 5, 1),
(2007, 'MS21002', 'Uma', 'Patel', 'uma.patel@iiitb.ac.in', 3.82, 100, 2023, 5, 5),
(2008, 'MS21003', 'Vikram', 'Verma', 'vikram.verma@iiitb.ac.in', 3.86, 100, 2023, 5, 2),
(2009, 'MS21004', 'Wina', 'Singh', 'wina.singh@iiitb.ac.in', 3.79, 100, 2023, 5, 3),
(2010, 'MS21005', 'Xenon', 'Sharma', 'xenon.sharma@iiitb.ac.in', 3.88, 100, 2023, 5, 4);

-- ========== INSERT B.TECH STUDENTS (10 Total) ==========
-- IMTECH20 Students (3 students)
INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
(3001, 'IMTECH20001', 'Yash', 'Desai', 'yash.desai@iiitb.ac.in', 3.75, 120, 2022, 3, 1),
(3002, 'IMTECH20002', 'Zara', 'Khan', 'zara.khan@iiitb.ac.in', 3.70, 120, 2022, 3, 2),
(3003, 'IMTECH20003', 'Arjun', 'Nair', 'arjun.nair@iiitb.ac.in', 3.65, 120, 2022, 3, 4),

-- IMTECH21 Students (3 students)
(3004, 'IMTECH21001', 'Bhavna', 'Chopra', 'bhavna.chopra@iiitb.ac.in', 3.80, 110, 2023, 6, 1),
(3005, 'IMTECH21002', 'Chhavi', 'Saxena', 'chhavi.saxena@iiitb.ac.in', 3.72, 110, 2023, 6, 3),
(3006, 'IMTECH21003', 'Diya', 'Verma', 'diya.verma@iiitb.ac.in', 3.68, 110, 2023, 6, 2),

-- IMTECH22 Students (4 students)
(3007, 'IMTECH22001', 'Eshaan', 'Kumar', 'eshaan.kumar@iiitb.ac.in', 3.77, 100, 2024, 9, 1),
(3008, 'IMTECH22002', 'Fiona', 'Singh', 'fiona.singh@iiitb.ac.in', 3.73, 100, 2024, 9, 5),
(3009, 'IMTECH22003', 'Gaurav', 'Joshi', 'gaurav.joshi@iiitb.ac.in', 3.81, 100, 2024, 9, 2),
(3010, 'IMTECH22004', 'Hana', 'Patel', 'hana.patel@iiitb.ac.in', 3.74, 100, 2024, 9, 3);

-- ========== INSERT PLACEMENT OFFERS (From Real IIIT-B Companies) ==========
INSERT INTO placement (id, organisation_id, profile, description, intake, minimum_grade) VALUES
(1, 1, 'Software Engineer - Systems', 'Cisco IOS/Networking Systems Development', 6, 3.5),
(2, 2, 'Backend Engineer', 'Amazon Web Services and backend systems', 8, 3.6),
(3, 3, 'Cloud Solutions Architect', 'Azure cloud infrastructure design', 5, 3.7),
(4, 4, 'Machine Learning Engineer', 'Google AI and ML research', 4, 3.75),
(5, 5, 'Quantitative Analyst', 'Goldman Sachs trading and modeling', 3, 3.8),
(6, 6, 'Data Engineer', 'Flipkart recommendation systems', 7, 3.55),
(7, 7, 'Backend Developer', 'Uber platform services', 6, 3.6),
(8, 8, 'Full Stack Engineer', 'Swiggy mobile and web platforms', 5, 3.5),
(9, 9, 'Payments Engineer', 'PhonePe payment infrastructure', 4, 3.65),
(10, 10, 'Software Engineer', 'Unacademy learning platform', 5, 3.4),
(11, 11, 'AI/ML Engineer', 'Zoho AI capabilities', 4, 3.6),
(12, 12, 'Risk Analyst', 'PayPal fraud detection and risk', 3, 3.7),
(13, 13, 'Distributed Systems Engineer', 'Directi cloud infrastructure', 5, 3.55),
(14, 14, 'DevOps Engineer', 'Atlassian cloud operations', 4, 3.5),
(15, 15, 'Trading Systems Engineer', 'Tower Research low-latency systems', 3, 3.8);

-- ========== INSERT PLACEMENT FILTERS (Domain/Specialisation Constraints) ==========
-- Cisco: Prefer M.Tech, Systems/Networks
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(1, 1, 1),   -- Cisco: MTECH20, Theory & Systems
(1, 4, 1),   -- Cisco: MTECH21, Theory & Systems

-- Amazon: Backend focus, open to M.Tech and MS
(2, 1, 2),   -- Amazon: MTECH20, Data Science
(2, 4, 2),   -- Amazon: MTECH21, Data Science
(2, 2, NULL), -- Amazon: MS20, any

-- Microsoft: Cloud solutions
(3, NULL, 7), -- Microsoft: Any M.Tech/MS, Cloud & Architecture

-- Google: ML/AI focus
(4, NULL, 3), -- Google: Any M.Tech/MS, Computer Vision
(4, NULL, 5), -- Google: Any M.Tech/MS, Machine Learning

-- Goldman Sachs: Quantitative focus, M.Tech preferred
(5, NULL, 8), -- Goldman Sachs: Any M.Tech, Fintech

-- Flipkart: Data engineers
(6, NULL, 2), -- Flipkart: Any M.Tech/MS, Data Science

-- Uber: Backend, open
(7, 1, NULL), -- Uber: MTECH20, any
(7, 4, NULL), -- Uber: MTECH21, any

-- Swiggy: Full stack
(8, 1, 6),   -- Swiggy: MTECH20, Web Development
(8, 4, 6),   -- Swiggy: MTECH21, Web Development

-- PhonePe: Payments focus
(9, NULL, 8), -- PhonePe: Any M.Tech/MS, Fintech

-- Unacademy: Open to all
(10, NULL, NULL), -- Unacademy: All batches

-- Zoho: AI/ML
(11, NULL, 5), -- Zoho: Any M.Tech/MS, Machine Learning

-- PayPal: Risk analysis
(12, NULL, 4), -- PayPal: Any M.Tech/MS, Cyber Security

-- Directi: Distributed systems
(13, NULL, 7), -- Directi: Any M.Tech/MS, Cloud & Architecture

-- Atlassian: DevOps
(14, 1, 7),   -- Atlassian: MTECH20, Cloud & Architecture
(14, 4, 7),   -- Atlassian: MTECH21, Cloud & Architecture

-- Tower Research: Trading systems
(15, NULL, 8); -- Tower Research: Any M.Tech, Fintech

-- ========== INSERT PLACEMENT APPLICATIONS (Real Scenarios) ==========
-- Cisco Applications
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(1, 1001, 'cv_aarya_patel.pdf', 'Strong systems background', true, '2024-01-10'),   -- SELECTED
(1, 1004, 'cv_deepak_verma.pdf', 'Computer vision and systems expert', true, '2024-01-11'),  -- SELECTED
(1, 1008, 'cv_harsh_yadav.pdf', 'Networking enthusiast', false, '2024-01-12'),
(1, 1009, 'cv_ishita_sinha.pdf', 'Systems architecture focus', false, '2024-01-12'),

-- Amazon Applications
(2, 1002, 'cv_bhavana_sharma.pdf', 'AWS certified engineer', true, '2024-01-14'),  -- SELECTED
(2, 1005, 'cv_esha_malhotra.pdf', 'Data engineering specialist', false, '2024-01-15'),
(2, 2001, 'cv_olivia_dsouza.pdf', 'ML and backend development', false, '2024-01-15'),
(2, 2004, 'cv_rishi_kumar.pdf', 'Backend developer', false, '2024-01-16'),

-- Microsoft Applications
(3, 1007, 'cv_gita_nair.pdf', 'Cloud architecture expert', true, '2024-01-17'),  -- SELECTED
(3, 2006, 'cv_tushar_joshi.pdf', 'Azure platform knowledge', false, '2024-01-17'),

-- Google Applications
(4, 1004, 'cv_deepak_verma.pdf', 'Computer vision researcher', false, '2024-01-18'),
(4, 2002, 'cv_priya_rao.pdf', 'ML and DL specialist', false, '2024-01-18'),
(4, 2009, 'cv_wina_singh.pdf', 'Recent AI ML graduate', false, '2024-01-19'),

-- Goldman Sachs Applications
(5, 1003, 'cv_chirag_gupta.pdf', 'Financial modeling expertise', true, '2024-01-20'),  -- SELECTED
(5, 2010, 'cv_xenon_sharma.pdf', 'Quantitative analysis background', false, '2024-01-20'),

-- Flipkart Applications
(6, 1002, 'cv_bhavana_sharma.pdf', 'Data science and analytics', false, '2024-01-21'),
(6, 2001, 'cv_olivia_dsouza.pdf', 'Big data engineering', false, '2024-01-21'),
(6, 2008, 'cv_vikram_verma.pdf', 'Data engineering focus', false, '2024-01-22'),

-- Uber Applications
(7, 1001, 'cv_aarya_patel.pdf', 'Backend systems engineer', false, '2024-01-22'),
(7, 1008, 'cv_harsh_yadav.pdf', 'Microservices architect', false, '2024-01-23'),
(7, 1010, 'cv_jatin_desai.pdf', 'Full stack developer', false, '2024-01-23'),

-- Swiggy Applications
(8, 1006, 'cv_farhan_khan.pdf', 'Web development expert', false, '2024-01-24'),
(8, 1013, 'cv_meera_iyer.pdf', 'Full stack engineer', false, '2024-01-24'),
(8, 2007, 'cv_uma_patel.pdf', 'Frontend and backend skills', false, '2024-01-25'),

-- PhonePe Applications
(9, 1011, 'cv_karan_singh.pdf', 'Fintech background', true, '2024-01-26'),  -- SELECTED
(9, 2005, 'cv_samira_khan.pdf', 'Blockchain and payments', false, '2024-01-26'),

-- Unacademy Applications
(10, 1012, 'cv_lakshmi_reddy.pdf', 'EdTech platform development', true, '2024-01-27'),  -- SELECTED
(10, 2003, 'cv_quentin_miller.pdf', 'Learning platform engineer', false, '2024-01-27'),

-- Zoho Applications
(11, 1014, 'cv_nikhil_sharma.pdf', 'AI/ML research experience', false, '2024-01-28'),
(11, 2010, 'cv_xenon_sharma.pdf', 'Machine learning specialist', false, '2024-01-28'),

-- PayPal Applications
(12, 2009, 'cv_wina_singh.pdf', 'Cybersecurity focus', false, '2024-01-29'),
(12, 3005, 'cv_chhavi_saxena.pdf', 'Security researcher', false, '2024-01-29'),

-- Directi Applications
(13, 1007, 'cv_gita_nair.pdf', 'Cloud infrastructure expert', false, '2024-01-30'),
(13, 1010, 'cv_jatin_desai.pdf', 'Distributed systems engineer', false, '2024-01-30'),

-- Atlassian Applications
(14, 1008, 'cv_harsh_yadav.pdf', 'DevOps and CI/CD specialist', false, '2024-02-01'),
(14, 1013, 'cv_meera_iyer.pdf', 'Cloud operations engineer', false, '2024-02-01'),

-- Tower Research Applications
(15, 1003, 'cv_chirag_gupta.pdf', 'Algorithmic trading background', false, '2024-02-02'),
(15, 1009, 'cv_ishita_sinha.pdf', 'Financial systems developer', false, '2024-02-02'),

-- Also add some B.Tech and MS students applying
(2, 3001, 'cv_yash_desai.pdf', 'Backend development skills', false, '2024-02-03'),
(6, 3004, 'cv_bhavna_chopra.pdf', 'Data science enthusiast', false, '2024-02-03'),
(10, 3009, 'cv_gaurav_joshi.pdf', 'Platform development', false, '2024-02-04');

-- ============================================================
