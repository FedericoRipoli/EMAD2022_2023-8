package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Contatto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContattoRepository extends JpaRepository<Contatto, String> {
    List<Contatto> findAllByEnteProprietario_Id(String id);
    Page<Contatto> findAllByEnteProprietario_Id(String id, Pageable pageable);
}