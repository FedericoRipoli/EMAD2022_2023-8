package it.unisa.emad.comunesalerno.sws.security;

import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;


@Component
public class JwtToUserConverter implements Converter<Jwt, UsernamePasswordAuthenticationToken> {
    @Autowired
    UtenteRepository userRepository;


    @Override
    public UsernamePasswordAuthenticationToken convert(Jwt jwt) {
        Utente user = new Utente();
        if(!userRepository.existsById(jwt.getSubject())){
            throw new UsernameNotFoundException("");
        }
        Utente dbUser=userRepository.findById(jwt.getSubject()).get();
        if(!dbUser.getUsername().equals(jwt.getClaimAsString("name"))){
            throw new UsernameNotFoundException("");
        }
        if(dbUser.isAdmin()!=(jwt.getClaimAsString("role").equals("ADMIN"))){
            throw new UsernameNotFoundException("");
        }
        user.setId(jwt.getSubject());
        user.setUsername(jwt.getClaimAsString("name"));
        user.setAdmin(jwt.getClaimAsString("role").equals("ADMIN"));
        user.setEnte(dbUser.getEnte());
        return new UsernamePasswordAuthenticationToken(user, jwt, user.getAuthorities());
    }
}
