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

    private StatoOperazione stato;

    @Override
    public Predicate toPredicate(Root<Servizio> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        List<Predicate> predicates = new ArrayList<>();
        if (name != null) {

            List<Predicate> joinOrPreds = new ArrayList<>();
            joinOrPreds.add(criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Servizio_.nome)),
                    "%" + name.toLowerCase() + "%"));
            List<String> tags= Arrays.stream(name.split(" ")).toList();
            tags.forEach(x->{

                joinOrPreds.add(root.join(Servizio_.hashtags).in(Arrays.asList(x)));
            });
            predicates.add(criteriaBuilder.or(joinOrPreds.toArray(new Predicate[joinOrPreds.size()])));

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
        if(stato!=null){
            predicates.add(criteriaBuilder.equal(root.get(Servizio_.stato),
                    stato));
        }
        return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
    }
}
