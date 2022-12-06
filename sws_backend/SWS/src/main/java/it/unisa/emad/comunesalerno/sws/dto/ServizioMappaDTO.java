package it.unisa.emad.comunesalerno.sws.dto;

import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import lombok.*;

@Data
@NoArgsConstructor

public class ServizioMappaDTO {
    private String id;
    private String nome;
    private String struttura;
    private String ente;

    private String posizione;
    private String indirizzo;

    public ServizioMappaDTO(String id, String nome, String struttura, String ente,  String indirizzo,String posizione) {
        this.id = id;
        this.nome = nome;
        this.struttura = struttura;
        this.ente = ente;
        this.posizione = posizione;
        this.indirizzo = indirizzo;
    }
}
