package it.unisa.emad.comunesalerno.sws.entity;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.context.annotation.Lazy;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Getter
@Setter
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
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ImageData> immagini;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "enteProprietario")
    private List<Contatto> contatti;


}