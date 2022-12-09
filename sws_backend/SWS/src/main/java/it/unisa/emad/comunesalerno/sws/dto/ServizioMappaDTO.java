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

    private String area;
    private String color;
    private String icon;

    public ServizioMappaDTO(String id, String nome, String struttura, String ente,  String indirizzo,String posizione, String area, String color, String icon) {
        this.id = id;
        this.nome = nome;
        this.struttura = struttura;
        this.ente = ente;
        this.posizione = posizione;
        this.indirizzo = indirizzo;
    }
}
