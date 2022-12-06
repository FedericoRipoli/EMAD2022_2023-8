package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.dto.ServizioMappaDTO;
import it.unisa.emad.comunesalerno.sws.entity.*;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.ServizioSpecification;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Root;
import java.util.List;

public class ServizioRepositoryCustomImpl implements ServizioRepositoryCustom {
    @PersistenceContext
    private EntityManager em;
    @Override
    public List<ServizioMappaDTO> findAllForMappa(ServizioSpecification specification) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<ServizioMappaDTO> cq = cb.createQuery(ServizioMappaDTO.class);
        Root<Servizio> root = cq.from(Servizio.class);
        cq.select(
                cb.construct(
                        ServizioMappaDTO.class,
                        root.get(Servizio_.id),
                        root.get(Servizio_.nome),
                        root.join(Servizio_.struttura).get(Struttura_.denominazione),
                        root.join(Servizio_.struttura).join(Struttura_.ente).get(Ente_.denominazione),
                        root.join(Servizio_.struttura).join(Struttura_.posizione).get(Posizione_.indirizzo),
                        cb.concat(cb.concat(
                                root.join(Servizio_.struttura).join(Struttura_.posizione).get(Posizione_.latitudine),
                                cb.literal(", ")
                        ), root.join(Servizio_.struttura).join(Struttura_.posizione).get(Posizione_.longitudine))


                )

        );
        cq.where(specification.toPredicate(root,cq,cb));
        return em.createQuery(cq).getResultList();

    }
}
