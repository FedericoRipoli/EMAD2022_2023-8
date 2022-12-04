package it.unisa.emad.comunesalerno.sws.repository;

import it.unisa.emad.comunesalerno.sws.entity.Area;
import it.unisa.emad.comunesalerno.sws.entity.ImportServizi;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ImportServiziRepository extends JpaRepository<ImportServizi, String> {

}
