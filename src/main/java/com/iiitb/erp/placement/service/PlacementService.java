package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.entity.Placement;
import com.iiitb.erp.placement.repository.PlacementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlacementService {

    @Autowired
    private PlacementRepository placementRepository;

    public List<Placement> getAllOffers() {
        return placementRepository.findAll();
    }

    public Placement getOfferById(Long id) {
        return placementRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Offer not found with ID: " + id));
    }
}