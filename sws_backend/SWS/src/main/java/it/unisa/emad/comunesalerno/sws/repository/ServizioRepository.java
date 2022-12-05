package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;


public interface ServizioRepository extends JpaRepository<Servizio, String>, JpaSpecificationExecutor<Servizio>, ServizioRepositoryCustom {

}
