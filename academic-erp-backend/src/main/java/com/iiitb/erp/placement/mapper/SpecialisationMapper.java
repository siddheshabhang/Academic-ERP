package com.iiitb.erp.placement.mapper;

import com.iiitb.erp.placement.dto.SpecialisationDTO;
import com.iiitb.erp.placement.entity.Specialisation;
import org.springframework.stereotype.Component;

@Component
public class SpecialisationMapper {

    /**
     * Convert Specialisation entity to SpecialisationDTO
     * 
     * @param specialisation Specialisation entity
     * @return SpecialisationDTO
     */
    public SpecialisationDTO toDTO(Specialisation specialisation) {
        if (specialisation == null) {
            return null;
        }

        return new SpecialisationDTO(
                specialisation.getId(),
                specialisation.getCode(),
                specialisation.getName(),
                specialisation.getDescription(),
                specialisation.getYear(),
                specialisation.getCredits_required());
    }

    /**
     * Convert Specialisation entity to SpecialisationDTO (alternative method name
     * for clarity)
     * 
     * @param specialisation Specialisation entity
     * @return SpecialisationDTO
     */
    public SpecialisationDTO entityToDTO(Specialisation specialisation) {
        return toDTO(specialisation);
    }
}
