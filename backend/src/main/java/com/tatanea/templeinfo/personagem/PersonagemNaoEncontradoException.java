package com.tatanea.templeinfo.personagem;

public class PersonagemNaoEncontradoException extends RuntimeException {

    public PersonagemNaoEncontradoException(String id) {
        super("Personagem não encontrado: " + id);
    }
}