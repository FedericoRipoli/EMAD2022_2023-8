package it.unisa.emad.comunesalerno.sws.web;


import it.unisa.emad.comunesalerno.sws.dto.LoginDTO;
import it.unisa.emad.comunesalerno.sws.dto.SignupDTO;
import it.unisa.emad.comunesalerno.sws.dto.TokenDTO;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import it.unisa.emad.comunesalerno.sws.security.TokenGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.BearerTokenAuthenticationToken;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationProvider;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    UserDetailsManager userDetailsManager;
    @Autowired
    EnteRepository enteRepository;
    @Autowired
    TokenGenerator tokenGenerator;
    @Autowired
    DaoAuthenticationProvider daoAuthenticationProvider;
    @Autowired
    @Qualifier("jwtRefreshTokenAuthProvider")
    JwtAuthenticationProvider refreshTokenAuthProvider;


    @PostMapping("/register")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity register(@RequestBody SignupDTO signupDTO) {
        Utente user = new Utente();
        user.setPassword(signupDTO.getPassword());
        user.setUsername(signupDTO.getUsername());
        if(signupDTO.getIdEnte()!=null && !signupDTO.getIdEnte().isEmpty() && enteRepository.existsById(signupDTO.getIdEnte())){
            user.setEnte(enteRepository.findById(signupDTO.getIdEnte()).orElseThrow());
        }
        userDetailsManager.createUser(user);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody LoginDTO loginDTO) {
        Authentication authentication =
                daoAuthenticationProvider.authenticate(
                        UsernamePasswordAuthenticationToken.unauthenticated(loginDTO.getUsername(), loginDTO.getPassword()));
        return ResponseEntity.ok(tokenGenerator.createToken(authentication));
    }

    @PostMapping("/token")
    //@PreAuthorize("isAuthenticated()")
    public ResponseEntity token(@RequestBody TokenDTO tokenDTO) {
        Authentication authentication = refreshTokenAuthProvider.authenticate(new BearerTokenAuthenticationToken(tokenDTO.getRefreshToken()));
        Jwt jwt = (Jwt) authentication.getCredentials();
        // check if present in db and not revoked, etc

        return ResponseEntity.ok(tokenGenerator.createToken(authentication));
    }
}
