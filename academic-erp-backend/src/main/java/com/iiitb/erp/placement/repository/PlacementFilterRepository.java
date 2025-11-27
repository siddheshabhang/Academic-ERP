package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.PlacementFilter;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlacementFilterRepository extends JpaRepository<PlacementFilter, Integer> {
    List<PlacementFilter> findByPlacementId(Integer placementId);
}