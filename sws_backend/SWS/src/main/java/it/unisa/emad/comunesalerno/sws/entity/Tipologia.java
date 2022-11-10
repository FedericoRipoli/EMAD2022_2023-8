package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
@JsonIgnoreProperties(value = { "padre" })
public class Tipologia {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    private String nome;


    @OneToMany(mappedBy = "padre", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Tipologia> figli;

    @ManyToOne
    private Tipologia padre;

    @Transient
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String idPadre;
}
