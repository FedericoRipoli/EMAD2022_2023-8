package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Tipologia;
import it.unisa.emad.comunesalerno.sws.repository.AmbitoRepository;
import it.unisa.emad.comunesalerno.sws.repository.TipologiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/tipologie")
public class TipologiaController {
    @Autowired
    TipologiaRepository tipologiaRepository;

    @GetMapping
    public ResponseEntity list() {
        return ResponseEntity.ok(tipologiaRepository.findByPadreIsNull());
    }

    @GetMapping("/{id}")
    public ResponseEntity get(@PathVariable String id) {
        return ResponseEntity.ok(tipologiaRepository.findById(id).orElseThrow());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity delete(@PathVariable String id) {
        tipologiaRepository.delete(tipologiaRepository.findById(id).orElseThrow());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity create(@RequestBody Tipologia tipologia) {
        if (tipologia.getIdPadre() != null && !tipologia.getIdPadre().isEmpty()) {
            tipologia.setPadre(tipologiaRepository.findById(tipologia.getIdPadre()).orElseThrow());
        }
        tipologiaRepository.save(tipologia);
        return ResponseEntity.ok(tipologia);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity edit(@PathVariable String id, @RequestBody Tipologia tipologia) {
        if (tipologiaRepository.existsById(id)) {
            Tipologia tipologiaDb=tipologiaRepository.findById(id).orElseThrow();
            if (tipologia.getIdPadre() != null && !tipologia.getIdPadre().isEmpty()) {
                if(tipologiaDb.getId().equals(tipologia.getIdPadre())){
                    return ResponseEntity.status(HttpStatus.CONFLICT).build();
                }
                tipologiaDb.setPadre(tipologiaRepository.findById(tipologia.getIdPadre()).orElseThrow());
            }
            tipologiaDb.setNome(tipologia.getNome());
            tipologiaRepository.save(tipologiaDb);
            return ResponseEntity.ok(tipologiaDb);
        }


        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
