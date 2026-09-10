package com.tatanea.templeinfo.talentoracial;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class TalentoRacialNaoEncontradoException extends RuntimeException {
    public TalentoRacialNaoEncontradoException(Long id) {
        super("Talento racial não encontrado: " + id);
    }
}
