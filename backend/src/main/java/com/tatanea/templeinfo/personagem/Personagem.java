package com.tatanea.templeinfo.personagem;

import com.tatanea.templeinfo.talento.Talento;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "personagens")
public class Personagem {

    @Id
    @Column(length = 36)
    private String id;

    @Column(name = "usuario_id", nullable = false, length = 36)
    private String usuarioId;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(nullable = false, length = 20)
    private String tipo = "dnd";

    @Column(name = "nome_jogador", length = 120)
    private String nomeJogador;

    @Column(name = "raca_id")
    private Long racaId;

    @Column(name = "classe_id", length = 64)
    private String classeId;

    @Column(nullable = false)
    private int nivel = 1;

    // Imagem embutida como data URI (base64) — não há upload/armazenamento de
    // arquivo separado, então o valor já vem pronto pra virar <img src>.
    @Column(name = "imagem_dados", columnDefinition = "TEXT")
    private String imagemDados;

    private int forca = 10;
    private int destreza = 10;
    private int constituicao = 10;
    private int inteligencia = 10;
    private int sabedoria = 10;
    private int carisma = 10;

    @Column(name = "pv_atual")
    private int pvAtual;

    @Column(name = "pv_maximo")
    private int pvMaximo;

    @Column(name = "pv_temporario")
    private int pvTemporario;

    private int ca = 10;

    @Column(columnDefinition = "DECIMAL(6,2)")
    private Double deslocamento;

    @Column(name = "iniciativa_bonus")
    private int iniciativaBonus;

    @Column(name = "atributo_magia", length = 20)
    private String atributoMagia;

    @Column(name = "bonus_magia_extra")
    private int bonusMagiaExtra;

    private boolean inspiracao;

    @Column(name = "dados_vida_gastos")
    private int dadosVidaGastos;

    @Column(length = 120)
    private String antecedente;

    @Column(length = 60)
    private String tendencia;

    @Column(name = "ponto_heroico")
    private boolean pontoHeroico;

    @Column(name = "moeda_pc")
    private int moedaPc;

    @Column(name = "moeda_pp")
    private int moedaPp;

    @Column(name = "moeda_po")
    private int moedaPo;

    @Column(name = "moeda_pe")
    private int moedaPe;

    @Column(name = "moeda_pl")
    private int moedaPl;

    @Column(name = "desloc_nadar", columnDefinition = "DECIMAL(6,2)")
    private Double deslocNadar;

    @Column(name = "desloc_voar", columnDefinition = "DECIMAL(6,2)")
    private Double deslocVoar;

    @Column(name = "desloc_escalar", columnDefinition = "DECIMAL(6,2)")
    private Double deslocEscalar;

    @Column(columnDefinition = "DECIMAL(6,2)")
    private Double salto;

    @Column(length = 5000)
    private String idiomas;

    @Column(length = 5000)
    private String historia;

    @Column(length = 5000)
    private String anotacoes;

    @Column(name = "bonus_proficiencia")
    private int bonusProficiencia = 2;

    @Column(name = "limite_sincronizados")
    private int limiteSincronizados = 3;

    @Column(name = "detalhe_idade")
    private Integer detalheIdade;

    @Column(name = "detalhe_altura")
    private Integer detalheAltura;

    @Column(name = "detalhe_peso")
    private Integer detalhePeso;

    @Column(name = "detalhe_caracteristicas", length = 2000)
    private String detalheCaracteristicas;

    @Column(name = "personalidade_tracos", length = 2000)
    private String personalidadeTracos;

    @Column(name = "personalidade_ideais", length = 2000)
    private String personalidadeIdeais;

    @Column(name = "personalidade_vinculos", length = 2000)
    private String personalidadeVinculos;

    @Column(name = "personalidade_defeitos", length = 2000)
    private String personalidadeDefeitos;

    @Column(name = "salvaguarda_forca")
    private boolean salvaguardaForca;

    @Column(name = "salvaguarda_destreza")
    private boolean salvaguardaDestreza;

    @Column(name = "salvaguarda_constituicao")
    private boolean salvaguardaConstituicao;

    @Column(name = "salvaguarda_inteligencia")
    private boolean salvaguardaInteligencia;

    @Column(name = "salvaguarda_sabedoria")
    private boolean salvaguardaSabedoria;

    @Column(name = "salvaguarda_carisma")
    private boolean salvaguardaCarisma;

    @Column(name = "criado_em", nullable = false)
    private LocalDateTime criadoEm;

    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PersonagemPericia> pericias = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemAtaque> ataques = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemInventarioItem> inventario = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemItemMagico> itensMagicos = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemHabilidade> habilidades = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("nivel ASC, ordem ASC")
    private List<PersonagemMagia> magias = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemUnidade> unidades = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemTag> tags = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemTalento> talentos = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemArmaduraPeca> armaduraPecas = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemIniciativaModificador> iniciativaModificadores = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemTesouroItem> tesouro = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<PersonagemPvMaximoComponente> pvMaximoComponentes = new ArrayList<>();

    @OneToMany(mappedBy = "personagem", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("nivel ASC")
    private List<PersonagemSlotMagia> slotsMagia = new ArrayList<>();

    // Escolha de atributo pra bônus "à escolha" (de raça ou de talento) — chave
    // no formato "raca-<racaId>-<atributoIndex>-<n>" ou "talento-<talentoId>-<atributoIndex>-<n>",
    // valor é a chave do atributo escolhido (ex.: "forca").
    @ElementCollection
    @CollectionTable(name = "personagem_escolhas_atributo", joinColumns = @JoinColumn(name = "personagem_id"))
    @MapKeyColumn(name = "chave", length = 40)
    @Column(name = "atributo", length = 20)
    private Map<String, String> escolhasAtributo = new HashMap<>();

    protected Personagem() {
    }

    public Personagem(String usuarioId, String nome) {
        this.id = UUID.randomUUID().toString();
        this.usuarioId = usuarioId;
        this.nome = nome;
        this.criadoEm = LocalDateTime.now();
        this.atualizadoEm = LocalDateTime.now();
    }

    public void tocarAtualizacao() {
        this.atualizadoEm = LocalDateTime.now();
    }

    public void adicionarTalento(Talento talento) {
        this.talentos.add(new PersonagemTalento(this, talento, talentos.size()));
    }

    public void removerTalento(Long talentoId) {
        this.talentos.removeIf(pt -> pt.getTalento().getId().equals(talentoId));
    }

    public boolean temTalento(Long talentoId) {
        return this.talentos.stream().anyMatch(pt -> pt.getTalento().getId().equals(talentoId));
    }

    public List<PersonagemTalento> getTalentos() { return talentos; }

    public String getId() { return id; }
    public String getUsuarioId() { return usuarioId; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getNomeJogador() { return nomeJogador; }
    public void setNomeJogador(String nomeJogador) { this.nomeJogador = nomeJogador; }
    public Long getRacaId() { return racaId; }
    public void setRacaId(Long racaId) { this.racaId = racaId; }
    public String getClasseId() { return classeId; }
    public void setClasseId(String classeId) { this.classeId = classeId; }
    public int getNivel() { return nivel; }
    public void setNivel(int nivel) { this.nivel = nivel; }
    public String getImagemDados() { return imagemDados; }
    public void setImagemDados(String imagemDados) { this.imagemDados = imagemDados; }
    public int getForca() { return forca; }
    public void setForca(int forca) { this.forca = forca; }
    public int getDestreza() { return destreza; }
    public void setDestreza(int destreza) { this.destreza = destreza; }
    public int getConstituicao() { return constituicao; }
    public void setConstituicao(int constituicao) { this.constituicao = constituicao; }
    public int getInteligencia() { return inteligencia; }
    public void setInteligencia(int inteligencia) { this.inteligencia = inteligencia; }
    public int getSabedoria() { return sabedoria; }
    public void setSabedoria(int sabedoria) { this.sabedoria = sabedoria; }
    public int getCarisma() { return carisma; }
    public void setCarisma(int carisma) { this.carisma = carisma; }
    public int getPvAtual() { return pvAtual; }
    public void setPvAtual(int pvAtual) { this.pvAtual = pvAtual; }
    public int getPvMaximo() { return pvMaximo; }
    public void setPvMaximo(int pvMaximo) { this.pvMaximo = pvMaximo; }
    public int getPvTemporario() { return pvTemporario; }
    public void setPvTemporario(int pvTemporario) { this.pvTemporario = pvTemporario; }
    public int getCa() { return ca; }
    public void setCa(int ca) { this.ca = ca; }
    public Double getDeslocamento() { return deslocamento; }
    public void setDeslocamento(Double deslocamento) { this.deslocamento = deslocamento; }
    public int getIniciativaBonus() { return iniciativaBonus; }
    public void setIniciativaBonus(int iniciativaBonus) { this.iniciativaBonus = iniciativaBonus; }
    public String getAtributoMagia() { return atributoMagia; }
    public void setAtributoMagia(String atributoMagia) { this.atributoMagia = atributoMagia; }
    public int getBonusMagiaExtra() { return bonusMagiaExtra; }
    public void setBonusMagiaExtra(int bonusMagiaExtra) { this.bonusMagiaExtra = bonusMagiaExtra; }
    public boolean isInspiracao() { return inspiracao; }
    public void setInspiracao(boolean inspiracao) { this.inspiracao = inspiracao; }
    public int getDadosVidaGastos() { return dadosVidaGastos; }
    public void setDadosVidaGastos(int dadosVidaGastos) { this.dadosVidaGastos = dadosVidaGastos; }
    public String getAntecedente() { return antecedente; }
    public void setAntecedente(String antecedente) { this.antecedente = antecedente; }
    public String getTendencia() { return tendencia; }
    public void setTendencia(String tendencia) { this.tendencia = tendencia; }
    public boolean isPontoHeroico() { return pontoHeroico; }
    public void setPontoHeroico(boolean pontoHeroico) { this.pontoHeroico = pontoHeroico; }
    public int getMoedaPc() { return moedaPc; }
    public void setMoedaPc(int moedaPc) { this.moedaPc = moedaPc; }
    public int getMoedaPp() { return moedaPp; }
    public void setMoedaPp(int moedaPp) { this.moedaPp = moedaPp; }
    public int getMoedaPo() { return moedaPo; }
    public void setMoedaPo(int moedaPo) { this.moedaPo = moedaPo; }
    public int getMoedaPe() { return moedaPe; }
    public void setMoedaPe(int moedaPe) { this.moedaPe = moedaPe; }
    public int getMoedaPl() { return moedaPl; }
    public void setMoedaPl(int moedaPl) { this.moedaPl = moedaPl; }
    public Double getDeslocNadar() { return deslocNadar; }
    public void setDeslocNadar(Double deslocNadar) { this.deslocNadar = deslocNadar; }
    public Double getDeslocVoar() { return deslocVoar; }
    public void setDeslocVoar(Double deslocVoar) { this.deslocVoar = deslocVoar; }
    public Double getDeslocEscalar() { return deslocEscalar; }
    public void setDeslocEscalar(Double deslocEscalar) { this.deslocEscalar = deslocEscalar; }
    public Double getSalto() { return salto; }
    public void setSalto(Double salto) { this.salto = salto; }
    public String getIdiomas() { return idiomas; }
    public void setIdiomas(String idiomas) { this.idiomas = idiomas; }
    public String getHistoria() { return historia; }
    public void setHistoria(String historia) { this.historia = historia; }
    public String getAnotacoes() { return anotacoes; }
    public void setAnotacoes(String anotacoes) { this.anotacoes = anotacoes; }
    public int getBonusProficiencia() { return bonusProficiencia; }
    public void setBonusProficiencia(int bonusProficiencia) { this.bonusProficiencia = bonusProficiencia; }
    public int getLimiteSincronizados() { return limiteSincronizados; }
    public void setLimiteSincronizados(int limiteSincronizados) { this.limiteSincronizados = limiteSincronizados; }
    public Integer getDetalheIdade() { return detalheIdade; }
    public void setDetalheIdade(Integer detalheIdade) { this.detalheIdade = detalheIdade; }
    public Integer getDetalheAltura() { return detalheAltura; }
    public void setDetalheAltura(Integer detalheAltura) { this.detalheAltura = detalheAltura; }
    public Integer getDetalhePeso() { return detalhePeso; }
    public void setDetalhePeso(Integer detalhePeso) { this.detalhePeso = detalhePeso; }
    public String getDetalheCaracteristicas() { return detalheCaracteristicas; }
    public void setDetalheCaracteristicas(String detalheCaracteristicas) { this.detalheCaracteristicas = detalheCaracteristicas; }
    public String getPersonalidadeTracos() { return personalidadeTracos; }
    public void setPersonalidadeTracos(String personalidadeTracos) { this.personalidadeTracos = personalidadeTracos; }
    public String getPersonalidadeIdeais() { return personalidadeIdeais; }
    public void setPersonalidadeIdeais(String personalidadeIdeais) { this.personalidadeIdeais = personalidadeIdeais; }
    public String getPersonalidadeVinculos() { return personalidadeVinculos; }
    public void setPersonalidadeVinculos(String personalidadeVinculos) { this.personalidadeVinculos = personalidadeVinculos; }
    public String getPersonalidadeDefeitos() { return personalidadeDefeitos; }
    public void setPersonalidadeDefeitos(String personalidadeDefeitos) { this.personalidadeDefeitos = personalidadeDefeitos; }
    public boolean isSalvaguardaForca() { return salvaguardaForca; }
    public void setSalvaguardaForca(boolean salvaguardaForca) { this.salvaguardaForca = salvaguardaForca; }
    public boolean isSalvaguardaDestreza() { return salvaguardaDestreza; }
    public void setSalvaguardaDestreza(boolean salvaguardaDestreza) { this.salvaguardaDestreza = salvaguardaDestreza; }
    public boolean isSalvaguardaConstituicao() { return salvaguardaConstituicao; }
    public void setSalvaguardaConstituicao(boolean salvaguardaConstituicao) { this.salvaguardaConstituicao = salvaguardaConstituicao; }
    public boolean isSalvaguardaInteligencia() { return salvaguardaInteligencia; }
    public void setSalvaguardaInteligencia(boolean salvaguardaInteligencia) { this.salvaguardaInteligencia = salvaguardaInteligencia; }
    public boolean isSalvaguardaSabedoria() { return salvaguardaSabedoria; }
    public void setSalvaguardaSabedoria(boolean salvaguardaSabedoria) { this.salvaguardaSabedoria = salvaguardaSabedoria; }
    public boolean isSalvaguardaCarisma() { return salvaguardaCarisma; }
    public void setSalvaguardaCarisma(boolean salvaguardaCarisma) { this.salvaguardaCarisma = salvaguardaCarisma; }
    public LocalDateTime getCriadoEm() { return criadoEm; }
    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }

    public List<PersonagemPericia> getPericias() { return pericias; }
    public List<PersonagemAtaque> getAtaques() { return ataques; }
    public List<PersonagemInventarioItem> getInventario() { return inventario; }
    public List<PersonagemItemMagico> getItensMagicos() { return itensMagicos; }
    public List<PersonagemHabilidade> getHabilidades() { return habilidades; }
    public List<PersonagemMagia> getMagias() { return magias; }
    public List<PersonagemUnidade> getUnidades() { return unidades; }
    public List<PersonagemTag> getTags() { return tags; }
    public List<PersonagemArmaduraPeca> getArmaduraPecas() { return armaduraPecas; }
    public List<PersonagemIniciativaModificador> getIniciativaModificadores() { return iniciativaModificadores; }
    public List<PersonagemTesouroItem> getTesouro() { return tesouro; }
    public List<PersonagemPvMaximoComponente> getPvMaximoComponentes() { return pvMaximoComponentes; }
    public List<PersonagemSlotMagia> getSlotsMagia() { return slotsMagia; }
    public Map<String, String> getEscolhasAtributo() { return escolhasAtributo; }
}