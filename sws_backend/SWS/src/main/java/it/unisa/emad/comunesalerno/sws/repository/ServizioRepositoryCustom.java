package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.dto.ServizioMappaDTO;
import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.ServizioSpecification;

import java.util.List;

public interface ServizioRepositoryCustom {
    List<ServizioMappaDTO> findAllForMappa(ServizioSpecification specification);
}
