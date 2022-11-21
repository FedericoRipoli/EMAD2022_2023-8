package it.unisa.emad.comunesalerno.sws.entity.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import it.unisa.emad.comunesalerno.sws.entity.Contatto;

import java.io.IOException;

public class ContattoSerializer extends StdSerializer<Contatto> {

    public ContattoSerializer() {
        this(null);
    }

    protected ContattoSerializer(Class<Contatto> t) {
        super(t);
    }

    @Override
    public void serialize(Contatto contatto, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField("denominazione", contatto.getDenominazione());
        jsonGenerator.writeStringField("email", contatto.getEmail());
        jsonGenerator.writeStringField("cellulare", contatto.getCellulare());
        jsonGenerator.writeStringField("telefono", contatto.getTelefono());
        jsonGenerator.writeStringField("pec", contatto.getPec());
        jsonGenerator.writeStringField("sitoWeb", contatto.getSitoWeb());
        jsonGenerator.writeStringField("ente", contatto.getEnteProprietario().getDenominazione());
        jsonGenerator.writeEndObject();
    }
}
