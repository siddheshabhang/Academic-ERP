package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.PlacementStudent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlacementStudentRepository extends JpaRepository<PlacementStudent, Long> {

    List<PlacementStudent> findByPlacementId(Long placementId);

    boolean existsByPlacementIdAndStudentId(Long placementId, Long studentId);

    long countByPlacementId(Long placementId);
}