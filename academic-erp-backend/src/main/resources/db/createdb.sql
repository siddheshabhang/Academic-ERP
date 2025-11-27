-- ============================================================
-- Database Creation Script for Academic ERP / Placement System
-- ============================================================

-- Disable foreign key checks to allow dropping tables
SET FOREIGN_KEY_CHECKS=0;

-- Drop existing tables to ensure a clean slate
DROP TABLE IF EXISTS placement_student;
DROP TABLE IF EXISTS placement_filter;
DROP TABLE IF EXISTS placement;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS specialisation;
DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS organisations;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- ============================================================
-- 1. Master Tables (Independent)
-- ============================================================

-- Organisations (Companies hiring students)
CREATE TABLE organisations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Departments (Internal departments like Outreach, Admin)
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    capacity INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Domains (Academic Programs e.g., M.Tech, iM.Tech)
CREATE TABLE domains (
    domain_id INT PRIMARY KEY,
    program VARCHAR(50) NOT NULL UNIQUE,
    batch VARCHAR(10),
    capacity INT,
    qualification VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Specialisations (Streams e.g., CSE, Data Science)
CREATE TABLE specialisation (
    specialisation_id INT PRIMARY KEY,
    code VARCHAR(20) UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    year INT,
    credits_required INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 2. Entity Tables (Dependent on Masters)
-- ============================================================

-- Employees (Staff members)
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    title VARCHAR(100),
    password VARCHAR(255), -- In production, store hashed passwords
    role VARCHAR(50),
    photograph_path VARCHAR(255),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Students
CREATE TABLE students (
    student_id INT PRIMARY KEY, -- Using Roll Number or ID as PK
    roll_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    photograph_path VARCHAR(255),
    cgpa DOUBLE,
    total_credits INT,
    graduation_year INT,
    domain_id INT,
    specialisation_id INT,
    placement_id INT, -- To track if placed (can be NULL)
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation(specialisation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Placements (Job Offers)
CREATE TABLE placement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organisation_id INT NOT NULL,
    profile VARCHAR(100) NOT NULL,
    description TEXT,
    intake INT,
    minimum_grade DOUBLE,
    FOREIGN KEY (organisation_id) REFERENCES organisations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. Relation/Mapping Tables
-- ============================================================

-- Placement Filters (Eligibility Criteria)
CREATE TABLE placement_filter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placement_id INT NOT NULL,
    domain_id INT,
    specialisation_id INT,
    FOREIGN KEY (placement_id) REFERENCES placement(id) ON DELETE CASCADE,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id) ON DELETE CASCADE,
    FOREIGN KEY (specialisation_id) REFERENCES specialisation(specialisation_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Placement Applications (Student Applications)
CREATE TABLE placement_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placement_id INT NOT NULL,
    student_id INT NOT NULL,
    cv_application VARCHAR(255),
    about TEXT,
    acceptance BOOLEAN DEFAULT FALSE, -- True if offer accepted
    comments TEXT,
    date DATE,
    FOREIGN KEY (placement_id) REFERENCES placement(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY unique_application (placement_id, student_id) -- Prevent duplicate applications
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
