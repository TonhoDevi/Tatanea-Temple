package com.tatanea.templeinfo.alquimia.essencia;

public record EssenciaDto(String simbolo, String nome, String cor, String corFundo, String elemento) {
    static EssenciaDto de(Essencia e) {
        return new EssenciaDto(e.getSimbolo(), e.getNome(), e.getCor(), e.getCorFundo(), e.getElemento());
    }
}
