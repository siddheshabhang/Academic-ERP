package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.PlacementStudent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlacementStudentRepository extends JpaRepository<PlacementStudent, Integer> {

    List<PlacementStudent> findByPlacementId(Integer placementId);

    PlacementStudent findByPlacementIdAndStudentId(Integer placementId, Integer studentId);
}