package com.tatanea.templeinfo.comum;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class TipoHabilidadeConverter implements AttributeConverter<TipoHabilidade, String> {

    @Override
    public String convertToDatabaseColumn(TipoHabilidade tipo) {
        return tipo == null ? null : tipo.getCodigo();
    }

    @Override
    public TipoHabilidade convertToEntityAttribute(String codigo) {
        return codigo == null ? null : TipoHabilidade.fromCodigo(codigo);
    }
}
