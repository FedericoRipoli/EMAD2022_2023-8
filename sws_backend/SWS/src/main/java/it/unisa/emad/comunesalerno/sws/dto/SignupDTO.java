package it.unisa.emad.comunesalerno.sws.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class SignupDTO {
    private String username;
    private String password;
    private String idEnte;
}
