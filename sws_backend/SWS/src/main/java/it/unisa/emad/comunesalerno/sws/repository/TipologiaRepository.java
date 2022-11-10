package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Tipologia;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TipologiaRepository extends JpaRepository<Tipologia, String> {
    List<Tipologia> findByPadreIsNull();
}
