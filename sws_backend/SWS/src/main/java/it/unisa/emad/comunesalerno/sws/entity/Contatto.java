package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import it.unisa.emad.comunesalerno.sws.entity.serializer.ContattoSerializer;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.context.annotation.Lazy;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Data
@RequiredArgsConstructor
@JsonSerialize(using = ContattoSerializer.class)
public class Contatto {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    @NotNull
    @NotEmpty
    private String denominazione;
    private String email;
    private String cellulare;
    private String telefono;
    private String pec;
    private String sitoWeb;
    @ManyToOne
    @NotNull
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Ente enteProprietario;
}
