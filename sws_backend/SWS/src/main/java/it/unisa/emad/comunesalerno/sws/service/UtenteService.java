package it.unisa.emad.comunesalerno.sws.service;


import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import it.unisa.emad.comunesalerno.sws.repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;

import java.text.MessageFormat;

@Service
public class UtenteService implements UserDetailsManager {
    @Autowired
    UtenteRepository userRepository;
    @Autowired
    EnteRepository enteRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public void createUser(UserDetails user) {
        ((Utente) user).setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save((Utente) user);
    }

    @Override
    public void updateUser(UserDetails user) {
        Utente utente=((Utente)user);
        String id=utente.getId();
        Ente ente=utente.getEnte();
        if(id!=null && userRepository.existsById(id)){
            utente.setPassword(passwordEncoder.encode(user.getPassword()));
            if(ente!=null && enteRepository.existsById(ente.getId())){
                utente.setEnte(enteRepository.findById(ente.getId()).get());
            }
            userRepository.save(utente);
        }


    }

    @Override
    public void deleteUser(String username) {

    }

    @Override
    public void changePassword(String oldPassword, String newPassword) {

    }

    @Override
    public boolean userExists(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(
                        MessageFormat.format("username {0} not found", username)
                ));
    }
}
