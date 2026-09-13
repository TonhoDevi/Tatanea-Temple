package com.tatanea.templeinfo.classe;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;

public class ClasseDtos {

    private ClasseDtos() {
    }

    // tipo: "HABILIDADE" (própria da classe, ganha em `nivel`), "FUNDAMENTO"
    // (regra fixa de toda classe — Pontos de Vida, Proficiências,
    // Equipamento, Incrementos — nivel fica nulo) ou "CONJURACAO" (regras
    // de conjuração de magia da classe, só existe pra quem tem magia).
    public record CaracteristicaDto(String titulo, String corpo, String tipo, Integer nivel) {
    }

    public record SubclasseCaracteristicaDto(String titulo, String corpo, Integer nivel) {
    }

    public record NivelDto(int nivel, String bonusProficiencia, String caracteristicas) {
    }

    public record SubclasseDto(
            String nome,
            String icone,
            String introTexto,
            String magiasTexto,
            List<SubclasseCaracteristicaDto> caracteristicas
    ) {
    }

    public record ClasseResumoDto(
            String id,
            String nome,
            String subtitulo,
            String icone,
            String cor,
            String dadoDeVida,
            String dificuldade,
            List<String> papeis
    ) {
    }

    public record ClasseDetalheDto(
            String id,
            String nome,
            String subtitulo,
            String icone,
            String cor,
            String dadoDeVida,
            String dificuldade,
            String descricaoIntro,
            String tabelasTextoBruto,
            List<String> papeis,
            List<NivelDto> niveis,
            List<CaracteristicaDto> caracteristicas,
            List<SubclasseDto> subclasses
    ) {
    }

    public record ClasseRequestDto(
            @NotBlank(message = "id é obrigatório")
            @Size(max = 64, message = "id não pode passar de 64 caracteres")
            String id,
            @NotBlank(message = "nome é obrigatório")
            @Size(max = 120, message = "nome não pode passar de 120 caracteres")
            String nome,
            @Size(max = 160, message = "subtítulo não pode passar de 160 caracteres")
            String subtitulo,
            String icone,
            String cor,
            String dadoDeVida,
            String dificuldade,
            String descricaoIntro,
            String tabelasTextoBruto,
            List<String> papeis,
            List<NivelDto> niveis,
            List<CaracteristicaDto> caracteristicas,
            List<SubclasseDto> subclasses
    ) {
    }
}
