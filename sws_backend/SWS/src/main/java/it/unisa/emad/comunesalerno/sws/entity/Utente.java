package it.unisa.emad.comunesalerno.sws.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import it.unisa.emad.comunesalerno.sws.entity.serializer.UtenteSerializer;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

@Entity
@Data()
@RequiredArgsConstructor
@JsonSerialize(using = UtenteSerializer.class)
public class Utente implements UserDetails {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    @Column(name = "id", nullable = false)
    private String id;

    @Column(unique = true)
    @NotNull
    private String username;

    @NotNull
    private String password;

    private boolean admin;

    @OneToOne
    private Ente ente;

    @Transient
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String idEnte;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if(!this.admin)
            return Collections.EMPTY_LIST;
        List toReturn=new LinkedList<>();
        toReturn.add(new SimpleGrantedAuthority("ADMIN"));
        return toReturn;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() { return true; }
}
