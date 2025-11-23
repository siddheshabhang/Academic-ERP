package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "employees")
@Data
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long employee_id;

    private String first_name;

    private String last_name;

    @Column(unique = true, nullable = false)
    private String email;

    private String password;

    private String role;   // OUTREACH
}