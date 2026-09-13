package com.tatanea.templeinfo.personagem;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.personagem.PersonagemDtos.*;
import com.tatanea.templeinfo.talento.Talento;
import com.tatanea.templeinfo.talento.TalentoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class PersonagemService {

    private static final int LIMITE_PERSONAGENS_POR_USUARIO = 5;

    private final PersonagemRepository repository;
    private final TalentoRepository talentoRepository;

    public PersonagemService(PersonagemRepository repository, TalentoRepository talentoRepository) {
        this.repository = repository;
        this.talentoRepository = talentoRepository;
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
        if (repository.countByUsuarioId(usuarioId) >= LIMITE_PERSONAGENS_POR_USUARIO) {
            throw new LimitePersonagensExcedidoException(LIMITE_PERSONAGENS_POR_USUARIO);
        }
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

    public PersonagemDetalheDto adicionarTalento(String id, String usuarioId, Long talentoId) {
        Personagem p = buscarEValidarDono(id, usuarioId);
        Talento talento = talentoRepository.findById(talentoId)
                .orElseThrow(() -> new com.tatanea.templeinfo.talento.TalentoNaoEncontradoException(talentoId));

        if (p.temTalento(talentoId)) {
            throw new PreRequisitoTalentoNaoAtendidoException("Esse personagem já tem o talento " + talento.getNome() + ".");
        }
        if (talento.getAtributoRequerido() != null) {
            int valorAtual = valorAtributo(p, talento.getAtributoRequerido());
            if (valorAtual < talento.getValorMinimoAtributoRequerido()) {
                throw new PreRequisitoTalentoNaoAtendidoException(
                        "Requer " + talento.getAtributoRequerido().getCodigo() + " "
                                + talento.getValorMinimoAtributoRequerido() + " ou mais.");
            }
        }

        p.adicionarTalento(talento);
        p.tocarAtualizacao();
        return paraDetalhe(repository.save(p));
    }

    public PersonagemDetalheDto removerTalento(String id, String usuarioId, Long talentoId) {
        Personagem p = buscarEValidarDono(id, usuarioId);
        p.removerTalento(talentoId);
        p.tocarAtualizacao();
        return paraDetalhe(repository.save(p));
    }

    private int valorAtributo(Personagem p, Atributo atributo) {
        return switch (atributo) {
            case FORCA -> p.getForca();
            case DESTREZA -> p.getDestreza();
            case CONSTITUICAO -> p.getConstituicao();
            case INTELIGENCIA -> p.getInteligencia();
            case SABEDORIA -> p.getSabedoria();
            case CARISMA -> p.getCarisma();
        };
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
        p.setImagemDados(dto.imagemDados());
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
        p.setAtributoMagia(dto.atributoMagia());
        p.setBonusMagiaExtra(dto.bonusMagiaExtra());
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
        p.setBonusProficiencia(dto.bonusProficiencia());
        p.setLimiteSincronizados(dto.limiteSincronizados());
        p.setDetalheIdade(dto.detalheIdade());
        p.setDetalheAltura(dto.detalheAltura());
        p.setDetalhePeso(dto.detalhePeso());
        p.setDetalheCaracteristicas(dto.detalheCaracteristicas());
        p.setPersonalidadeTracos(dto.personalidadeTracos());
        p.setPersonalidadeIdeais(dto.personalidadeIdeais());
        p.setPersonalidadeVinculos(dto.personalidadeVinculos());
        p.setPersonalidadeDefeitos(dto.personalidadeDefeitos());
        p.setSalvaguardaForca(dto.salvaguardaForca());
        p.setSalvaguardaDestreza(dto.salvaguardaDestreza());
        p.setSalvaguardaConstituicao(dto.salvaguardaConstituicao());
        p.setSalvaguardaInteligencia(dto.salvaguardaInteligencia());
        p.setSalvaguardaSabedoria(dto.salvaguardaSabedoria());
        p.setSalvaguardaCarisma(dto.salvaguardaCarisma());

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
                List<AtaqueDano> danos = new ArrayList<>();
                if (d.danos() != null) {
                    for (AtaqueDanoDto dd : d.danos()) {
                        danos.add(new AtaqueDano(dd.quantidade(), dd.dado(), dd.bonus(), dd.tipoDano()));
                    }
                }
                p.getAtaques().add(new PersonagemAtaque(
                        p, d.nome(), d.bonusAtributo(), d.bonusProficiente(), d.bonusExtra(),
                        danos, d.descricao(), i
                ));
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
                p.getItensMagicos().add(new PersonagemItemMagico(p, d.nome(), d.descricao(), d.sincronizado(), i));
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
                p.getMagias().add(new PersonagemMagia(p, d.nivel(), d.nome(), d.preparada(), d.tempoConjuracao(), d.descricao(), i));
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

        p.getArmaduraPecas().clear();
        if (dto.armaduraPecas() != null) {
            List<ArmaduraPecaDto> lista = dto.armaduraPecas();
            for (int i = 0; i < lista.size(); i++) {
                ArmaduraPecaDto d = lista.get(i);
                p.getArmaduraPecas().add(new PersonagemArmaduraPeca(p, d.nome(), d.bonus(), i));
            }
        }

        p.getIniciativaModificadores().clear();
        if (dto.iniciativaModificadores() != null) {
            List<IniciativaModificadorDto> lista = dto.iniciativaModificadores();
            for (int i = 0; i < lista.size(); i++) {
                IniciativaModificadorDto d = lista.get(i);
                p.getIniciativaModificadores().add(new PersonagemIniciativaModificador(p, d.nome(), d.bonus(), i));
            }
        }

        p.getTesouro().clear();
        if (dto.tesouro() != null) {
            List<TesouroItemDto> lista = dto.tesouro();
            for (int i = 0; i < lista.size(); i++) {
                TesouroItemDto d = lista.get(i);
                p.getTesouro().add(new PersonagemTesouroItem(p, d.nome(), d.quantidade(), d.valorUnitario(), d.descricao(), i));
            }
        }

        p.getPvMaximoComponentes().clear();
        if (dto.pvMaximoComponentes() != null) {
            List<PvMaximoComponenteDto> lista = dto.pvMaximoComponentes();
            for (int i = 0; i < lista.size(); i++) {
                PvMaximoComponenteDto d = lista.get(i);
                p.getPvMaximoComponentes().add(new PersonagemPvMaximoComponente(p, d.nome(), d.bonus(), i));
            }
        }

        p.getSlotsMagia().clear();
        if (dto.slotsMagia() != null) {
            for (SlotMagiaDto d : dto.slotsMagia()) {
                p.getSlotsMagia().add(new PersonagemSlotMagia(p, d.nivel(), d.total(), d.restantes()));
            }
        }

        p.getEscolhasAtributo().clear();
        if (dto.escolhasAtributo() != null) {
            dto.escolhasAtributo().forEach((chave, atributo) -> {
                if (chave != null && !chave.isBlank() && atributo != null && !atributo.isBlank()) {
                    p.getEscolhasAtributo().put(chave, atributo);
                }
            });
        }
    }

    private PersonagemResumoDto paraResumo(Personagem p) {
        return new PersonagemResumoDto(
                p.getId(), p.getNome(), p.getTipo(), p.getRacaId(), p.getClasseId(),
                p.getNivel(), p.getImagemDados(), p.getPvAtual(), p.getPvMaximo()
        );
    }

    private PersonagemDetalheDto paraDetalhe(Personagem p) {
        List<PericiaDto> pericias = new ArrayList<>();
        for (PersonagemPericia x : p.getPericias()) {
            pericias.add(new PericiaDto(x.getPericia(), x.isProficiente(), x.isExpertise()));
        }

        List<AtaqueDto> ataques = new ArrayList<>();
        for (PersonagemAtaque x : p.getAtaques()) {
            List<AtaqueDanoDto> danos = new ArrayList<>();
            for (AtaqueDano d : x.getDanos()) {
                danos.add(new AtaqueDanoDto(d.getQuantidade(), d.getDado(), d.getBonus(), d.getTipoDano()));
            }
            ataques.add(new AtaqueDto(
                    x.getNome(), x.getBonusAtributo(), x.isBonusProficiente(), x.getBonusExtra(),
                    danos, x.getDescricao()
            ));
        }

        List<ItemInventarioDto> inventario = new ArrayList<>();
        for (PersonagemInventarioItem x : p.getInventario()) {
            inventario.add(new ItemInventarioDto(x.getNome(), x.getQuantidade(), x.getPeso(), x.getDescricao()));
        }

        List<ItemMagicoDto> itensMagicos = new ArrayList<>();
        for (PersonagemItemMagico x : p.getItensMagicos()) {
            itensMagicos.add(new ItemMagicoDto(x.getNome(), x.getDescricao(), x.isSincronizado()));
        }

        List<HabilidadeDto> habilidades = new ArrayList<>();
        for (PersonagemHabilidade x : p.getHabilidades()) {
            habilidades.add(new HabilidadeDto(x.getNome(), x.getDescricao()));
        }

        List<MagiaDto> magias = new ArrayList<>();
        for (PersonagemMagia x : p.getMagias()) {
            magias.add(new MagiaDto(x.getNivel(), x.getNome(), x.isPreparada(), x.getTempoConjuracao(), x.getDescricao()));
        }

        List<UnidadeDto> unidades = new ArrayList<>();
        for (PersonagemUnidade x : p.getUnidades()) {
            unidades.add(new UnidadeDto(x.getNome(), x.getTipo(), x.getDadosExtraJson()));
        }

        List<TagDto> tags = new ArrayList<>();
        for (PersonagemTag x : p.getTags()) {
            tags.add(new TagDto(x.getTipo(), x.getTexto()));
        }

        List<PersonagemTalentoDto> talentos = new ArrayList<>();
        for (PersonagemTalento x : p.getTalentos()) {
            Talento t = x.getTalento();
            talentos.add(new PersonagemTalentoDto(
                    t.getId(), t.getNome(), t.getDescricao(),
                    t.getAtributos().stream().map(com.tatanea.templeinfo.talento.TalentoDtos.AtributoDto::de).toList()
            ));
        }

        List<ArmaduraPecaDto> armaduraPecas = new ArrayList<>();
        for (PersonagemArmaduraPeca x : p.getArmaduraPecas()) {
            armaduraPecas.add(new ArmaduraPecaDto(x.getNome(), x.getBonus()));
        }

        List<IniciativaModificadorDto> iniciativaModificadores = new ArrayList<>();
        for (PersonagemIniciativaModificador x : p.getIniciativaModificadores()) {
            iniciativaModificadores.add(new IniciativaModificadorDto(x.getNome(), x.getBonus()));
        }

        List<TesouroItemDto> tesouro = new ArrayList<>();
        for (PersonagemTesouroItem x : p.getTesouro()) {
            tesouro.add(new TesouroItemDto(x.getNome(), x.getQuantidade(), x.getValorUnitario(), x.getDescricao()));
        }

        List<PvMaximoComponenteDto> pvMaximoComponentes = new ArrayList<>();
        for (PersonagemPvMaximoComponente x : p.getPvMaximoComponentes()) {
            pvMaximoComponentes.add(new PvMaximoComponenteDto(x.getNome(), x.getBonus()));
        }

        List<SlotMagiaDto> slotsMagia = new ArrayList<>();
        for (PersonagemSlotMagia x : p.getSlotsMagia()) {
            slotsMagia.add(new SlotMagiaDto(x.getNivel(), x.getTotal(), x.getRestantes()));
        }

        return new PersonagemDetalheDto(
                p.getId(), p.getNome(), p.getTipo(), p.getNomeJogador(), p.getRacaId(), p.getClasseId(),
                p.getNivel(), p.getImagemDados(),
                p.getForca(), p.getDestreza(), p.getConstituicao(), p.getInteligencia(), p.getSabedoria(), p.getCarisma(),
                p.getPvAtual(), p.getPvMaximo(), p.getPvTemporario(), p.getCa(), p.getDeslocamento(),
                p.getIniciativaBonus(), p.getAtributoMagia(), p.getBonusMagiaExtra(), p.isInspiracao(), p.getDadosVidaGastos(),
                p.getAntecedente(), p.getTendencia(), p.isPontoHeroico(),
                p.getMoedaPc(), p.getMoedaPp(), p.getMoedaPo(), p.getMoedaPe(), p.getMoedaPl(),
                p.getDeslocNadar(), p.getDeslocVoar(), p.getDeslocEscalar(), p.getSalto(),
                p.getIdiomas(), p.getHistoria(), p.getAnotacoes(),
                p.getBonusProficiencia(), p.getLimiteSincronizados(),
                p.getDetalheIdade(), p.getDetalheAltura(), p.getDetalhePeso(), p.getDetalheCaracteristicas(),
                p.getPersonalidadeTracos(), p.getPersonalidadeIdeais(), p.getPersonalidadeVinculos(), p.getPersonalidadeDefeitos(),
                p.isSalvaguardaForca(), p.isSalvaguardaDestreza(), p.isSalvaguardaConstituicao(),
                p.isSalvaguardaInteligencia(), p.isSalvaguardaSabedoria(), p.isSalvaguardaCarisma(),
                pericias, ataques, inventario, itensMagicos, habilidades, magias, unidades, tags, talentos,
                armaduraPecas, iniciativaModificadores, tesouro, pvMaximoComponentes, slotsMagia,
                new java.util.HashMap<>(p.getEscolhasAtributo())
        );
    }
}