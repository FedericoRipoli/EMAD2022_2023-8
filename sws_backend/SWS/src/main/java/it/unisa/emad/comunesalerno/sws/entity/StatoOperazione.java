package it.unisa.emad.comunesalerno.sws.entity;

public enum StatoOperazione {
    DA_APPROVARE("Da approvare"),APPROVATO("Approvato"),IN_MODIFICA("In modifica"),ANNULLATO("Annullato"),DA_CANCELLARE("Da cancellare");
    private String text;

    private StatoOperazione(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
}
