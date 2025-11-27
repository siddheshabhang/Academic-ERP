-- Create Organisations Table
CREATE TABLE IF NOT EXISTS organisations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Domains Table (Academic Programs)
CREATE TABLE IF NOT EXISTS domains (
    domain_id INT PRIMARY KEY,
    program VARCHAR(50) NOT NULL UNIQUE,
    batch VARCHAR(10),
    capacity INT,
    qualification VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Specialisation Table
CREATE TABLE IF NOT EXISTS specialisation (
    specialisation_id INT PRIMARY KEY,
    code VARCHAR(20) UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    year INT,
    credits_required INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Students Table
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    roll_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    photograph_path VARCHAR(255),
    cgpa DECIMAL(3, 2),
    total_credits INT,
    graduation_year INT,
    domain_id INT,
    specialisation_id INT,
    placement_id INT,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation(specialisation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Placement (Job Offers) Table
CREATE TABLE IF NOT EXISTS placement (
    id INT PRIMARY KEY,
    organisation_id INT NOT NULL,
    profile VARCHAR(100) NOT NULL,
    description TEXT,
    intake INT,
    minimum_grade DECIMAL(3, 2),
    FOREIGN KEY (organisation_id) REFERENCES organisations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create PlacementFilter Table (Domain/Specialisation constraints for offers)
CREATE TABLE IF NOT EXISTS placement_filter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placement_id INT NOT NULL,
    domain_id INT,
    specialisation_id INT,
    FOREIGN KEY (placement_id) REFERENCES placement(id),
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation(specialisation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create PlacementStudent Table (Application records)
CREATE TABLE IF NOT EXISTS placement_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placement_id INT NOT NULL,
    student_id INT NOT NULL,
    cv_application VARCHAR(255),
    about TEXT,
    acceptance BOOLEAN DEFAULT FALSE,
    comments TEXT,
    date DATE,
    FOREIGN KEY (placement_id) REFERENCES placement(id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    UNIQUE KEY unique_application (placement_id, student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Departments Table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    capacity INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Employees Table (Users with role-based access)
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    title VARCHAR(100),
    password VARCHAR(255),
    role VARCHAR(50),
    photograph_path VARCHAR(255),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- FILE 2: insert_placement.sql
-- Purpose: Insert sample data for testing
-- ============================================================

-- Insert Organisations
INSERT INTO organisations (id, name, address) VALUES
(1, 'Google India', 'Bangalore, India'),
(2, 'Microsoft India', 'Hyderabad, India'),
(3, 'Amazon India', 'Bangalore, India'),
(4, 'TCS', 'Mumbai, India'),
(5, 'Infosys', 'Bangalore, India');

-- Insert Domains (Academic Programs)
INSERT INTO domains (domain_id, program, batch, capacity, qualification) VALUES
(1, 'IMT20', '2020', 60, 'B.Tech'),
(2, 'MS20', '2020', 40, 'B.Sc'),
(3, 'IMT21', '2021', 60, 'B.Tech'),
(4, 'MS21', '2021', 40, 'B.Sc');

-- Insert Specialisations
INSERT INTO specialisation (specialisation_id, code, name, description, year, credits_required) VALUES
(1, 'CST', 'Theory & Systems', 'Theoretical foundations of computing', 2, 20),
(2, 'CDS', 'Data Science', 'Data analysis and machine learning', 2, 20),
(3, 'CCV', 'Computer Vision', 'Image processing and computer vision', 2, 20),
(4, 'CML', 'Machine Learning', 'Advanced ML techniques', 2, 20);

-- Insert Departments
INSERT INTO departments (department_id, name, capacity) VALUES
(1, 'OUTREACH', 10),
(2, 'ACCOUNTS', 5),
(3, 'ADMIN', 8);

-- Insert Employees (OUTREACH staff)
INSERT INTO employees (employee_id, first_name, last_name, email, title, role, department_id) VALUES
(1, 'Priya', 'Kumar', 'priya.outreach@iiitb.ac.in', 'Placement Officer', 'OUTREACH', 1),
(2, 'Rahul', 'Singh', 'rahul.outreach@iiitb.ac.in', 'Placement Coordinator', 'OUTREACH', 1),
(3, 'Admin', 'User', 'admin@iiitb.ac.in', 'Administrator', 'ADMIN', 3);

-- Insert Students
INSERT INTO students (student_id, roll_number, first_name, last_name, email, cgpa, total_credits, graduation_year, domain_id, specialisation_id) VALUES
(101, 'IMT20001', 'Aarya', 'Patel', 'aarya.patel@iiitb.ac.in', 3.8, 120, 2022, 1, 1),
(102, 'IMT20002', 'Bhavana', 'Sharma', 'bhavana.sharma@iiitb.ac.in', 3.5, 120, 2022, 1, 2),
(103, 'IMT20003', 'Chirag', 'Gupta', 'chirag.gupta@iiitb.ac.in', 3.2, 120, 2022, 1, 1),
(104, 'IMT20004', 'Deepak', 'Verma', 'deepak.verma@iiitb.ac.in', 3.9, 120, 2022, 1, 3),
(105, 'IMT20005', 'Esha', 'Malhotra', 'esha.malhotra@iiitb.ac.in', 3.6, 120, 2022, 1, 2),
(106, 'MS20001', 'Farhan', 'Khan', 'farhan.khan@iiitb.ac.in', 3.7, 100, 2022, 2, 1),
(107, 'MS20002', 'Gita', 'Nair', 'gita.nair@iiitb.ac.in', 3.4, 100, 2022, 2, 2),
(108, 'IMT21001', 'Harsh', 'Yadav', 'harsh.yadav@iiitb.ac.in', 3.3, 100, 2023, 3, 4),
(109, 'IMT21002', 'Ishita', 'Sinha', 'ishita.sinha@iiitb.ac.in', 3.8, 100, 2023, 3, 3);

-- Insert Placement Offers (Job Openings)
INSERT INTO placement (id, organisation_id, profile, description, intake, minimum_grade) VALUES
(1, 1, 'Software Engineer', 'Backend development role', 5, 3.5),
(2, 2, 'Data Scientist', 'Machine learning focused role', 3, 3.6),
(3, 3, 'Full Stack Developer', 'MERN stack development', 4, 3.3),
(4, 4, 'Associate Consultant', 'Management consulting role', 6, 3.2),
(5, 5, 'Systems Engineer', 'Infrastructure and DevOps', 5, 3.4);

-- Insert Placement Filters (Domain/Specialisation constraints for offers)
INSERT INTO placement_filter (placement_id, domain_id, specialisation_id) VALUES
(1, 1, 1),  -- Google: IMT domain, Theory & Systems specialisation
(1, 1, 3),  -- Google: Also accepts Computer Vision
(2, NULL, 2),  -- Microsoft: Any domain, but Data Science specialisation
(3, 1, NULL),  -- Amazon: IMT domain only, any specialisation
(4, NULL, NULL);  -- TCS: No specific filters, accepts all

-- Insert Placement Applications (Students who applied)
INSERT INTO placement_student (placement_id, student_id, cv_application, acceptance, date) VALUES
(1, 101, 'cv_aarya_patel.pdf', FALSE, '2024-01-15'),
(1, 102, 'cv_bhavana_sharma.pdf', FALSE, '2024-01-16'),
(1, 103, 'cv_chirag_gupta.pdf', FALSE, '2024-01-15'),
(1, 104, 'cv_deepak_verma.pdf', TRUE, '2024-01-14'),  -- Already selected
(2, 102, 'cv_bhavana_sharma.pdf', FALSE, '2024-01-17'),
(2, 105, 'cv_esha_malhotra.pdf', FALSE, '2024-01-17'),
(3, 101, 'cv_aarya_patel.pdf', FALSE, '2024-01-18'),
(3, 103, 'cv_chirag_gupta.pdf', FALSE, '2024-01-18'),
(4, 106, 'cv_farhan_khan.pdf', FALSE, '2024-01-19'),
(4, 107, 'cv_gita_nair.pdf', TRUE, '2024-01-19'),  -- Already selected
(5, 108, 'cv_harsh_yadav.pdf', FALSE, '2024-01-20');
