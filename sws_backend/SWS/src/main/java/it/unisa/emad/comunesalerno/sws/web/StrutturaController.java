package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Ente;
import it.unisa.emad.comunesalerno.sws.entity.Struttura;
import it.unisa.emad.comunesalerno.sws.repository.EnteRepository;
import it.unisa.emad.comunesalerno.sws.repository.StrutturaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

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
    public ResponseEntity getStruttureEnte(@PathVariable String idEnte){
        return  ResponseEntity.ok(strutturaRepository.findAllByEnte_Id(idEnte));
    }
    @DeleteMapping("/strutture/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity deleteStruttura(@PathVariable String id){
        strutturaRepository.delete(strutturaRepository.findById(id).orElseThrow());
        return  ResponseEntity.status(HttpStatus.OK).build();
    }
    @PutMapping("/strutture/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity updateEnte(@PathVariable String id,@RequestBody Struttura struttura){
        if(strutturaRepository.existsById(id)){
            struttura.setId(id);
            strutturaRepository.save(struttura);
            return ResponseEntity.ok(struttura);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
