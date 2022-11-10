package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
@JsonIgnoreProperties(value = { "padre" })
public class Ambito {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    private String nome;

    @OneToMany(mappedBy = "padre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Ambito> figli;

    @ManyToOne
    private Ambito padre;

    @Transient
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String idPadre;
}
