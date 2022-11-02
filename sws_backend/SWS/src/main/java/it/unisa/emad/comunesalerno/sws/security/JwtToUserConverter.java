package it.unisa.emad.comunesalerno.sws.security;

import it.unisa.emad.comunesalerno.sws.entity.Utente;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
public class JwtToUserConverter implements Converter<Jwt, UsernamePasswordAuthenticationToken> {

    @Override
    public UsernamePasswordAuthenticationToken convert(Jwt jwt) {
        Utente user = new Utente();
        user.setId(jwt.getSubject());
        user.setUsername(jwt.getClaimAsString("name"));
        user.setAdmin(jwt.getClaimAsString("role").equals("ADMIN"));
        return new UsernamePasswordAuthenticationToken(user, jwt, user.getAuthorities());
    }
}
