package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Ambito;
import it.unisa.emad.comunesalerno.sws.repository.AmbitoRepository;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ambiti")
public class AmbitoController {
    @Autowired
    AmbitoRepository ambitoRepository;

    @GetMapping
    public ResponseEntity list() {
        return ResponseEntity.ok(ambitoRepository.findByPadreIsNull());
    }

    @GetMapping("/{id}")
    public ResponseEntity get(@PathVariable String id) {
        return ResponseEntity.ok(ambitoRepository.findById(id).orElseThrow());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity delete(@PathVariable String id) {
        ambitoRepository.delete(ambitoRepository.findById(id).orElseThrow());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity create(@RequestBody Ambito ambito) {
        if (ambito.getIdPadre() != null && !ambito.getIdPadre().isEmpty()) {
            ambito.setPadre(ambitoRepository.findById(ambito.getIdPadre()).orElseThrow());
        }
        ambitoRepository.save(ambito);
        return ResponseEntity.ok(ambito);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity edit(@PathVariable String id, @RequestBody Ambito ambito) {
        if (ambitoRepository.existsById(id)) {
            Ambito ambitoDb=ambitoRepository.findById(id).orElseThrow();
            if (ambito.getIdPadre() != null && !ambito.getIdPadre().isEmpty()) {
                if(ambitoDb.getId().equals(ambito.getIdPadre())){
                    return ResponseEntity.status(HttpStatus.CONFLICT).build();
                }
                ambitoDb.setPadre(ambitoRepository.findById(ambito.getIdPadre()).orElseThrow());
            }
            ambitoDb.setNome(ambito.getNome());
            ambitoRepository.save(ambitoDb);
            return ResponseEntity.ok(ambitoDb);
        }


        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
