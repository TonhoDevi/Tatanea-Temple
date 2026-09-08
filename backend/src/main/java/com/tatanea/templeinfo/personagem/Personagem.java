package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
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

    @Column(name = "imagem_url", length = 300)
    private String imagemUrl;

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

    @Column(length = 20)
    private String deslocamento;

    @Column(name = "iniciativa_bonus")
    private int iniciativaBonus;

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

    @Column(name = "desloc_nadar", length = 20)
    private String deslocNadar;

    @Column(name = "desloc_voar", length = 20)
    private String deslocVoar;

    @Column(name = "desloc_escalar", length = 20)
    private String deslocEscalar;

    @Column(length = 20)
    private String salto;

    @Column(length = 5000)
    private String idiomas;

    @Column(length = 5000)
    private String historia;

    @Column(length = 5000)
    private String anotacoes;

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
    public String getImagemUrl() { return imagemUrl; }
    public void setImagemUrl(String imagemUrl) { this.imagemUrl = imagemUrl; }
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
    public String getDeslocamento() { return deslocamento; }
    public void setDeslocamento(String deslocamento) { this.deslocamento = deslocamento; }
    public int getIniciativaBonus() { return iniciativaBonus; }
    public void setIniciativaBonus(int iniciativaBonus) { this.iniciativaBonus = iniciativaBonus; }
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
    public String getDeslocNadar() { return deslocNadar; }
    public void setDeslocNadar(String deslocNadar) { this.deslocNadar = deslocNadar; }
    public String getDeslocVoar() { return deslocVoar; }
    public void setDeslocVoar(String deslocVoar) { this.deslocVoar = deslocVoar; }
    public String getDeslocEscalar() { return deslocEscalar; }
    public void setDeslocEscalar(String deslocEscalar) { this.deslocEscalar = deslocEscalar; }
    public String getSalto() { return salto; }
    public void setSalto(String salto) { this.salto = salto; }
    public String getIdiomas() { return idiomas; }
    public void setIdiomas(String idiomas) { this.idiomas = idiomas; }
    public String getHistoria() { return historia; }
    public void setHistoria(String historia) { this.historia = historia; }
    public String getAnotacoes() { return anotacoes; }
    public void setAnotacoes(String anotacoes) { this.anotacoes = anotacoes; }
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
}