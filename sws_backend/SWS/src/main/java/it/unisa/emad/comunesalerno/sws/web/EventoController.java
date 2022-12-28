package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.*;
import it.unisa.emad.comunesalerno.sws.repository.AreaRepository;
import it.unisa.emad.comunesalerno.sws.repository.EventoRepository;
import it.unisa.emad.comunesalerno.sws.repository.search.specification.EventoSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/eventi")
public class EventoController {
    @Autowired
    EventoRepository eventoRepository;
    @Autowired
    AreaRepository areeRepository;
    @GetMapping
    public ResponseEntity listEventi(@AuthenticationPrincipal Utente user,
                                     @RequestParam(value = "name", required = false) String name,
                                     @RequestParam(value = "idArea", required = false) String idArea,
                                     @RequestParam(value = "dataInizio", required = false) Date dataInizio,
                                     @RequestParam(value = "dataFine", required = false) Date dataFine,
                                     Pageable pageable) {

        EventoSpecification specification = new EventoSpecification(name, idArea, dataInizio, dataFine);

        Page<Evento> toRet = eventoRepository.findAll(specification, pageable);
        return ResponseEntity.ok(toRet);


    }

    @GetMapping("/{id}")
    public ResponseEntity get(@PathVariable String id) {
        return ResponseEntity.ok(eventoRepository.findById(id).orElseThrow());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity delete(@PathVariable String id) {
        eventoRepository.delete(eventoRepository.findById(id).orElseThrow());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity create(@RequestBody Evento evento) {
        evento = setValues(evento);
        eventoRepository.save(evento);
        return ResponseEntity.ok(evento);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity edit(@PathVariable String id, @RequestBody Evento evento) {
        if (eventoRepository.existsById(id)) {
            evento.setId(id);
            evento = setValues(evento);
            eventoRepository.save(evento);
            return ResponseEntity.ok(evento);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
    private Evento setValues(Evento evento) {


        evento.setAree(new LinkedList<>());
        for (String area : evento.getIdAree()) {
            evento.getAree().add(areeRepository.findById(area).orElseThrow());

        }



        return evento;
    }
}
