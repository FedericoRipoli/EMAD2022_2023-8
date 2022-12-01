package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
public class Servizio {
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

    @ManyToOne
    private Struttura struttura;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCreazione;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaModifica;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Transient
    private List<String> idAree;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Transient
    private String idStruttura;
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
