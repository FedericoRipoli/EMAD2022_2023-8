package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

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
    private String descrizione;

    @OneToMany(mappedBy = "ente")
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private List<Struttura> strutture;

    @JsonIgnore
    @OneToMany(mappedBy = "ente")
    private List<Evento> eventi;
}
