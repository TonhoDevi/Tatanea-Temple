package com.tatanea.templeinfo.raca;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

import java.util.List;

public class RacaDtos {

    public record AtributoDto(String atributo, int valor, Integer quantidadeEscolhas, int ordem) {
        static AtributoDto de(RacaAtributo a) {
            String codigo = a.getAtributo() == null ? null : a.getAtributo().getCodigo();
            return new AtributoDto(codigo, a.getValor(), a.getQuantidadeEscolhas(), a.getOrdem());
        }
    }

    public record HabilidadeEspecialDto(
            @NotBlank @Size(max = 120) String nome,
            @NotBlank @Size(max = 5000) String descricao,
            @NotBlank String tipo,
            int ordem
    ) {
        static HabilidadeEspecialDto de(RacaHabilidadeEspecial h) {
            return new HabilidadeEspecialDto(h.getNome(), h.getDescricao(), h.getTipo().getCodigo(), h.getOrdem());
        }
    }

    public record AlturaDto(double valorMenor, double valorMedio, double valorMaior) {
        static AlturaDto de(RacaAltura a) {
            return a == null ? null : new AlturaDto(a.getValorMenor(), a.getValorMedio(), a.getValorMaior());
        }
    }

    public record PesoDto(double valorMenor, double valorMedio, double valorMaior) {
        static PesoDto de(RacaPeso p) {
            return p == null ? null : new PesoDto(p.getValorMenor(), p.getValorMedio(), p.getValorMaior());
        }
    }

    public record IdadeDto(int idadeAdulta, int expectativaVida) {
        static IdadeDto de(RacaIdade i) {
            return i == null ? null : new IdadeDto(i.getIdadeAdulta(), i.getExpectativaVida());
        }
    }

    /** Retorno resumido — usado na listagem (seletor de raça). */
    public record RacaResumoDto(
            Long id,
            String slug,
            String nome,
            String categoria,
            String tamanho,
            int quantidadeHabilidadesEspeciais,
            String imagemUrl
    ) {
        static RacaResumoDto de(Raca raca) {
            return new RacaResumoDto(
                    raca.getId(), raca.getSlug(), raca.getNome(),
                    raca.getCategoria().getCodigo(), raca.getTamanho().getCodigo(),
                    raca.getHabilidadesEspeciais().size(),
                    raca.getImagem() == null ? null : "/api/racas/" + raca.getId() + "/imagem"
            );
        }
    }

    /** Retorno completo — usado na tela de detalhe da raça. */
    public record RacaDetalheDto(
            Long id,
            String slug,
            String nome,
            String categoria,
            int deslocamento,
            String tamanho,
            String quote,
            String idiomas,
            String anatomia,
            String aparencia,
            String nomesRaciais,
            String tracosCulturais,
            List<AtributoDto> atributos,
            List<HabilidadeEspecialDto> habilidadesEspeciais,
            AlturaDto altura,
            PesoDto peso,
            IdadeDto idade,
            String imagemUrl
    ) {
        static RacaDetalheDto de(Raca raca) {
            return new RacaDetalheDto(
                    raca.getId(), raca.getSlug(), raca.getNome(), raca.getCategoria().getCodigo(),
                    raca.getDeslocamento(), raca.getTamanho().getCodigo(), raca.getQuote(),
                    raca.getIdiomas(), raca.getAnatomia(), raca.getAparencia(),
                    raca.getNomesRaciais(), raca.getTracosCulturais(),
                    raca.getAtributos().stream().map(AtributoDto::de).toList(),
                    raca.getHabilidadesEspeciais().stream().map(HabilidadeEspecialDto::de).toList(),
                    AlturaDto.de(raca.getAltura()), PesoDto.de(raca.getPeso()), IdadeDto.de(raca.getIdade()),
                    raca.getImagem() == null ? null : "/api/racas/" + raca.getId() + "/imagem"
            );
        }
    }

    /** Payload de criação (usado pelo compêndio administrativo, futuro). */
    public record RacaRequestDto(
            @NotBlank @Size(max = 64) String slug,
            @NotBlank @Size(max = 120) String nome,
            @NotBlank String categoria,
            @Positive int deslocamento,
            @NotBlank String tamanho,
            @Size(max = 200) String quote,
            @Size(max = 5000) String idiomas,
            @Size(max = 5000) String anatomia,
            @Size(max = 5000) String aparencia,
            @Size(max = 5000) String nomesRaciais,
            @Size(max = 5000) String tracosCulturais,
            List<@Valid AtributoDto> atributos,
            List<@Valid HabilidadeEspecialDto> habilidadesEspeciais,
            @Valid AlturaDto altura,
            @Valid PesoDto peso,
            @Valid IdadeDto idade
    ) {}
}
