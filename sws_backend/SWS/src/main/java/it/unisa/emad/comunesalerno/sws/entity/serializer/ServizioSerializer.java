package it.unisa.emad.comunesalerno.sws.entity.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import it.unisa.emad.comunesalerno.sws.entity.Servizio;

import java.io.IOException;

public class ServizioSerializer extends StdSerializer<Servizio> {
    protected ServizioSerializer() {
        this(null);
    }

    protected ServizioSerializer(Class<Servizio> t) {
        super(t);
    }

    @Override
    public void serialize(Servizio servizio, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField("id", servizio.getId());
        jsonGenerator.writeStringField("nome", servizio.getNome());
        jsonGenerator.writeStringField("contenuto", servizio.getContenuto());
        jsonGenerator.writeObjectField("immagini", servizio.getImmagini());
        jsonGenerator.writeObjectField("posizioni", servizio.getPosizioni());
        jsonGenerator.writeObjectField("contatti", servizio.getContatti());
        jsonGenerator.writeStringField("stato",servizio.getStato().getText());
        jsonGenerator.writeStringField("note",servizio.getNote());
        jsonGenerator.writeObjectField("hashtags",servizio.getHashtags());
        jsonGenerator.writeObjectField("ambito",servizio.getAmbito());
        jsonGenerator.writeObjectField("tipologia",servizio.getTipologia());
        jsonGenerator.writeObjectField("ente",servizio.getEnte().getDenominazione());
        jsonGenerator.writeObjectField("idEnte",servizio.getEnte().getId());

        jsonGenerator.writeEndObject();
    }
}
