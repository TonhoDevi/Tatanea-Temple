package com.tatanea.templeinfo.personagem;

import com.tatanea.templeinfo.personagem.PersonagemDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class PersonagemService {

    private final PersonagemRepository repository;

    public PersonagemService(PersonagemRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<PersonagemResumoDto> listarDoUsuario(String usuarioId) {
        return repository.findByUsuarioId(usuarioId).stream()
                .map(this::paraResumo)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PersonagemDetalheDto buscar(String id, String usuarioId) {
        Personagem p = buscarEValidarDono(id, usuarioId);
        return paraDetalhe(p);
    }

    public PersonagemDetalheDto criar(String usuarioId, PersonagemRequestDto dto) {
        Personagem p = new Personagem(usuarioId, dto.nome());
        aplicarCampos(p, dto);
        return paraDetalhe(repository.save(p));
    }

    public PersonagemDetalheDto atualizar(String id, String usuarioId, PersonagemRequestDto dto) {
        Personagem p = buscarEValidarDono(id, usuarioId);
        aplicarCampos(p, dto);
        p.tocarAtualizacao();
        return paraDetalhe(repository.save(p));
    }

    public void remover(String id, String usuarioId) {
        Personagem p = buscarEValidarDono(id, usuarioId);
        repository.delete(p);
    }

    private Personagem buscarEValidarDono(String id, String usuarioId) {
        Personagem p = repository.findById(id)
                .orElseThrow(() -> new PersonagemNaoEncontradoException(id));
        if (!p.getUsuarioId().equals(usuarioId)) {
            throw new AcessoNegadoException();
        }
        return p;
    }

    private void aplicarCampos(Personagem p, PersonagemRequestDto dto) {
        p.setNome(dto.nome());
        if (dto.tipo() != null) p.setTipo(dto.tipo());
        p.setNomeJogador(dto.nomeJogador());
        p.setRacaId(dto.racaId());
        p.setClasseId(dto.classeId());
        p.setNivel(dto.nivel());
        p.setImagemUrl(dto.imagemUrl());
        p.setForca(dto.forca());
        p.setDestreza(dto.destreza());
        p.setConstituicao(dto.constituicao());
        p.setInteligencia(dto.inteligencia());
        p.setSabedoria(dto.sabedoria());
        p.setCarisma(dto.carisma());
        p.setPvAtual(dto.pvAtual());
        p.setPvMaximo(dto.pvMaximo());
        p.setPvTemporario(dto.pvTemporario());
        p.setCa(dto.ca());
        p.setDeslocamento(dto.deslocamento());
        p.setIniciativaBonus(dto.iniciativaBonus());
        p.setInspiracao(dto.inspiracao());
        p.setDadosVidaGastos(dto.dadosVidaGastos());
        p.setAntecedente(dto.antecedente());
        p.setTendencia(dto.tendencia());
        p.setPontoHeroico(dto.pontoHeroico());
        p.setMoedaPc(dto.moedaPc());
        p.setMoedaPp(dto.moedaPp());
        p.setMoedaPo(dto.moedaPo());
        p.setMoedaPe(dto.moedaPe());
        p.setMoedaPl(dto.moedaPl());
        p.setDeslocNadar(dto.deslocNadar());
        p.setDeslocVoar(dto.deslocVoar());
        p.setDeslocEscalar(dto.deslocEscalar());
        p.setSalto(dto.salto());
        p.setIdiomas(dto.idiomas());
        p.setHistoria(dto.historia());
        p.setAnotacoes(dto.anotacoes());

        p.getPericias().clear();
        if (dto.pericias() != null) {
            for (PericiaDto d : dto.pericias()) {
                p.getPericias().add(new PersonagemPericia(p, d.pericia(), d.proficiente(), d.expertise()));
            }
        }

        p.getAtaques().clear();
        if (dto.ataques() != null) {
            List<AtaqueDto> lista = dto.ataques();
            for (int i = 0; i < lista.size(); i++) {
                AtaqueDto d = lista.get(i);
                p.getAtaques().add(new PersonagemAtaque(p, d.nome(), d.bonusAtaque(), d.dano(), d.tipoDano(), i));
            }
        }

        p.getInventario().clear();
        if (dto.inventario() != null) {
            List<ItemInventarioDto> lista = dto.inventario();
            for (int i = 0; i < lista.size(); i++) {
                ItemInventarioDto d = lista.get(i);
                p.getInventario().add(new PersonagemInventarioItem(p, d.nome(), d.quantidade(), d.peso(), d.descricao(), i));
            }
        }

        p.getItensMagicos().clear();
        if (dto.itensMagicos() != null) {
            List<ItemMagicoDto> lista = dto.itensMagicos();
            for (int i = 0; i < lista.size(); i++) {
                ItemMagicoDto d = lista.get(i);
                p.getItensMagicos().add(new PersonagemItemMagico(p, d.nome(), d.descricao(), i));
            }
        }

        p.getHabilidades().clear();
        if (dto.habilidades() != null) {
            List<HabilidadeDto> lista = dto.habilidades();
            for (int i = 0; i < lista.size(); i++) {
                HabilidadeDto d = lista.get(i);
                p.getHabilidades().add(new PersonagemHabilidade(p, d.nome(), d.descricao(), i));
            }
        }

        p.getMagias().clear();
        if (dto.magias() != null) {
            List<MagiaDto> lista = dto.magias();
            for (int i = 0; i < lista.size(); i++) {
                MagiaDto d = lista.get(i);
                p.getMagias().add(new PersonagemMagia(p, d.nivel(), d.nome(), d.preparada(), i));
            }
        }

        p.getUnidades().clear();
        if (dto.unidades() != null) {
            List<UnidadeDto> lista = dto.unidades();
            for (int i = 0; i < lista.size(); i++) {
                UnidadeDto d = lista.get(i);
                p.getUnidades().add(new PersonagemUnidade(p, d.nome(), d.tipo(), d.dadosExtraJson(), i));
            }
        }

        p.getTags().clear();
        if (dto.tags() != null) {
            List<TagDto> lista = dto.tags();
            for (int i = 0; i < lista.size(); i++) {
                TagDto d = lista.get(i);
                p.getTags().add(new PersonagemTag(p, d.tipo(), d.texto(), i));
            }
        }
    }

    private PersonagemResumoDto paraResumo(Personagem p) {
        return new PersonagemResumoDto(
                p.getId(), p.getNome(), p.getTipo(), p.getRacaId(), p.getClasseId(),
                p.getNivel(), p.getImagemUrl(), p.getPvAtual(), p.getPvMaximo()
        );
    }

    private PersonagemDetalheDto paraDetalhe(Personagem p) {
        List<PericiaDto> pericias = new ArrayList<>();
        for (PersonagemPericia x : p.getPericias()) {
            pericias.add(new PericiaDto(x.getPericia(), x.isProficiente(), x.isExpertise()));
        }

        List<AtaqueDto> ataques = new ArrayList<>();
        for (PersonagemAtaque x : p.getAtaques()) {
            ataques.add(new AtaqueDto(x.getNome(), x.getBonusAtaque(), x.getDano(), x.getTipoDano()));
        }

        List<ItemInventarioDto> inventario = new ArrayList<>();
        for (PersonagemInventarioItem x : p.getInventario()) {
            inventario.add(new ItemInventarioDto(x.getNome(), x.getQuantidade(), x.getPeso(), x.getDescricao()));
        }

        List<ItemMagicoDto> itensMagicos = new ArrayList<>();
        for (PersonagemItemMagico x : p.getItensMagicos()) {
            itensMagicos.add(new ItemMagicoDto(x.getNome(), x.getDescricao()));
        }

        List<HabilidadeDto> habilidades = new ArrayList<>();
        for (PersonagemHabilidade x : p.getHabilidades()) {
            habilidades.add(new HabilidadeDto(x.getNome(), x.getDescricao()));
        }

        List<MagiaDto> magias = new ArrayList<>();
        for (PersonagemMagia x : p.getMagias()) {
            magias.add(new MagiaDto(x.getNivel(), x.getNome(), x.isPreparada()));
        }

        List<UnidadeDto> unidades = new ArrayList<>();
        for (PersonagemUnidade x : p.getUnidades()) {
            unidades.add(new UnidadeDto(x.getNome(), x.getTipo(), x.getDadosExtraJson()));
        }

        List<TagDto> tags = new ArrayList<>();
        for (PersonagemTag x : p.getTags()) {
            tags.add(new TagDto(x.getTipo(), x.getTexto()));
        }

        return new PersonagemDetalheDto(
                p.getId(), p.getNome(), p.getTipo(), p.getNomeJogador(), p.getRacaId(), p.getClasseId(),
                p.getNivel(), p.getImagemUrl(),
                p.getForca(), p.getDestreza(), p.getConstituicao(), p.getInteligencia(), p.getSabedoria(), p.getCarisma(),
                p.getPvAtual(), p.getPvMaximo(), p.getPvTemporario(), p.getCa(), p.getDeslocamento(),
                p.getIniciativaBonus(), p.isInspiracao(), p.getDadosVidaGastos(),
                p.getAntecedente(), p.getTendencia(), p.isPontoHeroico(),
                p.getMoedaPc(), p.getMoedaPp(), p.getMoedaPo(), p.getMoedaPe(), p.getMoedaPl(),
                p.getDeslocNadar(), p.getDeslocVoar(), p.getDeslocEscalar(), p.getSalto(),
                p.getIdiomas(), p.getHistoria(), p.getAnotacoes(),
                pericias, ataques, inventario, itensMagicos, habilidades, magias, unidades, tags
        );
    }
}