package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "employees")
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "employee_id")
    private Integer employee_id; // Changed from Long to Integer

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(unique = true, nullable = false)
    private String email;

    private String title;

    private String password;

    private String role;   // OUTREACH

    @Column(name = "photograph_path")
    private String photographPath;

    @Column(name = "department_id")
    private Integer departmentId;
}