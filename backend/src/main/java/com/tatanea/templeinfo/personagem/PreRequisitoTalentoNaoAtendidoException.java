package com.tatanea.templeinfo.personagem;

public class PreRequisitoTalentoNaoAtendidoException extends RuntimeException {
    public PreRequisitoTalentoNaoAtendidoException(String motivo) {
        super(motivo);
    }
}
