package com.tatanea.templeinfo.personagem;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;

public class PersonagemDtos {

    private PersonagemDtos() {
    }

    public record PericiaDto(String pericia, boolean proficiente, boolean expertise) {
    }

    public record AtaqueDto(String nome, String bonusAtaque, String dano, String tipoDano) {
    }

    public record ItemInventarioDto(
            String nome,
            int quantidade,
            Double peso,
            @Size(max = 5000, message = "descrição do item não pode passar de 5000 caracteres")
            String descricao
    ) {
    }

    public record ItemMagicoDto(
            String nome,
            @Size(max = 5000, message = "descrição não pode passar de 5000 caracteres")
            String descricao
    ) {
    }

    public record HabilidadeDto(
            String nome,
            @Size(max = 5000, message = "descrição não pode passar de 5000 caracteres")
            String descricao
    ) {
    }

    public record MagiaDto(int nivel, String nome, boolean preparada) {
    }

    public record UnidadeDto(
            String nome,
            String tipo,
            @Size(max = 5000, message = "dados extras não podem passar de 5000 caracteres")
            String dadosExtraJson
    ) {
    }

    public record TagDto(String tipo, String texto) {
    }

    public record PersonagemTalentoDto(
            Long talentoId,
            String nome,
            String descricao,
            String atributoRecebido,
            Integer valorAtributoRecebido
    ) {
    }

    public record AdicionarTalentoRequestDto(
            @jakarta.validation.constraints.NotNull(message = "talentoId é obrigatório")
            Long talentoId
    ) {
    }

    public record PersonagemResumoDto(
            String id,
            String nome,
            String tipo,
            Long racaId,
            String classeId,
            int nivel,
            String imagemUrl,
            int pvAtual,
            int pvMaximo
    ) {
    }

    public record PersonagemDetalheDto(
            String id,
            String nome,
            String tipo,
            String nomeJogador,
            Long racaId,
            String classeId,
            int nivel,
            String imagemUrl,
            int forca,
            int destreza,
            int constituicao,
            int inteligencia,
            int sabedoria,
            int carisma,
            int pvAtual,
            int pvMaximo,
            int pvTemporario,
            int ca,
            String deslocamento,
            int iniciativaBonus,
            boolean inspiracao,
            int dadosVidaGastos,
            String antecedente,
            String tendencia,
            boolean pontoHeroico,
            int moedaPc,
            int moedaPp,
            int moedaPo,
            int moedaPe,
            int moedaPl,
            String deslocNadar,
            String deslocVoar,
            String deslocEscalar,
            String salto,
            String idiomas,
            String historia,
            String anotacoes,
            List<PericiaDto> pericias,
            List<AtaqueDto> ataques,
            List<ItemInventarioDto> inventario,
            List<ItemMagicoDto> itensMagicos,
            List<HabilidadeDto> habilidades,
            List<MagiaDto> magias,
            List<UnidadeDto> unidades,
            List<TagDto> tags,
            List<PersonagemTalentoDto> talentos
    ) {
    }

    public record PersonagemRequestDto(
            @NotBlank(message = "nome é obrigatório")
            @Size(max = 120, message = "nome não pode passar de 120 caracteres")
            String nome,
            String tipo,
            @Size(max = 120, message = "nome do jogador não pode passar de 120 caracteres")
            String nomeJogador,
            Long racaId,
            String classeId,
            int nivel,
            @Size(max = 300, message = "caminho da imagem inválido")
            String imagemUrl,
            int forca,
            int destreza,
            int constituicao,
            int inteligencia,
            int sabedoria,
            int carisma,
            int pvAtual,
            int pvMaximo,
            int pvTemporario,
            int ca,
            String deslocamento,
            int iniciativaBonus,
            boolean inspiracao,
            int dadosVidaGastos,
            String antecedente,
            String tendencia,
            boolean pontoHeroico,
            int moedaPc,
            int moedaPp,
            int moedaPo,
            int moedaPe,
            int moedaPl,
            String deslocNadar,
            String deslocVoar,
            String deslocEscalar,
            String salto,
            @Size(max = 5000, message = "idiomas não pode passar de 5000 caracteres")
            String idiomas,
            @Size(max = 5000, message = "história não pode passar de 5000 caracteres")
            String historia,
            @Size(max = 5000, message = "anotações não podem passar de 5000 caracteres")
            String anotacoes,
            List<PericiaDto> pericias,
            List<@Valid AtaqueDto> ataques,
            List<@Valid ItemInventarioDto> inventario,
            List<@Valid ItemMagicoDto> itensMagicos,
            List<@Valid HabilidadeDto> habilidades,
            List<MagiaDto> magias,
            List<@Valid UnidadeDto> unidades,
            List<TagDto> tags
    ) {
    }
}