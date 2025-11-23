package com.iiitb.erp.placement.service;

import com.iiitb.erp.placement.entity.Employee;
import com.iiitb.erp.placement.repository.EmployeeRepository;
import com.iiitb.erp.placement.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private JwtUtil jwtUtil;

    public String login(String email, String password) {
        Employee employee = employeeRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Invalid email"));

        if (!employee.getPassword().equals(password)) {
            throw new RuntimeException("Invalid password");
        }

        return jwtUtil.generateToken(employee.getEmail(), employee.getRole());
    }
}