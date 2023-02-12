package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Data
@NoArgsConstructor
@Entity
public class ImportServizi {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    @Lob
    private String ente;
    @Lob
    private String struttura;
    @Lob
    private String indirizzo;
    @Lob
    private String latlong;
    @Lob
    private String telefono;
    @Lob
    private String email;
    @Lob
    private String area;
    @Lob
    private String servizio;
    @Lob
    private String descrizione;
    @Lob
    private String sitoWeb;

}
