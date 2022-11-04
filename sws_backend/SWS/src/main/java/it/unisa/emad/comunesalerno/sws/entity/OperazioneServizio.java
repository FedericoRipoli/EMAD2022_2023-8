package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@RequiredArgsConstructor
public class OperazioneServizio {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataOperazione;
    @Lob
    private String note;
    @ManyToOne
    private Servizio servizio;
    @ManyToOne
    private Utente effettuatoDa;
    @Enumerated(EnumType.STRING)
    private StatoOperazione stato;
}
