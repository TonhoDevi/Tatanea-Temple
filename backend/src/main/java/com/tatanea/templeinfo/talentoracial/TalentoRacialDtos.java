package com.tatanea.templeinfo.talentoracial;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

import java.util.List;

public class TalentoRacialDtos {

    /** Bônus de atributo — fixo (atributo preenchido) ou à escolha (atributo nulo). */
    public record AtributoDto(String atributo, int valor, Integer quantidadeEscolhas, int ordem) {
        static AtributoDto de(TalentoRacialAtributo a) {
            String codigo = a.getAtributo() == null ? null : a.getAtributo().getCodigo();
            return new AtributoDto(codigo, a.getValor(), a.getQuantidadeEscolhas(), a.getOrdem());
        }
    }

    /** Retorno resumido — usado na listagem. */
    public record TalentoRacialResumoDto(
            Long id,
            String slug,
            String nome,
            String icone,
            Long racaId,
            String racaNome,
            int nivelMinimo,
            List<AtributoDto> atributos
    ) {
        static TalentoRacialResumoDto de(TalentoRacial t) {
            return new TalentoRacialResumoDto(
                    t.getId(), t.getSlug(), t.getNome(), t.getIcone(),
                    t.getRaca().getId(), t.getRaca().getNome(), t.getNivelMinimo(),
                    t.getAtributos().stream().map(AtributoDto::de).toList()
            );
        }
    }

    /** Retorno completo — usado na tela de detalhe. */
    public record TalentoRacialDetalheDto(
            Long id,
            String slug,
            String nome,
            String icone,
            String historia,
            String descricao,
            Long racaId,
            String racaNome,
            int nivelMinimo,
            List<AtributoDto> atributos
    ) {
        static TalentoRacialDetalheDto de(TalentoRacial t) {
            return new TalentoRacialDetalheDto(
                    t.getId(), t.getSlug(), t.getNome(), t.getIcone(), t.getHistoria(), t.getDescricao(),
                    t.getRaca().getId(), t.getRaca().getNome(), t.getNivelMinimo(),
                    t.getAtributos().stream().map(AtributoDto::de).toList()
            );
        }
    }

    /** Payload de criação (usado pelo compêndio administrativo, futuro). */
    public record TalentoRacialRequestDto(
            @NotBlank String slug,
            @NotBlank String nome,
            String icone,
            String historia,
            String descricao,
            @NotNull Long racaId,
            @Positive int nivelMinimo,
            List<@Valid AtributoDto> atributos
    ) {}
}
