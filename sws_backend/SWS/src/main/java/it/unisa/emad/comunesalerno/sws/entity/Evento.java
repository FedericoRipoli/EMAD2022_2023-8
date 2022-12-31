package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

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


    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private ImageData locandina;


    @ManyToMany
    private List<Area> aree;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataInizio;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataFine;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCreazione;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaModifica;

    @OneToOne(cascade = CascadeType.ALL)
    private Posizione posizione;

    @ElementCollection
    private Set<String> hashtags;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Transient
    private List<String> idAree;

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
