package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

public interface UtenteRepository extends JpaRepository<Utente, String>, JpaSpecificationExecutor<Utente> {
    Optional<Utente> findByUsername(String username);
    boolean existsByUsername(String username);
}
