package com.ddt.cosmossombrio.raca;

import jakarta.validation.constraints.NotBlank;
import java.util.List;

public class RacaDtos {

    public record TracoDto(String texto, int ordem) {}

    public record HabilidadeDto(String nome, String descricao, int ordem) {}

    /** Retorno resumido — usado na listagem (seletor de raça). */
    public record RacaResumoDto(
            String id,
            String nome,
            String categoria,
            String tamanho,
            String imagemUrl
    ) {
        static RacaResumoDto de(Raca raca) {
            return new RacaResumoDto(raca.getId(), raca.getNome(), raca.getCategoria(),
                    raca.getTamanho(), raca.getImagemUrl());
        }
    }

    /** Retorno completo — usado na tela de detalhe da raça. */
    public record RacaDetalheDto(
            String id,
            String nome,
            String categoria,
            String tamanho,
            String deslocamento,
            String imagemUrl,
            String descricao,
            List<TracoDto> tracos,
            List<HabilidadeDto> habilidades
    ) {
        static RacaDetalheDto de(Raca raca) {
            return new RacaDetalheDto(
                    raca.getId(), raca.getNome(), raca.getCategoria(), raca.getTamanho(),
                    raca.getDeslocamento(), raca.getImagemUrl(), raca.getDescricao(),
                    raca.getTracos().stream().map(t -> new TracoDto(t.getTexto(), t.getOrdem())).toList(),
                    raca.getHabilidades().stream()
                            .map(h -> new HabilidadeDto(h.getNome(), h.getDescricao(), h.getOrdem())).toList()
            );
        }
    }

    /** Payload de criação/edição (usado pelo compêndio administrativo, futuro). */
    public record RacaRequestDto(
            @NotBlank String id,
            @NotBlank String nome,
            String categoria,
            String tamanho,
            String deslocamento,
            String imagemUrl,
            String descricao,
            List<TracoDto> tracos,
            List<HabilidadeDto> habilidades
    ) {}
}
