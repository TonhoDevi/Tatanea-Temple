package com.tatanea.templeinfo.comum;

public enum TipoHabilidade {
    PASSIVA("passiva"),
    USO_UNICO("uso_unico"),
    MULTIPLOS_USOS("multiplos_usos");

    private final String codigo;

    TipoHabilidade(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public static TipoHabilidade fromCodigo(String codigo) {
        for (TipoHabilidade t : values()) {
            if (t.codigo.equals(codigo)) return t;
        }
        throw new IllegalArgumentException("Tipo de habilidade inválido: " + codigo);
    }
}
