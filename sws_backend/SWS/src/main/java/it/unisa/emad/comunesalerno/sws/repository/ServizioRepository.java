package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ServizioRepository extends JpaRepository<Servizio, String>, JpaSpecificationExecutor<Servizio> {

}
