package com.tatanea.templeinfo.classe;

public class ClasseNaoEncontradaException extends RuntimeException {

    public ClasseNaoEncontradaException(String id) {
        super("Classe não encontrada: " + id);
    }
}