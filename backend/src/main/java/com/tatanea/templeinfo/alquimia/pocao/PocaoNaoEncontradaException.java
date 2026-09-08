package com.tatanea.templeinfo.alquimia.pocao;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class PocaoNaoEncontradaException extends RuntimeException {
    public PocaoNaoEncontradaException(String id) {
        super("Poção não encontrada: " + id);
    }
}
