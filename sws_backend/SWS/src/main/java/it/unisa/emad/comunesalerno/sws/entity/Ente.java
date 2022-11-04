package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
public class Ente {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    @NotNull
    @NotEmpty
    private String denominazione;
    @Lob
    @NotNull
    @NotEmpty
    private String descrizione;
    private String piva;
    private String cf;
    @OneToOne(cascade = CascadeType.ALL)
    private Contatto contatto;
    @OneToOne(cascade = CascadeType.ALL)
    private ImageData logo;
    @OneToMany(cascade = CascadeType.ALL,orphanRemoval = true)
    private List<ImageData> immagini;



}