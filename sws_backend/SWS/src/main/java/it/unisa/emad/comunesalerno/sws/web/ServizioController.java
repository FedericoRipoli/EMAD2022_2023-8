package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.*;
import it.unisa.emad.comunesalerno.sws.repository.*;
import it.unisa.emad.comunesalerno.sws.repository.search.SearchCriteria;
import it.unisa.emad.comunesalerno.sws.repository.search.SearchOperation;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.GenericSpecification;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.ServizioSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/api/servizi")
public class ServizioController {

    @Autowired
    ServizioRepository servizioRepository;
    @Autowired
    AmbitoRepository ambitoRepository;
    @Autowired
    ContattoRepository contattoRepository;
    @Autowired
    EnteRepository enteRepository;
    @Autowired
    TipologiaRepository tipologiaRepository;

    @PostMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity createServizio(@AuthenticationPrincipal Utente user, @RequestBody Servizio servizio) {
        servizio.setId(null);
        servizio.setNote(null);
        if(!user.isAdmin())
            servizio.setStato(StatoOperazione.DA_APPROVARE);
        servizio.setTipologia(tipologiaRepository.findById(servizio.getIdTipologia()).orElseThrow());
        servizio = setValues(servizio, user);
        if (servizio == null)
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
        servizioRepository.save(servizio);
        return ResponseEntity.ok(servizio);
    }

    @GetMapping
    public ResponseEntity listServizi(@AuthenticationPrincipal Utente user,
                                      @RequestParam(value = "name", required = false) String name,
                                      @RequestParam(value = "idAmbito", required = false) String idAmbito,
                                      @RequestParam(value = "idTipologia", required = false) String idTipologia,
                                      @RequestParam(value = "idEnte", required = false) String idEnte,
                                      @RequestParam(value = "tags", required = false) List<String> tags,
                                      @RequestParam(value = "stato", required = false) StatoOperazione stato,
                                      Pageable pageable) {

        if(user==null) stato=StatoOperazione.APPROVATO;
        if(user!=null && !user.isAdmin()) idEnte=user.getEnte().getId();

        ServizioSpecification specification = new ServizioSpecification(name, idAmbito, idTipologia, idEnte, tags, stato);
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
            Servizio dbServizio=servizioRepository.findById(id).orElseThrow();
            if(!dbServizio.getEnte().getId().equals(servizio.getEnte().getId()))
                return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
            if(!user.isAdmin()){
                servizio.setStato(StatoOperazione.DA_APPROVARE);
            }
            servizioRepository.save(servizio);
            return ResponseEntity.ok(servizio);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }

    private Servizio setValues(Servizio servizio, Utente user) {
        servizio.setTipologia(tipologiaRepository.findById(servizio.getIdTipologia()).orElseThrow());
        if (user.isAdmin()) {
            if (servizio.getIdEnte() == null) {
                return null;
            }
            servizio.setEnte(enteRepository.findById(servizio.getIdEnte()).orElseThrow());
        } else {
            servizio.setEnte(user.getEnte());
        }
        servizio.setAmbito(ambitoRepository.findById(servizio.getIdAmbito()).orElseThrow());
        servizio.setContatti(new LinkedList<>());
        if (servizio.getIdContatti() != null) {
            servizio.getIdContatti().stream().forEach(x -> {
                servizio.getContatti().add(contattoRepository.findById(x).orElseThrow());
            });
        }
        return servizio;
    }

}
