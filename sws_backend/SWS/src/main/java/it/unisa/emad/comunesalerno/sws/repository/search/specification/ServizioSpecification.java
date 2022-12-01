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
public class ServizioSpecification implements Specification<Servizio> {
    private String name, idArea, idEnte, idStruttura;
    private List<String> tags;
    private StatoOperazione stato;

    @Override
    public Predicate toPredicate(Root<Servizio> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        List<Predicate> predicates = new ArrayList<>();
        if (name != null) {
            predicates.add(criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Servizio_.nome)),
                    "%" + name.toLowerCase() + "%"));
        }
        if(idArea!=null){
            predicates.add(criteriaBuilder.equal(root.join(Servizio_.aree).get(Area_.id),
                    idArea));
        }
        if(idStruttura!=null){
            predicates.add(criteriaBuilder.equal(root.get(Servizio_.struttura).get(Struttura_.id),
                    idStruttura));
        }
        if(idEnte!=null){
            predicates.add(criteriaBuilder.equal(root.get(Servizio_.struttura).get(Struttura_.ente).get(Ente_.id),
                    idEnte));
        }
        if(tags!=null){
            tags.forEach(x->{

                predicates.add(root.join(Servizio_.hashtags).in(Arrays.asList(x)));
            });
        }
        if(stato!=null){
            predicates.add(criteriaBuilder.equal(root.get(Servizio_.stato),
                    stato));
        }
        return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
    }
}
