package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "student")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long studentId;

    @Column(name = "roll_no")
    private String rollNo;

    @Column(name = "name")
    private String name;

    @Column(name = "program")
    private String program;

    @Column(name = "branch")
    private String branch;

    @Column(name = "graduation_year")
    private Integer graduationYear;

    @Column(name = "cgpa")
    private Double cgpa;
}