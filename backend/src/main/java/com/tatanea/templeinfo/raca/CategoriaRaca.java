package com.tatanea.templeinfo.raca;

public enum CategoriaRaca {
    GLOBAL("global"),
    TRIBAL("tribal"),
    MISTICA("mistica"),
    SOBRENATURAL("sobrenatural");

    private final String codigo;

    CategoriaRaca(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public static CategoriaRaca fromCodigo(String codigo) {
        for (CategoriaRaca c : values()) {
            if (c.codigo.equals(codigo)) return c;
        }
        throw new IllegalArgumentException("Categoria de raça inválida: " + codigo);
    }
}
