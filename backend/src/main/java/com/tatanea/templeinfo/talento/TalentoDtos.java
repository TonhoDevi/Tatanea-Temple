package com.tatanea.templeinfo.talento;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;

public class TalentoDtos {

    /** Retorno resumido — usado na listagem. */
    public record TalentoResumoDto(
            Long id,
            String slug,
            String nome,
            String icone,
            String atributoRecebido
    ) {
        static TalentoResumoDto de(Talento t) {
            return new TalentoResumoDto(
                    t.getId(), t.getSlug(), t.getNome(), t.getIcone(),
                    t.getAtributoRecebido() == null ? null : t.getAtributoRecebido().getCodigo()
            );
        }
    }

    /** Retorno completo — usado na tela de detalhe e na validação de pré-requisitos. */
    public record TalentoDetalheDto(
            Long id,
            String slug,
            String nome,
            String icone,
            String historia,
            String descricao,
            String atributoRecebido,
            Integer valorAtributoRecebido,
            Long racaRequeridaId,
            String racaRequeridaNome,
            String atributoRequerido,
            Integer valorMinimoAtributoRequerido
    ) {
        static TalentoDetalheDto de(Talento t) {
            return new TalentoDetalheDto(
                    t.getId(), t.getSlug(), t.getNome(), t.getIcone(), t.getHistoria(), t.getDescricao(),
                    t.getAtributoRecebido() == null ? null : t.getAtributoRecebido().getCodigo(),
                    t.getValorAtributoRecebido(),
                    t.getRacaRequerida() == null ? null : t.getRacaRequerida().getId(),
                    t.getRacaRequerida() == null ? null : t.getRacaRequerida().getNome(),
                    t.getAtributoRequerido() == null ? null : t.getAtributoRequerido().getCodigo(),
                    t.getValorMinimoAtributoRequerido()
            );
        }
    }

    /** Payload de criação (usado pelo compêndio administrativo, futuro). */
    public record TalentoRequestDto(
            @NotBlank String slug,
            @NotBlank String nome,
            String icone,
            String historia,
            String descricao,
            String atributoRecebido,
            Integer valorAtributoRecebido,
            Long racaRequeridaId,
            String atributoRequerido,
            @Positive Integer valorMinimoAtributoRequerido
    ) {}
}
