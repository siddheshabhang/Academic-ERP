package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.OrganisationDTO;
import com.iiitb.erp.placement.entity.Organisation;
import org.springframework.stereotype.Component;

@Component
public class OrganisationMapper {

    /**
     * Convert Organisation entity to OrganisationDTO
     * 
     * @param organisation Organisation entity
     * @return OrganisationDTO
     */
    public OrganisationDTO toDTO(Organisation organisation) {
        if (organisation == null) {
            return null;
        }

        return new OrganisationDTO(
                organisation.getId(),
                organisation.getName(),
                organisation.getAddress());
    }

    /**
     * Convert Organisation entity to OrganisationDTO (alternative method name for
     * clarity)
     * 
     * @param organisation Organisation entity
     * @return OrganisationDTO
     */
    public OrganisationDTO entityToDTO(Organisation organisation) {
        return toDTO(organisation);
    }
}
