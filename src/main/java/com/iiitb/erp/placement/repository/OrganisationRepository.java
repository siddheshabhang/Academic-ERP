package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.Organisation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrganisationRepository extends JpaRepository<Organisation, Long> {
}