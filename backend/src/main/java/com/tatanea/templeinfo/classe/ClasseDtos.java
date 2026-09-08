package com.tatanea.templeinfo.classe;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;

public class ClasseDtos {

    private ClasseDtos() {
    }

    public record SubclasseDto(String nome, String icone, String descricao) {
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
            String atributoChave,
            String armadura,
            String armas,
            String ferramentas,
            String resistencias,
            String pericias,
            String descricao,
            String dificuldade,
            List<String> papeis,
            List<SubclasseDto> subclasses,
            List<String> habilidadesDestaque
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
            String atributoChave,
            @Size(max = 255, message = "armadura não pode passar de 255 caracteres")
            String armadura,
            @Size(max = 500, message = "armas não podem passar de 500 caracteres")
            String armas,
            @Size(max = 255, message = "ferramentas não podem passar de 255 caracteres")
            String ferramentas,
            @Size(max = 255, message = "resistências não podem passar de 255 caracteres")
            String resistencias,
            @Size(max = 5000, message = "perícias não podem passar de 5000 caracteres")
            String pericias,
            @Size(max = 5000, message = "descrição não pode passar de 5000 caracteres")
            String descricao,
            String dificuldade,
            List<String> papeis,
            List<SubclasseDto> subclasses,
            List<String> habilidadesDestaque
    ) {
    }
}