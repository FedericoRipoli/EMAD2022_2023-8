package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.dto.UtenteDTO;
import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import it.unisa.emad.comunesalerno.sws.repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/enti")
public class EnteController {
    @Autowired
    EnteRepository enteRepository;

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity createEnte(@RequestBody Ente ente) {
        enteRepository.save(ente);
        return ResponseEntity.ok(ente);
    }
    @GetMapping
    public ResponseEntity listEnti(@RequestParam(value = "name",required = false) String name, Pageable pageable){
        return  ResponseEntity.ok(enteRepository.findAllByDenominazioneContains(name, pageable));
    }
    @GetMapping("/{id}")
    public ResponseEntity listEnti(@PathVariable String id){
        return  ResponseEntity.ok(enteRepository.findById(id).orElseThrow());
    }
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity deleteEnte(@PathVariable String id){
        enteRepository.delete(enteRepository.findById(id).orElseThrow());
        return  ResponseEntity.status(HttpStatus.OK).build();
    }
    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity updateEnte(@PathVariable String id,@RequestBody Ente ente){
        if(enteRepository.existsById(id)){
            ente.setId(id);
            enteRepository.save(ente);
            return ResponseEntity.ok(ente);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
