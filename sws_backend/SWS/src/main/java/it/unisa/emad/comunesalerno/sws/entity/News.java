package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Data
@RequiredArgsConstructor
public class News {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    private String titolo;
    @Lob
    private String contenuto;
    @Temporal(TemporalType.TIMESTAMP)
    private Date data;
    @OneToMany
    private List<ImageData> immagini;


    @PrePersist
    public void prePersist(){
        this.data=new Date();
    }
}
