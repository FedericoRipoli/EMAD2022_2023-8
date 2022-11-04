package it.unisa.emad.comunesalerno.sws.entity;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@RequiredArgsConstructor
public class Newsletter {

    @Id
    private String email;
    private boolean consensoGDPR;
    @Temporal(TemporalType.TIMESTAMP)
    private Date data;


    @PrePersist
    public void prePersist(){
        this.data=new Date();
    }
}
