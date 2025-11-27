-- ============================================================
-- Insert Additional Students and Placement Applications
-- Run this at runtime to add more test data
-- ============================================================

USE placementdb;

-- ============================================================
-- Insert Additional Students
-- ============================================================

INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
-- M.Tech CSE - Data Science (High performers)
(11, 'MT2024013', 'Priya', 'Reddy', 'priya.reddy@iiitb.ac.in', 3.85, 64, 2024, 1, 2),
(12, 'MT2024014', 'Karan', 'Joshi', 'karan.joshi@iiitb.ac.in', 3.75, 64, 2024, 1, 2),
(13, 'MT2024015', 'Sneha', 'Desai', 'sneha.desai@iiitb.ac.in', 3.65, 64, 2024, 1, 2),

-- M.Tech CSE - Theory & Systems
(14, 'MT2024003', 'Amit', 'Kumar', 'amit.kumar@iiitb.ac.in', 3.55, 64, 2024, 1, 1),
(15, 'MT2024004', 'Neha', 'Singh', 'neha.singh@iiitb.ac.in', 3.45, 64, 2024, 1, 1),
(16, 'MT2024005', 'Rajesh', 'Nair', 'rajesh.nair@iiitb.ac.in', 3.7, 64, 2024, 1, 1),

-- iMTech - AI (High CGPA students)
(17, 'IMT2019003', 'Divya', 'Menon', 'divya.menon@iiitb.ac.in', 3.88, 120, 2024, 3, 6),
(18, 'IMT2019004', 'Nikhil', 'Agarwal', 'nikhil.agarwal@iiitb.ac.in', 3.92, 120, 2024, 3, 6),

-- M.Tech ECE - VLSI
(19, 'MT2024052', 'Pooja', 'Bhat', 'pooja.bhat@iiitb.ac.in', 3.6, 64, 2024, 2, 4),
(20, 'MT2024053', 'Manish', 'Sharma', 'manish.sharma@iiitb.ac.in', 3.35, 64, 2024, 2, 4),

-- MS Research - Networking
(21, 'MS2024002', 'Tanvi', 'Kapoor', 'tanvi.kapoor@iiitb.ac.in', 3.5, 40, 2024, 4, 3),
(22, 'MS2024003', 'Suraj', 'Pillai', 'suraj.pillai@iiitb.ac.in', 3.25, 40, 2024, 4, 3),

-- M.Tech CSE - Networking & Comm
(23, 'MT2024020', 'Riya', 'Shetty', 'riya.shetty@iiitb.ac.in', 3.4, 64, 2024, 1, 3),
(24, 'MT2024021', 'Varun', 'Khanna', 'varun.khanna@iiitb.ac.in', 3.6, 64, 2024, 1, 3),

-- iMTech - Digital Society
(25, 'IMT2019005', 'Anushka', 'Rao', 'anushka.rao@iiitb.ac.in', 3.3, 120, 2024, 3, 5);

-- ============================================================
-- Insert Additional Placement Applications
-- ============================================================

-- Google Applications (placement_id = 1, requires CGPA >= 3.5)
-- Eligible: M.Tech CSE and iMTech with high CGPA
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(1, 11, 'cv_priya.pdf', 'ML enthusiast with strong coding skills', FALSE, '2024-08-02'),
(1, 17, 'cv_divya.pdf', 'AI researcher with publications', FALSE, '2024-08-02'),
(1, 18, 'cv_nikhil.pdf', 'Deep learning expert', FALSE, '2024-08-02');

-- Amazon Applications (placement_id = 2, requires CGPA >= 3.0)
-- Open to all domains
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(2, 11, 'cv_priya_amzn.pdf', 'Backend developer, AWS certified', FALSE, '2024-08-06'),
(2, 14, 'cv_amit.pdf', 'System design expertise', FALSE, '2024-08-06'),
(2, 15, 'cv_neha.pdf', 'Cloud architecture experience', FALSE, '2024-08-06'),
(2, 16, 'cv_rajesh.pdf', 'Distributed systems knowledge', FALSE, '2024-08-06'),
(2, 23, 'cv_riya.pdf', 'Network programming skills', FALSE, '2024-08-06'),
(2, 24, 'cv_varun.pdf', 'Full stack developer', FALSE, '2024-08-06');

-- Goldman Sachs Applications (placement_id = 3, requires CGPA >= 3.8)
-- Preference for Data Science and AI specializations
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(3, 11, 'cv_priya_gs.pdf', 'Quantitative analysis background', FALSE, '2024-08-11'),
(3, 17, 'cv_divya_gs.pdf', 'Machine learning for finance', FALSE, '2024-08-11'),
(3, 18, 'cv_nikhil_gs.pdf', 'Strong mathematical foundation', FALSE, '2024-08-11');

-- Cisco Applications (placement_id = 4, requires CGPA >= 3.2)
-- Networking and VLSI focus
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(4, 19, 'cv_pooja.pdf', 'VLSI design internship experience', FALSE, '2024-08-16'),
(4, 21, 'cv_tanvi.pdf', 'Network security research', FALSE, '2024-08-16'),
(4, 23, 'cv_riya_cisco.pdf', 'TCP/IP protocol implementation', FALSE, '2024-08-16'),
(4, 24, 'cv_varun_cisco.pdf', 'Network automation projects', FALSE, '2024-08-16');

-- Flipkart Applications (placement_id = 5, requires CGPA >= 3.6)
-- Data Science focus
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(5, 11, 'cv_priya_fk.pdf', 'E-commerce analytics projects', FALSE, '2024-08-20'),
(5, 12, 'cv_karan.pdf', 'Recommendation systems expert', FALSE, '2024-08-20'),
(5, 13, 'cv_sneha.pdf', 'Big data processing experience', FALSE, '2024-08-20'),
(5, 17, 'cv_divya_fk.pdf', 'Product analytics background', FALSE, '2024-08-20');

-- Samsung R&D Applications (placement_id = 6, requires CGPA >= 3.7)
-- Research in AI/ML
INSERT INTO placement_student (placement_id, student_id, cv_application, about, acceptance, date) VALUES
(6, 17, 'cv_divya_samsung.pdf', 'Computer vision research', FALSE, '2024-08-25'),
(6, 18, 'cv_nikhil_samsung.pdf', 'NLP and speech recognition', FALSE, '2024-08-25'),
(6, 11, 'cv_priya_samsung.pdf', 'Mobile AI optimization', FALSE, '2024-08-25');

-- ============================================================
-- Summary of Insertions
-- ============================================================
-- Total new students: 15 (IDs 11-25)
-- Total new applications: 29
-- Distribution:
--   Google: 3 new applications
--   Amazon: 6 new applications
--   Goldman Sachs: 3 new applications
--   Cisco: 4 new applications
--   Flipkart: 4 new applications
--   Samsung R&D: 3 new applications
