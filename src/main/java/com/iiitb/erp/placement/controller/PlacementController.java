package com.iiitb.erp.placement.controller;

import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.dto.AppliedStudentDTO;
import com.iiitb.erp.placement.service.PlacementService;
import com.iiitb.erp.placement.service.PlacementStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/offers")
public class PlacementController {

    @Autowired
    private PlacementService placementService;

    @Autowired
    private PlacementStudentService placementStudentService;

    @GetMapping
    public List<Placement> getAllOffers() {
        return placementService.getAllOffers();
    }

    @GetMapping("/{id}")
    public Placement getOfferById(@PathVariable Long id) {
        return placementService.getOfferById(id);
    }

    @GetMapping("/{id}/applications")
    public List<AppliedStudentDTO> getAppliedStudents(@PathVariable Long id) {
        return placementStudentService.getAppliedStudents(id);
    }
}
