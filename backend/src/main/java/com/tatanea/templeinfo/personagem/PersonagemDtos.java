package com.tatanea.templeinfo.personagem;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;
import java.util.Map;

public class PersonagemDtos {

    private PersonagemDtos() {
    }

    public record PericiaDto(String pericia, boolean proficiente, boolean expertise) {
    }

    public record AtaqueDanoDto(int quantidade, String dado, int bonus, String tipoDano) {
    }

    public record AtaqueDto(
            String nome,
            String bonusAtributo,
            boolean bonusProficiente,
            int bonusExtra,
            List<AtaqueDanoDto> danos,
            @Size(max = 1000, message = "descrição do ataque não pode passar de 1000 caracteres")
            String descricao
    ) {
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
            String descricao,
            boolean sincronizado
    ) {
    }

    public record HabilidadeDto(
            String nome,
            @Size(max = 5000, message = "descrição não pode passar de 5000 caracteres")
            String descricao
    ) {
    }

    public record MagiaDto(
            int nivel,
            String nome,
            boolean preparada,
            String tempoConjuracao,
            @Size(max = 2000, message = "descrição da magia não pode passar de 2000 caracteres")
            String descricao
    ) {
    }

    public record ArmaduraPecaDto(String nome, int bonus) {
    }

    public record IniciativaModificadorDto(String nome, int bonus) {
    }

    public record TesouroItemDto(String nome, int quantidade, double valorUnitario, String descricao) {
    }

    public record PvMaximoComponenteDto(String nome, int bonus) {
    }

    public record SlotMagiaDto(int nivel, int total, int restantes) {
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
            List<com.tatanea.templeinfo.talento.TalentoDtos.AtributoDto> atributos
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
            String imagemDados,
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
            String imagemDados,
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
            Double deslocamento,
            int iniciativaBonus,
            String atributoMagia,
            int bonusMagiaExtra,
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
            Double deslocNadar,
            Double deslocVoar,
            Double deslocEscalar,
            Double salto,
            String idiomas,
            String historia,
            String anotacoes,
            int bonusProficiencia,
            int limiteSincronizados,
            Integer detalheIdade,
            Integer detalheAltura,
            Integer detalhePeso,
            String detalheCaracteristicas,
            String personalidadeTracos,
            String personalidadeIdeais,
            String personalidadeVinculos,
            String personalidadeDefeitos,
            boolean salvaguardaForca,
            boolean salvaguardaDestreza,
            boolean salvaguardaConstituicao,
            boolean salvaguardaInteligencia,
            boolean salvaguardaSabedoria,
            boolean salvaguardaCarisma,
            List<PericiaDto> pericias,
            List<AtaqueDto> ataques,
            List<ItemInventarioDto> inventario,
            List<ItemMagicoDto> itensMagicos,
            List<HabilidadeDto> habilidades,
            List<MagiaDto> magias,
            List<UnidadeDto> unidades,
            List<TagDto> tags,
            List<PersonagemTalentoDto> talentos,
            List<ArmaduraPecaDto> armaduraPecas,
            List<IniciativaModificadorDto> iniciativaModificadores,
            List<TesouroItemDto> tesouro,
            List<PvMaximoComponenteDto> pvMaximoComponentes,
            List<SlotMagiaDto> slotsMagia,
            Map<String, String> escolhasAtributo
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
            @Size(max = 2_900_000, message = "imagem muito grande")
            String imagemDados,
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
            Double deslocamento,
            int iniciativaBonus,
            String atributoMagia,
            int bonusMagiaExtra,
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
            Double deslocNadar,
            Double deslocVoar,
            Double deslocEscalar,
            Double salto,
            @Size(max = 5000, message = "idiomas não pode passar de 5000 caracteres")
            String idiomas,
            @Size(max = 5000, message = "história não pode passar de 5000 caracteres")
            String historia,
            @Size(max = 5000, message = "anotações não podem passar de 5000 caracteres")
            String anotacoes,
            int bonusProficiencia,
            int limiteSincronizados,
            Integer detalheIdade,
            Integer detalheAltura,
            Integer detalhePeso,
            @Size(max = 2000, message = "características físicas não podem passar de 2000 caracteres")
            String detalheCaracteristicas,
            @Size(max = 2000, message = "traços não podem passar de 2000 caracteres")
            String personalidadeTracos,
            @Size(max = 2000, message = "ideais não podem passar de 2000 caracteres")
            String personalidadeIdeais,
            @Size(max = 2000, message = "vínculos não podem passar de 2000 caracteres")
            String personalidadeVinculos,
            @Size(max = 2000, message = "defeitos não podem passar de 2000 caracteres")
            String personalidadeDefeitos,
            boolean salvaguardaForca,
            boolean salvaguardaDestreza,
            boolean salvaguardaConstituicao,
            boolean salvaguardaInteligencia,
            boolean salvaguardaSabedoria,
            boolean salvaguardaCarisma,
            List<PericiaDto> pericias,
            List<@Valid AtaqueDto> ataques,
            List<@Valid ItemInventarioDto> inventario,
            List<@Valid ItemMagicoDto> itensMagicos,
            List<@Valid HabilidadeDto> habilidades,
            List<MagiaDto> magias,
            List<@Valid UnidadeDto> unidades,
            List<TagDto> tags,
            List<ArmaduraPecaDto> armaduraPecas,
            List<IniciativaModificadorDto> iniciativaModificadores,
            List<TesouroItemDto> tesouro,
            List<PvMaximoComponenteDto> pvMaximoComponentes,
            List<SlotMagiaDto> slotsMagia,
            Map<String, String> escolhasAtributo
    ) {
    }
}