---------------------------------------
-- ORGANISATIONS
---------------------------------------
CREATE TABLE organisations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    address VARCHAR(255)
);

---------------------------------------
-- EMPLOYEES
---------------------------------------
CREATE TABLE employees (
    employee_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50)
);

---------------------------------------
-- STUDENTS (Full ERP fields, no FK constraints)
---------------------------------------
CREATE TABLE students (
    student_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    roll_number VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    photograph_path VARCHAR(255),
    cgpa DECIMAL(3,2),
    total_credits INT,
    graduation_year INT,
    domain VARCHAR(255),          -- FK removed
    specialisation VARCHAR(255),  -- FK removed
    placement_id BIGINT           -- FK removed
);

---------------------------------------
-- PLACEMENT (Job offers)
---------------------------------------
CREATE TABLE placement (
    placement_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    organisation_id BIGINT,
    profile VARCHAR(255),
    description VARCHAR(500),
    minimum_grade DECIMAL(3,2)
);

---------------------------------------
-- PLACEMENT FILTER (Eligibility rules)
---------------------------------------
CREATE TABLE placement_filter (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    placement_id BIGINT,
    specialisation VARCHAR(255),
    domain VARCHAR(255)
);

---------------------------------------
-- PLACEMENT STUDENT (Applications + Selection)
---------------------------------------
CREATE TABLE placement_student (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    placement_id BIGINT,
    student_id BIGINT,
    cv_path VARCHAR(255),
    acceptance VARCHAR(50),     -- e.g., 'PENDING', 'SELECTED', 'REJECTED'
    comments VARCHAR(500),
    application_date DATE
);