package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.*;
import it.unisa.emad.comunesalerno.sws.repository.*;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.ServizioSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;
import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/api/servizi")
public class ServizioController {

    @Autowired
    ServizioRepository servizioRepository;
    @Autowired
    AreaRepository areeRepository;
    @Autowired
    StrutturaRepository strutturaRepository;
    @Autowired
    EnteRepository enteRepository;

    @PostMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity createServizio(@AuthenticationPrincipal Utente user, @RequestBody Servizio servizio) {
        servizio.setId(null);
        servizio.setNote(null);
        if (!user.isAdmin())
            servizio.setStato(StatoOperazione.DA_APPROVARE);
        servizio = setValues(servizio, user);
        if (servizio == null)
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
        servizioRepository.save(servizio);
        return ResponseEntity.ok(servizio);
    }

    @GetMapping
    public ResponseEntity listServizi(@AuthenticationPrincipal Utente user,
                                      @RequestParam(value = "name", required = false) String name,
                                      @RequestParam(value = "idArea", required = false) String idArea,
                                      @RequestParam(value = "idEnte", required = false) String idEnte,
                                      @RequestParam(value = "idStruttura", required = false) String idStruttura,
                                      @RequestParam(value = "tags", required = false) List<String> tags,
                                      @RequestParam(value = "stato", required = false) StatoOperazione stato,
                                      Pageable pageable) {

        if (user == null) stato = StatoOperazione.APPROVATO;
        if (user != null && !user.isAdmin()) idEnte = user.getEnte().getId();

        ServizioSpecification specification = new ServizioSpecification(name, idArea, idEnte, idStruttura, tags, stato);
        Page<Servizio> toRet = servizioRepository.findAll(specification, pageable);
        return ResponseEntity.ok(toRet);
    }

    @GetMapping("/{id}")
    public ResponseEntity getServizio(@PathVariable String id) {
        return ResponseEntity.ok(servizioRepository.findById(id).orElseThrow());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity deleteEnte(@PathVariable String id) {
        servizioRepository.delete(servizioRepository.findById(id).orElseThrow());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PutMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity updateEnte(@PathVariable String id, @AuthenticationPrincipal Utente user, @RequestBody Servizio servizio) {
        if (servizioRepository.existsById(id)) {
            servizio.setId(id);
            servizio = setValues(servizio, user);
            if (servizio == null)
                return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
            if (!user.isAdmin()) {
                servizio.setStato(StatoOperazione.DA_APPROVARE);
            }
            servizioRepository.save(servizio);
            return ResponseEntity.ok(servizio);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }

    private Servizio setValues(Servizio servizio, Utente user) {
        if (servizio.getIdStruttura() == null) {
            return null;
        }
        if (servizio.getIdAree() == null) {
            return null;
        }
        servizio.setAree(new LinkedList<>());
        for (String area : servizio.getIdAree()) {
            servizio.getAree().add(areeRepository.findById(area).orElseThrow());

        }

        if (user.isAdmin()) {

            servizio.setStruttura(strutturaRepository.findById(servizio.getIdStruttura()).orElseThrow());
        } else {
            if (user.getEnte().getStrutture().stream().map((struttura -> struttura.getId())).anyMatch(s -> s.equals(servizio.getIdStruttura()))) {
                servizio.setStruttura(strutturaRepository.findById(servizio.getIdStruttura()).orElseThrow());
            } else {
                return null;
            }


        }

        return servizio;
    }

}
