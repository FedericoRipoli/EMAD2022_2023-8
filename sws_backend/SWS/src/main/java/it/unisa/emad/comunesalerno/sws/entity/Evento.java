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

    @OneToOne(cascade = CascadeType.ALL)
    private Contatto contatto;

    @Enumerated(EnumType.STRING)
    private StatoOperazione stato;

    @Lob
    private String note;

    @ElementCollection
    private List<String> hashtags;

    @OneToMany
    private List<Area> aree;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataInizio;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataFine;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCreazione;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaModifica;

    @ManyToOne
    private Ente ente;

    @OneToOne(cascade = CascadeType.ALL)
    private Posizione posizione;


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
