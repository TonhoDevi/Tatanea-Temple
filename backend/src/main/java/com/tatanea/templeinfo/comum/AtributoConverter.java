package com.tatanea.templeinfo.comum;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class AtributoConverter implements AttributeConverter<Atributo, String> {

    @Override
    public String convertToDatabaseColumn(Atributo atributo) {
        return atributo == null ? null : atributo.getCodigo();
    }

    @Override
    public Atributo convertToEntityAttribute(String codigo) {
        return codigo == null ? null : Atributo.fromCodigo(codigo);
    }
}
