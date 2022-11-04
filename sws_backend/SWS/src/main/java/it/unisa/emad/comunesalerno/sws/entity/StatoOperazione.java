package it.unisa.emad.comunesalerno.sws.entity;

public enum StatoOperazione {
    DA_APPROVARE("Da approvare"),APPROVATO("Approvato"),IN_MODIFICA("In modifica"),ANNULLATO("Annullato");
    private String text;

    private StatoOperazione(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
}
