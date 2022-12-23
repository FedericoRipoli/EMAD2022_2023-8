package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import it.unisa.emad.comunesalerno.sws.entity.StatoOperazione;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.ServizioSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;


public interface ServizioRepository extends JpaRepository<Servizio, String>, JpaSpecificationExecutor<Servizio>, ServizioRepositoryCustom {

    @EntityGraph(
            type = EntityGraph.EntityGraphType.FETCH,
            attributePaths = {
                    "contatto",
                    "struttura",
                    "struttura.posizione",
                    "struttura.ente",
                    "aree",
                    "hashtags"
            }
    )
    Page<Servizio> findAll(Specification sp, Pageable p);

    boolean existsAllByStatoEqualsAndContatto_EmailEquals(StatoOperazione stato,String email);
}
