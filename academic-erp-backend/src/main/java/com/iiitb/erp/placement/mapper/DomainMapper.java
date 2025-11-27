package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.DomainDTO;
import com.iiitb.erp.placement.entity.Domain;
import org.springframework.stereotype.Component;

@Component
public class DomainMapper {

    /**
     * Convert Domain entity to DomainDTO
     * 
     * @param domain Domain entity
     * @return DomainDTO
     */
    public DomainDTO toDTO(Domain domain) {
        if (domain == null) {
            return null;
        }

        return new DomainDTO(
                domain.getId(),
                domain.getProgram(),
                domain.getBatch(),
                domain.getCapacity(),
                domain.getQualification());
    }

    /**
     * Convert Domain entity to DomainDTO (alternative method name for clarity)
     * 
     * @param domain Domain entity
     * @return DomainDTO
     */
    public DomainDTO entityToDTO(Domain domain) {
        return toDTO(domain);
    }
}
