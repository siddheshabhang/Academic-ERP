package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "placement")
@Data
public class Placement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long placement_id;

    private Long organisation_id;

    private String profile;

    private String description;

    private Double minimum_grade;   // CGPA cutoff
}