package com.iiitb.erp.placement.config;

import com.iiitb.erp.placement.service.TokenService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private TokenService tokenService;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {

        // 1. Extract ID Token from Cookie (PDF Step 4.2)
        String idToken = null;
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("id_token".equals(cookie.getName())) {
                    idToken = cookie.getValue();
                    break;
                }
            }
        }

        // 2. Validate Token (PDF Step 4.3 & 5)
        if (idToken != null) {
            // "TokenService makes a request to Google's tokeninfo endpoint"
            boolean isValid = tokenService.validateTokenWithGoogle(idToken);

            if (isValid) {
                // "If Google confirms... request continues"
                // We must manually set the Authentication in Spring Security context
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(
                                "user",
                                null,
                                Collections.singletonList(new SimpleGrantedAuthority("SCOPE_OUTREACH"))
                        );
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        filterChain.doFilter(request, response);
    }

    // Exclude login/callback endpoints from this filter
    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getServletPath();
        return path.startsWith("/auth/");
    }
}