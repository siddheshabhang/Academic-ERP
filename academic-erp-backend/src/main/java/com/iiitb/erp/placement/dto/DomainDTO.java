package com.iiitb.erp.placement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DomainDTO {
    private Integer id;
    private String program;
    private String batch;
    private Integer capacity;
    private String qualification;
}
