package com.iiitb.erp.placement.security;

import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String authHeader = request.getHeader("Authorization");

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7); // Remove "Bearer " prefix

            try {
                // Validate and extract token information
                String email = jwtUtil.extractEmail(token);
                String role = jwtUtil.extractRole(token);

                logger.debug("JWT Token - Email: " + email + ", Role: " + role);

                if (email != null && role != null) {
                    // Create authority with ROLE_ prefix
                    String authority = "ROLE_" + role;
                    logger.debug("Setting authority: " + authority);
                    
                    // Create authentication token with user email and role
                    UsernamePasswordAuthenticationToken authenticationToken =
                            new UsernamePasswordAuthenticationToken(
                                    email,
                                    null,
                                    Collections.singletonList(new SimpleGrantedAuthority(authority))
                            );
                    
                    // Set authentication details
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    
                    // Set authentication in security context
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    
                    logger.debug("Authentication set successfully for user: " + email);
                } else {
                    logger.warn("Email or role is null - Email: " + email + ", Role: " + role);
                }
            } catch (JwtException e) {
                // Token is invalid, expired, or malformed
                logger.error("JWT token validation failed: " + e.getClass().getSimpleName() + " - " + e.getMessage());
                // Clear security context to ensure no stale authentication
                SecurityContextHolder.clearContext();
            } catch (IllegalArgumentException e) {
                logger.error("JWT token is empty or null: " + e.getMessage());
                SecurityContextHolder.clearContext();
            } catch (Exception e) {
                logger.error("Unexpected error during JWT authentication: " + e.getClass().getSimpleName() + " - " + e.getMessage(), e);
                SecurityContextHolder.clearContext();
            }
        } else {
            logger.debug("No Authorization header or not Bearer token");
        }

        // Continue with the filter chain
        filterChain.doFilter(request, response);
    }
}
