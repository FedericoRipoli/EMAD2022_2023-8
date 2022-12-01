package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.Area;
import it.unisa.emad.comunesalerno.sws.repository.AreaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/aree")
public class AreaController {
    @Autowired
    AreaRepository areaRepository;

    @GetMapping
    public ResponseEntity list(@RequestParam(name = "name",required = false)String name) {
        return ResponseEntity.ok(areaRepository.findAllByNomeContainingIgnoreCase(name));
    }

    @GetMapping("/{id}")
    public ResponseEntity get(@PathVariable String id) {
        return ResponseEntity.ok(areaRepository.findById(id).orElseThrow());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity delete(@PathVariable String id) {
        areaRepository.delete(areaRepository.findById(id).orElseThrow());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity create(@RequestBody Area area) {
        areaRepository.save(area);
        return ResponseEntity.ok(area);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity edit(@PathVariable String id, @RequestBody Area area) {
        if (areaRepository.existsById(id)) {
            Area areaDb =areaRepository.findById(id).orElseThrow();
            areaDb.setNome(area.getNome());
            areaRepository.save(areaDb);
            return ResponseEntity.ok(areaDb);
        }


        return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
    }
}
