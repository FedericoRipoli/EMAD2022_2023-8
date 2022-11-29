package it.unisa.emad.comunesalerno.sws.entity.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import it.unisa.emad.comunesalerno.sws.entity.Tipologia;

import java.io.IOException;

public class TipologiaSerializer extends JsonSerializer<Tipologia> {



    @Override
    public void serialize(Tipologia tipologia, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField("id", tipologia.getId());
        jsonGenerator.writeStringField("nome", tipologia.getNome());
        jsonGenerator.writeEndObject();
    }
}
