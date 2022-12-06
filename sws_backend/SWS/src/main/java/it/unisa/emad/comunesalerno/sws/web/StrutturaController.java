package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Posizione;
import it.unisa.emad.comunesalerno.sws.entity.Struttura;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import it.unisa.emad.comunesalerno.sws.repository.StrutturaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class StrutturaController {
    @Autowired
    EnteRepository enteRepository;
    @Autowired
    StrutturaRepository strutturaRepository;

    @PostMapping("/strutture/{idEnte}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity createStruttura(@PathVariable String idEnte,@RequestBody Struttura struttura) {
        if(enteRepository.existsById(idEnte)){
            struttura.setEnte(enteRepository.findById(idEnte).orElseThrow());
            strutturaRepository.save(struttura);
            return ResponseEntity.ok(struttura);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();

    }

    @GetMapping("/strutture/{id}")
    public ResponseEntity getStruttura(@PathVariable String id){
        return  ResponseEntity.ok(strutturaRepository.findById(id).orElseThrow());
    }
    @GetMapping("/struttureente/{idEnte}")
    public ResponseEntity getStruttureEnte(@PathVariable String idEnte,@RequestParam(value = "name", required = false) String name){
        return  ResponseEntity.ok(strutturaRepository.findAllByDenominazioneContainingIgnoreCaseAndEnte_IdEquals(name,idEnte));
    }
    @DeleteMapping("/strutture/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity deleteStruttura(@PathVariable String id){
        strutturaRepository.delete(strutturaRepository.findById(id).orElseThrow());
        return  ResponseEntity.status(HttpStatus.OK).build();
    }
    @PutMapping("/strutture/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity updateStruttura(@PathVariable String id,@RequestBody Struttura struttura){
        if(strutturaRepository.existsById(id)){
            Struttura strutturaDb=strutturaRepository.findById(id).orElseThrow();

            struttura.setId(id);
            struttura.setEnte(strutturaDb.getEnte());
            strutturaRepository.save(struttura);
            return ResponseEntity.ok(struttura);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
