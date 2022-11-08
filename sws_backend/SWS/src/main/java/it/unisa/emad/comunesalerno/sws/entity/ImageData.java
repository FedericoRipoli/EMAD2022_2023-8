package it.unisa.emad.comunesalerno.sws.entity;

import it.unisa.emad.comunesalerno.sws.utility.ImageUtil;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Data
@RequiredArgsConstructor
public class ImageData {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;
    @NotNull
    @NotEmpty
    private String nome;
    @NotNull
    @NotEmpty
    private String type;
    @Lob
    @NotNull
    @NotEmpty
    private byte[] imageData;


    @PrePersist
    @PreUpdate
    public void compressImage() {
        this.imageData = ImageUtil.compressImage(imageData);
    }

    @PostLoad
    public void decompressImage() {
        this.imageData = ImageUtil.decompressImage(imageData);

    }

}
