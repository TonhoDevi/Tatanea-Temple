package com.tatanea.templeinfo.raca;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class RacaNaoEncontradaException extends RuntimeException {
    public RacaNaoEncontradaException(Long id) {
        super("Raça não encontrada: " + id);
    }
}
