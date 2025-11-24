package com.iiitb.erp.placement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;

import java.time.Instant;
import java.util.Map;

@Configuration
public class TestJwtConfig {

    @Bean
    public JwtDecoder jwtDecoder() {
        return token -> {
            return new Jwt(
                    token,
                    Instant.now(),
                    Instant.now().plusSeconds(3600),
                    Map.of("alg", "none"),
                    // CHANGE: Added "OUTREACH" to the scope
                    // In TestJwtConfig.java
                    Map.of("sub", "1", "email", "suresh.outreach@iiitb.ac.in")
            );
        };
    }
}