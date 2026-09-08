package com.tatanea.templeinfo.personagem;

public class LimitePersonagensExcedidoException extends RuntimeException {

    public LimitePersonagensExcedidoException(int limite) {
        super("Limite de " + limite + " personagens atingido. Exclua uma ficha para criar outra.");
    }
}
