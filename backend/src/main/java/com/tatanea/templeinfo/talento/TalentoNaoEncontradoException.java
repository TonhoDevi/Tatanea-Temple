package com.tatanea.templeinfo.talento;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class TalentoNaoEncontradoException extends RuntimeException {
    public TalentoNaoEncontradoException(Long id) {
        super("Talento não encontrado: " + id);
    }
}
