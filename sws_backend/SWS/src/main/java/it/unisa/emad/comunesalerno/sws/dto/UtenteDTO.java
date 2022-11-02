package it.unisa.emad.comunesalerno.sws.dto;

import it.unisa.emad.comunesalerno.sws.entity.Utente;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UtenteDTO {
    private String id;
    private String username;

    public static UtenteDTO from(Utente user) {
        return builder()
                .id(user.getId())
                .username(user.getUsername())
                .build();
    }
}
