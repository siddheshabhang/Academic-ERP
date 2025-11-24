package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.Placement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlacementRepository extends JpaRepository<Placement, Integer> {
}