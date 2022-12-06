package it.unisa.emad.comunesalerno.sws.repository.search.specification;

import it.unisa.emad.comunesalerno.sws.entity.*;
import lombok.AllArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@AllArgsConstructor
public class UtenteSpecification implements Specification<Utente> {
    private String name, ente;

    private Boolean isAdmin;

    @Override
    public Predicate toPredicate(Root<Utente> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        List<Predicate> predicates = new ArrayList<>();
        if (name != null) {
            predicates.add(criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Utente_.username)),
                    "%" + name.toLowerCase() + "%"));
        }
        if(ente!=null){
            predicates.add(criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Utente_.ente).get(Ente_.denominazione)),
                    "%" + ente.toLowerCase() + "%"));

        }
        if(isAdmin!=null){
            predicates.add(criteriaBuilder.equal(root.get(Utente_.admin),
                    isAdmin.booleanValue()));
        }
        return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
    }
}
