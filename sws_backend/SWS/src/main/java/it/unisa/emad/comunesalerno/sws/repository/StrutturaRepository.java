package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Struttura;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StrutturaRepository extends JpaRepository<Struttura, String> {

    List<Struttura> findAllByDenominazioneContainingIgnoreCaseAndEnte_IdEquals(String name,String id);
}
