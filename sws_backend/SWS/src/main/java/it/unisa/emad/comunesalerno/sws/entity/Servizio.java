package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import it.unisa.emad.comunesalerno.sws.entity.serializer.ServizioSerializer;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
@JsonSerialize(using = ServizioSerializer.class)
public class Servizio {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    private String nome;
    @Lob
    private String contenuto;
    @OneToMany(orphanRemoval = true, cascade = CascadeType.ALL)
    private List<ImageData> immagini;
    @OneToMany(orphanRemoval = true, cascade = CascadeType.ALL)
    private List<Posizione> posizioni;
    @ManyToMany
    private List<Contatto> contatti;
    @Enumerated(EnumType.STRING)
    private StatoOperazione stato;
    @Lob
    private String note;
    @ElementCollection
    private List<String> hashtags;
    @OneToOne
    private Ambito ambito;
    @OneToOne
    private Tipologia tipologia;
    @OneToOne
    @JsonIgnore
    private Ente ente;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCreazione;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaModifica;



    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY,required = true)
    @Transient
    private String idAmbito;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY, required = true)
    @Transient
    private String idTipologia;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Transient
    private String idEnte;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Transient
    private List<String> idContatti;

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
