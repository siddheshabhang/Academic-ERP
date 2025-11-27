package com.iiitb.erp.placement.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "placement_filter")
@Data
public class PlacementFilter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "placement_id")
    private Placement placement;

    @ManyToOne
    @JoinColumn(name = "domain_id")
    private Domain domain;

    @ManyToOne
    @JoinColumn(name = "specialisation_id")
    private Specialisation specialisation;
}