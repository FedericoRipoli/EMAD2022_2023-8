package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Contatto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContattoRepository extends JpaRepository<Contatto, String> {
}