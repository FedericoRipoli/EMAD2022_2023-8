package it.unisa.emad.comunesalerno.sws.dto;

import it.unisa.emad.comunesalerno.sws.entity.Area;
import it.unisa.emad.comunesalerno.sws.entity.Servizio;
import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor

public class ServizioMappaDTO {
    private String id;
    private String nome;
    private String struttura;
    private String ente;

    private String posizione;
    private String indirizzo;


    private String customIcon;
    public ServizioMappaDTO(String id, String nome, String struttura, String ente,  String indirizzo,String posizione,  String customIcon) {
        this.id = id;
        this.nome = nome;
        this.struttura = struttura;
        this.ente = ente;
        this.posizione = posizione;
        this.indirizzo = indirizzo;
        this.customIcon=customIcon;
    }
}
