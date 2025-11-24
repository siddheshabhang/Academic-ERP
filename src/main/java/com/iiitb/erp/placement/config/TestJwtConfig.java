package com.iiitb.erp.placement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;

import java.time.Instant;
import java.util.Map;

@Configuration
public class TestJwtConfig {

    // This bean overrides the standard Google/OAuth2 decoder for LOCAL TESTING ONLY.
    // It accepts ANY token string and treats it as valid.
    @Bean
    public JwtDecoder jwtDecoder() {
        return token -> {
            // Create a dummy authenticated JWT
            return new Jwt(
                    token,
                    Instant.now(),
                    Instant.now().plusSeconds(3600),
                    Map.of("alg", "none"),
                    Map.of("sub", "test-user@iiitb.ac.in", "scope", "read") // Mock claims
            );
        };
    }
}