package it.unisa.emad.comunesalerno.sws.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PuntoMappaDTO {
    private String posizione;
    private List<ServizioMappaDTO> punti;
}
