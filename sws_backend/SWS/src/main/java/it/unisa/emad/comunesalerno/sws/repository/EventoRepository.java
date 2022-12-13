package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Evento;
import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface EventoRepository extends JpaRepository<Evento, String>, JpaSpecificationExecutor<Evento> {

    //Page<Evento> findAll(Specification sp, Pageable p);
}
