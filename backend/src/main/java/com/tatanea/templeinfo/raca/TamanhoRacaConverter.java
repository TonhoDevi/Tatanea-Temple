package com.tatanea.templeinfo.raca;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class TamanhoRacaConverter implements AttributeConverter<TamanhoRaca, String> {

    @Override
    public String convertToDatabaseColumn(TamanhoRaca tamanho) {
        return tamanho == null ? null : tamanho.getCodigo();
    }

    @Override
    public TamanhoRaca convertToEntityAttribute(String codigo) {
        return codigo == null ? null : TamanhoRaca.fromCodigo(codigo);
    }
}
