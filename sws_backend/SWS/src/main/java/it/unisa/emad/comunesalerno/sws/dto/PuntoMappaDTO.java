package it.unisa.emad.comunesalerno.sws.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Optional;

@Data
@NoArgsConstructor

public class PuntoMappaDTO {
    private String posizione;
    private List<ServizioMappaDTO> punti;

    private String customIcon;
    public PuntoMappaDTO(String posizione, List<ServizioMappaDTO> punti) {
        this.posizione = posizione;
        this.punti = punti;
        Optional<String> customIcon=punti.stream().filter(servizioMappaDTO -> servizioMappaDTO.getCustomIcon()!=null).map(servizioMappaDTO -> servizioMappaDTO.getCustomIcon()).distinct().findFirst();
        if(customIcon.isPresent()){
            this.customIcon=customIcon.get();
        }
    }
}
