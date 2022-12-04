package it.unisa.emad.comunesalerno.sws.web;

import it.unisa.emad.comunesalerno.sws.entity.*;
import it.unisa.emad.comunesalerno.sws.repository.*;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping("/api/import")
public class ImportController {

    @Autowired
    UserDetailsManager userDetailsManager;
    @Autowired
    ImportServiziRepository importServiziRepository;
    @Autowired
    StrutturaRepository strutturaRepository;
    @Autowired
    ServizioRepository servizioRepository;
    @Autowired
    AreaRepository areaRepository;
    @Autowired
    EnteRepository enteRepository;
    @Autowired
    UtenteRepository utenteRepository;

    @PostMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity importData() {
        List<ImportServizi> table=importServiziRepository.findAll();


        List<String> areeDistinct=table.stream().map(l-> l.getArea()).distinct().toList();
        List<String> aree=new LinkedList<>();
        for(String s:areeDistinct){
            String [] splitted=s.split(", ");
            for(String rs:splitted){
                aree.add(rs);
            }
        }
        for(String s : aree){
            if(areaRepository.findByNome(s)==null){
                Area n=new Area();
                n.setNome(s);
                areaRepository.save(n);
            }
        }

        for(ImportServizi linea : table){
            Ente e;
            if(enteRepository.findByDenominazione(linea.getEnte())!=null){
                e=enteRepository.findByDenominazione(linea.getEnte());
            }
            else{
                e=new Ente();
                e.setDenominazione(linea.getEnte());
                enteRepository.save(e);
            }
            String nomeStruttura= linea.getStruttura();
            if(e.getStrutture()==null){
                e.setStrutture(new LinkedList<>());
            }
            Struttura s;
            if(e.getStrutture().stream().map(struttura -> struttura.getDenominazione()).anyMatch(s1 -> s1.equals(nomeStruttura))){
                s=e.getStrutture().stream().filter(struttura -> struttura.getDenominazione().equals(nomeStruttura)).findFirst().get();
            }
            else{
                s=new Struttura();
                s.setEnte(e);
                s.setDenominazione(nomeStruttura);
                Posizione p=new Posizione();
                p.setIndirizzo(linea.getIndirizzo());
                if(!linea.getLatlong().isEmpty()){
                    p.setLatitudine(linea.getLatlong().split(", ")[0]);
                    p.setLongitudine(linea.getLatlong().split(", ")[1]);
                }

                s.setPosizione(p);
                e.getStrutture().add(s);
                strutturaRepository.save(s);
            }
            Servizio serv=new Servizio();
            serv.setStruttura(s);
            serv.setStato(StatoOperazione.APPROVATO);
            serv.setNome(linea.getServizio());
            Contatto c=new Contatto();
            c.setEmail(linea.getEmail());
            c.setTelefono(c.getTelefono());
            serv.setContatto(c);
            serv.setAree(new LinkedList<>());
            String[] areeString=linea.getArea().split(", ");
            for(String as : areeString){
                serv.getAree().add(areaRepository.findByNome(as));
            }
            if(s.getServizi()==null){
                s.setServizi(new LinkedList<>());
            }
            servizioRepository.save(serv);
        }

        return  ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping("/users")
    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity generateUser() {
        List<Ente> enti=enteRepository.findAll();
        for(Ente e:enti){
            Utente u=new Utente();
            u.setEnte(e);
            u.setAdmin(false);
            String userName=RandomStringUtils.randomAlphanumeric(10);
            u.setUsername(userName);
            u.setPassword(userName);
            userDetailsManager.createUser(u);
        }

        return  ResponseEntity.status(HttpStatus.OK).build();
    }

}
