package it.unisa.emad.comunesalerno.sws.security;


import it.unisa.emad.comunesalerno.sws.dto.TokenDTO;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.stereotype.Component;

import java.text.MessageFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;

@Component
public class TokenGenerator {
    @Autowired
    JwtEncoder accessTokenEncoder;

    @Autowired
    @Qualifier("jwtRefreshTokenEncoder")
    JwtEncoder refreshTokenEncoder;

    @Value("${app.jwt.token.expiredMinutes}")
    int expiredMinutes;
    @Value("${app.jwt.token.expiredRefreshDays}")
    int expiredRefreshDays;

    private String createAccessToken(Authentication authentication) {
        Utente user = (Utente) authentication.getPrincipal();
        Instant now = Instant.now();

        JwtClaimsSet.Builder claimsSetBuilder = JwtClaimsSet.builder()
                .issuer("sws")
                .issuedAt(now)
                .expiresAt(now.plus(expiredMinutes, ChronoUnit.MINUTES))
                .subject(user.getId())
                .claim("name", user.getUsername())
                .claim("role", user.isAdmin() ? "ADMIN" : "");

        if (user.getEnte() != null) {
            claimsSetBuilder.claim("ente", user.getEnte() != null ? user.getEnte().getDenominazione() : "");
            claimsSetBuilder.claim("idEnte", user.getEnte() != null ? user.getEnte().getId() : "");
        }
        JwtClaimsSet claimsSet=claimsSetBuilder.build();
        return accessTokenEncoder.encode(JwtEncoderParameters.from(claimsSet)).getTokenValue();
    }

    private String createRefreshToken(Authentication authentication) {
        Utente user = (Utente) authentication.getPrincipal();
        Instant now = Instant.now();

        JwtClaimsSet.Builder claimsSetBuilder = JwtClaimsSet.builder()
                .issuer("sws")
                .issuedAt(now)
                .expiresAt(now.plus(expiredRefreshDays, ChronoUnit.DAYS))
                .subject(user.getId())
                .claim("name", user.getUsername())
                .claim("role", user.isAdmin() ? "ADMIN" : "");

        if (user.getEnte() != null) {
            claimsSetBuilder.claim("ente", user.getEnte() != null ? user.getEnte().getDenominazione() : "");
            claimsSetBuilder.claim("idEnte", user.getEnte() != null ? user.getEnte().getId() : "");
        }
        JwtClaimsSet claimsSet=claimsSetBuilder.build();
        return refreshTokenEncoder.encode(JwtEncoderParameters.from(claimsSet)).getTokenValue();
    }

    public TokenDTO createToken(Authentication authentication) {
        if (!(authentication.getPrincipal() instanceof Utente user)) {
            throw new BadCredentialsException(
                    MessageFormat.format("principal {0} is not of User type", authentication.getPrincipal().getClass())
            );
        }

        TokenDTO tokenDTO = new TokenDTO();
        tokenDTO.setUserId(user.getId());
        tokenDTO.setAccessToken(createAccessToken(authentication));

        String refreshToken;
        if (authentication.getCredentials() instanceof Jwt jwt) {
            Instant now = Instant.now();
            Instant expiresAt = jwt.getExpiresAt();
            Duration duration = Duration.between(now, expiresAt);
            long daysUntilExpired = duration.toDays();
            if (daysUntilExpired < 7) {
                refreshToken = createRefreshToken(authentication);
            } else {
                refreshToken = jwt.getTokenValue();
            }
        } else {
            refreshToken = createRefreshToken(authentication);
        }
        tokenDTO.setRefreshToken(refreshToken);

        return tokenDTO;
    }
}
