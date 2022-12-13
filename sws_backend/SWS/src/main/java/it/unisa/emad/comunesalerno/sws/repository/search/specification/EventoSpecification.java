package it.unisa.emad.comunesalerno.sws.repository.search.specification;

import it.unisa.emad.comunesalerno.sws.entity.*;
import lombok.AllArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@AllArgsConstructor
public class EventoSpecification implements Specification<Evento> {
    private String name, idArea;

    private Date dataInizio, dataFine;

    @Override
    public Predicate toPredicate(Root<Evento> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        List<Predicate> predicates = new ArrayList<>();
        if (name != null && !name.isEmpty()) {

            predicates.add(criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Evento_.nome)),
                    "%" + name.toLowerCase() + "%"));

        }
        if(idArea!=null){
            predicates.add(criteriaBuilder.equal(root.join(Evento_.aree).get(Area_.id),
                    idArea));
        }
        if(dataInizio!=null){
            predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get(Evento_.dataInizio),
                    dataInizio));
        }
        if(dataFine!=null){
            predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get(Evento_.dataFine),
                    dataFine));
        }

        return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
    }
}
