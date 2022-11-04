package it.unisa.emad.comunesalerno.sws.web;



import it.unisa.emad.comunesalerno.sws.dto.UtenteDTO;
import it.unisa.emad.comunesalerno.sws.entity.Utente;
import it.unisa.emad.comunesalerno.sws.repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    UtenteRepository userRepository;
    @Autowired
    UserDetailsManager userDetailsManager;
    @GetMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN') or #user.id == #id")
    public ResponseEntity user(@AuthenticationPrincipal Utente user, @PathVariable String id) {
        return ResponseEntity.ok(UtenteDTO.from(userRepository.findById(id).orElseThrow()));
    }
    @GetMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity users() {
        return ResponseEntity.ok(userRepository.findAll().stream().map(a->UtenteDTO.from(a)).toList());
    }
    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity updateUser(@PathVariable String id, @RequestBody Utente utente) {
        if(userRepository.existsById(id)){
            utente.setId(id);
            userDetailsManager.updateUser(utente);
            return ResponseEntity.ok(utente);
        }
        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity deleteUser(@PathVariable String id){
        userRepository.delete(userRepository.findById(id).orElseThrow());
        return  ResponseEntity.status(HttpStatus.OK).build();
    }

}
