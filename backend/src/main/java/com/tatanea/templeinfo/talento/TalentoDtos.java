package com.tatanea.templeinfo.talento;

import jakarta.validation.constraints.NotBlank;
import java.util.List;

public class TalentoDtos {

    public record BeneficioDto(String texto, int ordem) {}

    public record TalentoResumoDto(String id, String nome, String categoria, String icone) {
        static TalentoResumoDto de(Talento t) {
            return new TalentoResumoDto(t.getId(), t.getNome(), t.getCategoria(), t.getIcone());
        }
    }

    public record TalentoDetalheDto(
            String id, String nome, String categoria, String icone, String prereq,
            String descricao, List<BeneficioDto> beneficios
    ) {
        static TalentoDetalheDto de(Talento t) {
            return new TalentoDetalheDto(
                    t.getId(), t.getNome(), t.getCategoria(), t.getIcone(), t.getPrereq(), t.getDescricao(),
                    t.getBeneficios().stream().map(b -> new BeneficioDto(b.getTexto(), b.getOrdem())).toList()
            );
        }
    }

    public record TalentoRequestDto(
            @NotBlank String id,
            @NotBlank String nome,
            String categoria,
            String icone,
            String prereq,
            String descricao,
            List<BeneficioDto> beneficios
    ) {}
}
