package it.unisa.emad.comunesalerno.sws.entity.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import it.unisa.emad.comunesalerno.sws.entity.Ambito;

import java.io.IOException;

public class AmbitoSerializer extends StdSerializer<Ambito> {

    public AmbitoSerializer() {
        this(null);
    }

    protected AmbitoSerializer(Class<Ambito> t) {
        super(t);
    }

    @Override
    public void serialize(Ambito ambito, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField("id", ambito.getId());
        jsonGenerator.writeStringField("nome", ambito.getNome());
        jsonGenerator.writeEndObject();
    }
}