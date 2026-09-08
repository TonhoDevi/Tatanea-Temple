package com.tatanea.templeinfo.raca;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class CategoriaRacaConverter implements AttributeConverter<CategoriaRaca, String> {

    @Override
    public String convertToDatabaseColumn(CategoriaRaca categoria) {
        return categoria == null ? null : categoria.getCodigo();
    }

    @Override
    public CategoriaRaca convertToEntityAttribute(String codigo) {
        return codigo == null ? null : CategoriaRaca.fromCodigo(codigo);
    }
}
