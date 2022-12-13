package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Area;
import it.unisa.emad.comunesalerno.sws.entity.Impostazioni;
import it.unisa.emad.comunesalerno.sws.repository.AreaRepository;
import it.unisa.emad.comunesalerno.sws.repository.ImportServiziRepository;
import it.unisa.emad.comunesalerno.sws.repository.ImpostazioniRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/impostazioni")
public class ImpostazioniController {
    @Autowired
    ImpostazioniRepository impostazioniRepository;

    @GetMapping
    public ResponseEntity get() {

        return ResponseEntity.ok(impostazioniRepository.findAll().stream().findFirst());
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity create(@RequestBody Impostazioni impostazioni) {
        impostazioniRepository.save(impostazioni);
        return ResponseEntity.ok(impostazioni);
    }

    @PutMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity edit(@RequestBody Impostazioni impostazioni) {
        Optional<Impostazioni> dbImp=impostazioniRepository.findAll().stream().findFirst();
        if (dbImp.isPresent()) {
            impostazioni.setId(dbImp.get().getId());
            impostazioniRepository.save(impostazioni);
            return ResponseEntity.ok(impostazioni);
        }


        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
