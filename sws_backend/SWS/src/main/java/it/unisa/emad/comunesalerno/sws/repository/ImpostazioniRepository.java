package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Area;
import it.unisa.emad.comunesalerno.sws.entity.Impostazioni;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ImpostazioniRepository extends JpaRepository<Impostazioni, String> {

}
