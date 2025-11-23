package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "placement_filter")
@Data
public class PlacementFilter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "placement_id")
    private Long placementId;

    private String specialisation;

    private String domain;
}