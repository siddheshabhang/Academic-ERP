package com.iiitb.erp.placement.repository;

import com.iiitb.erp.placement.entity.Domain;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DomainRepository extends JpaRepository<Domain, Integer> {
}