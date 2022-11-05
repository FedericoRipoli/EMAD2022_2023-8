package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Contatto;
import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.ContattoRepository;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/contatti")
public class ContattoController {
    @Autowired
    ContattoRepository contattoRepository;
    @Autowired
    EnteRepository enteRepository;

    @GetMapping("/{id}")
    public ResponseEntity getContatto(@PathVariable String id) {
        return ResponseEntity.ok(contattoRepository.findById(id).orElseThrow());
    }

    @GetMapping
    public ResponseEntity getContatti() {
        return ResponseEntity.ok(contattoRepository.findAll());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity deleteContatto(@AuthenticationPrincipal Utente user, @PathVariable String id) {
        Contatto contatto = checkAuth(user, id);
        if (contatto != null) {
            contattoRepository.delete(contattoRepository.findById(id).orElseThrow());
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED).build();
    }

    @PutMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity updateContatto(@AuthenticationPrincipal Utente user, @PathVariable String id, @RequestBody Contatto contatto) {
        Contatto dbContatto = checkAuth(user, id);
        if (dbContatto != null) {

            contatto.setId(id);
            contatto.setEnteProprietario(dbContatto.getEnteProprietario());
            contattoRepository.save(contatto);
            return ResponseEntity.ok(contatto);

        }
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED).build();
    }

    @PostMapping("/{idEnte}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity createContatto(@AuthenticationPrincipal Utente user, @RequestBody Contatto contatto, @PathVariable String idEnte) {
        Ente ente = enteRepository.findById(idEnte).orElseThrow();
        contatto.setEnteProprietario(ente);
        if (!user.isAdmin()) {
            if (user.getEnte() == null || !user.getEnte().getId().equals(idEnte)) {
                return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED).build();
            }
        }
        return ResponseEntity.ok(contattoRepository.save(contatto));


    }

    private Contatto checkAuth(Utente user, String idContatto) {
        if (user.getEnte() == null && !user.isAdmin()) {
            return null;
        }
        Contatto contatto = contattoRepository.findById(idContatto).orElseThrow();
        if (user.isAdmin() || (contatto.getEnteProprietario() != null && contatto.getEnteProprietario().getId().equals(user.getEnte().getId()))) {
            return contatto;
        }
        return null;
    }
}
