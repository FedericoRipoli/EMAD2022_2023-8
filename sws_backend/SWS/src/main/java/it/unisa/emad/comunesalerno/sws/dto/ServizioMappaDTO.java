package it.unisa.emad.comunesalerno.sws.dto;

import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ServizioMappaDTO {
    private String id;
    private String nome;
    private String struttura;
    private String ente;

    private String posizione;


    public static ServizioMappaDTO cast(Servizio servizio){
        ServizioMappaDTO n=new ServizioMappaDTO();
        n.id=servizio.getId();
        n.ente=servizio.getStruttura().getEnte().getDenominazione();
        n.struttura=servizio.getStruttura().getDenominazione();
        n.nome=servizio.getNome();
        return n;
    }
}
