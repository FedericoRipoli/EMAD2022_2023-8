package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Data()
@RequiredArgsConstructor
public class Struttura {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;

    @NotNull
    @NotEmpty
    private String denominazione;

    @JsonIgnore
    @ManyToOne(optional = false)
    private Ente ente;

    @OneToOne(cascade = CascadeType.ALL)
    private Posizione posizione;

    @JsonIgnore
    @OneToMany(mappedBy = "struttura")
    private List<Servizio> servizi;
}
