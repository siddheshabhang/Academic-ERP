package com.iiitb.erp.placement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlacementDTO {
    private Integer id;
    private OrganisationDTO organisation; // Nested object for frontend compatibility
    private String profile;
    private String description;
    private Integer intake;
    private Double minGrade;
}
