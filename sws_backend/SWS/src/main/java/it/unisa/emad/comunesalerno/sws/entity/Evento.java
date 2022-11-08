package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
public class Evento {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    private String nome;
    @Lob
    private String contenuto;
    @OneToMany
    private List<ImageData> immagini;
    @OneToMany
    private List<Posizione> posizioni;
    @OneToMany
    private List<Contatto> contatti;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataInizio;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataFine;
    @Enumerated(EnumType.STRING)
    private StatoOperazione stato;
    @Lob
    private String note;
    private String tags;
    @OneToOne
    private Ambito ambito;
    @OneToOne
    private Tipologia tipologia;
    @OneToOne
    private Ente ente;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCreazione;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaModifica;

    @PrePersist
    public void prePersist(){
        this.dataCreazione=new Date();
        this.dataUltimaModifica=new Date();
    }
    @PreUpdate
    public void preUpdate(){
        this.dataUltimaModifica=new Date();
    }
}
