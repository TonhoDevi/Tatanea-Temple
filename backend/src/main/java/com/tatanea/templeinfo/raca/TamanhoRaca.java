package com.tatanea.templeinfo.raca;

public enum TamanhoRaca {
    MIUDO("miudo"),
    PEQUENO("pequeno"),
    MEDIO("medio"),
    GRANDE("grande"),
    ENORME("enorme");

    private final String codigo;

    TamanhoRaca(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public static TamanhoRaca fromCodigo(String codigo) {
        for (TamanhoRaca t : values()) {
            if (t.codigo.equals(codigo)) return t;
        }
        throw new IllegalArgumentException("Tamanho de raça inválido: " + codigo);
    }
}
