package com.tatanea.templeinfo.personagem;

public class AcessoNegadoException extends RuntimeException {

    public AcessoNegadoException() {
        super("Este personagem não pertence ao usuário autenticado.");
    }
}