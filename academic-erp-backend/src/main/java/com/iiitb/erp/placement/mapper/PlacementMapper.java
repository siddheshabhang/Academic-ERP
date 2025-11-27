package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.PlacementDTO;
import com.iiitb.erp.placement.entity.Placement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PlacementMapper {

    @Autowired
    private OrganisationMapper organisationMapper;

    /**
     * Convert Placement entity to PlacementDTO
     * 
     * @param placement Placement entity
     * @return PlacementDTO
     */
    public PlacementDTO toDTO(Placement placement) {
        if (placement == null) {
            return null;
        }

        return new PlacementDTO(
                placement.getId(),
                organisationMapper.toDTO(placement.getOrganisation()),
                placement.getProfile(),
                placement.getDescription(),
                placement.getIntake(),
                placement.getMinGrade());
    }

    /**
     * Convert Placement entity to PlacementDTO (alternative method name for
     * clarity)
     * 
     * @param placement Placement entity
     * @return PlacementDTO
     */
    public PlacementDTO entityToDTO(Placement placement) {
        return toDTO(placement);
    }
}
