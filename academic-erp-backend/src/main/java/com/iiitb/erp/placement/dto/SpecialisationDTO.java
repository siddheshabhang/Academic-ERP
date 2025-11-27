package com.iiitb.erp.placement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SpecialisationDTO {
    private Integer id;
    private String code;
    private String name;
    private String description;
    private Integer year;
    private Integer creditsRequired;
}
