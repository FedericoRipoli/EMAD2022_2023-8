package it.unisa.emad.comunesalerno.sws.dto;

import it.unisa.emad.comunesalerno.sws.entity.Utente;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UtenteDTO {
    private String id;
    private String username;
    private String password;
    private boolean admin;
    private String ente;
    private String idEnte;

    public static UtenteDTO from(Utente user) {
        return builder()
                .id(user.getId())
                .username(user.getUsername())
                .password(user.getPassword())
                .admin(user.isAdmin())
                .idEnte(user.getEnte()!=null?user.getEnte().getId():null)
                .ente(user.getEnte()!=null?user.getEnte().getDenominazione():null)
                .build();
    }
}
