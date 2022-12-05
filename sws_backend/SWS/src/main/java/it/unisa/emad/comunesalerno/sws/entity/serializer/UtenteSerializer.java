package it.unisa.emad.comunesalerno.sws.entity.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import it.unisa.emad.comunesalerno.sws.entity.Utente;

import java.io.IOException;

public class UtenteSerializer extends StdSerializer<Utente> {

    public UtenteSerializer() {
        this(null);
    }

    protected UtenteSerializer(Class<Utente> t) {
        super(t);
    }

    @Override
    public void serialize(Utente utente, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField("id", utente.getId());
        jsonGenerator.writeStringField("username", utente.getUsername());
        jsonGenerator.writeStringField("password", utente.getPassword());
        jsonGenerator.writeBooleanField("admin", utente.isAdmin());
        if(utente.getEnte()!=null){
            jsonGenerator.writeStringField("nomeEnte", utente.getEnte().getDenominazione());
            jsonGenerator.writeStringField("idEnte", utente.getEnte().getId());
        }

        jsonGenerator.writeEndObject();
    }
}
