package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;

@Entity
@Table(name = "placement_student")
@Data
public class PlacementStudent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "placement_id")
    private Long placementId;

    @Column(name = "student_id")
    private Long studentId;

    @Column(name = "cv_path")
    private String cvPath;

    private String acceptance;   // PENDING / SELECTED / REJECTED

    private String comments;

    @Column(name = "application_date")
    private Date applicationDate;
}