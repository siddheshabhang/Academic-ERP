package com.iiitb.erp.placement.config;

import com.iiitb.erp.placement.entity.Employee;
import com.iiitb.erp.placement.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CustomJwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Override
    public AbstractAuthenticationToken convert(Jwt jwt) {
        // 1. Get email from the token (simulating Google's token structure)
        String email = jwt.getClaimAsString("email");

        List<GrantedAuthority> authorities = new ArrayList<>();

        // 2. Check Database for this email
        if (email != null) {
            Employee employee = employeeRepository.findByEmail(email).orElse(null);

            // 3. CRITICAL CHECK: Does the user exist AND is their role "OUTREACH"?
            if (employee != null && "OUTREACH".equalsIgnoreCase(employee.getRole())) {
                authorities.add(new SimpleGrantedAuthority("SCOPE_OUTREACH"));
            }
        }

        return new JwtAuthenticationToken(jwt, authorities);
    }
}