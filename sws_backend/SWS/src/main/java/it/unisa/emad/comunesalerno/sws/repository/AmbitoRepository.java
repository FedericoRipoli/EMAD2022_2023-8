package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Ambito;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AmbitoRepository extends JpaRepository<Ambito, String> {
    List<Ambito> findByPadreIsNull();
}
