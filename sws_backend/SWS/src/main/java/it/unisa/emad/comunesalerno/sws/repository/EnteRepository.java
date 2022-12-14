package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Ente;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EnteRepository extends JpaRepository<Ente, String> {
    Page<Ente> findAllByDenominazioneContains(String name, Pageable pageable);
    List<Ente> findAllByDenominazioneContains(String name);
    Ente findByDenominazione(String denominazione);
}