package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "placement")
@Data
public class Placement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "placement_id")
    private Long id;

    @Column(name = "organisation_id")
    private Long organisationId;

    private String profile;

    private String description;

    @Column(name = "minimum_grade")
    private Double minGrade;
}