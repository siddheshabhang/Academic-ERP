package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.Specialisation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SpecialisationRepository extends JpaRepository<Specialisation, Integer> {
}