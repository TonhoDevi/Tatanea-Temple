package com.tatanea.templeinfo.comum;

public enum Atributo {
    FORCA("forca"),
    DESTREZA("destreza"),
    CONSTITUICAO("constituicao"),
    INTELIGENCIA("inteligencia"),
    SABEDORIA("sabedoria"),
    CARISMA("carisma");

    private final String codigo;

    Atributo(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public static Atributo fromCodigo(String codigo) {
        for (Atributo a : values()) {
            if (a.codigo.equals(codigo)) return a;
        }
        throw new IllegalArgumentException("Atributo inválido: " + codigo);
    }
}
