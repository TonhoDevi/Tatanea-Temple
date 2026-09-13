// ===== Raca.java =====
package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.comum.TipoHabilidade;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "racas")
public class Raca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 64)
    private String slug;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(nullable = false, length = 20)
    private CategoriaRaca categoria;

    @Column(nullable = false)
    private double deslocamento; // metros, base de caminhada (várias raças usam 4.5/7.5/10.5, convertidas de pés)

    @Column(nullable = false, length = 20)
    private TamanhoRaca tamanho;

    @Column(length = 200)
    private String quote;

    @Column(columnDefinition = "TEXT")
    private String idiomas;

    @Column(columnDefinition = "TEXT")
    private String anatomia;

    @Column(columnDefinition = "TEXT")
    private String aparencia;

    @Column(name = "nomes_raciais", columnDefinition = "TEXT")
    private String nomesRaciais;

    @Column(name = "tracos_culturais", columnDefinition = "TEXT")
    private String tracosCulturais;

    @Column(name = "criado_em", nullable = false)
    private LocalDateTime criadoEm;

    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @OneToMany(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<RacaAtributo> atributos = new ArrayList<>();

    @OneToMany(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<RacaHabilidadeEspecial> habilidadesEspeciais = new ArrayList<>();

    @OneToOne(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    private RacaAltura altura;

    @OneToOne(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    private RacaPeso peso;

    @OneToOne(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    private RacaIdade idade;

    @OneToOne(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    private RacaImagem imagem;

    protected Raca() {
        // JPA
    }

    public Raca(String slug, String nome, CategoriaRaca categoria, double deslocamento, TamanhoRaca tamanho) {
        this.slug = slug;
        this.nome = nome;
        this.categoria = categoria;
        this.deslocamento = deslocamento;
        this.tamanho = tamanho;
        this.criadoEm = LocalDateTime.now();
        this.atualizadoEm = LocalDateTime.now();
    }

    public void tocarAtualizacao() {
        this.atualizadoEm = LocalDateTime.now();
    }

    public void adicionarAtributoFixo(Atributo atributo, int valor, int ordem) {
        atributos.add(RacaAtributo.fixo(this, atributo, valor, ordem));
    }

    public void adicionarAtributoEscolha(int valor, int quantidadeEscolhas, int ordem) {
        atributos.add(RacaAtributo.escolha(this, valor, quantidadeEscolhas, ordem));
    }

    public void adicionarHabilidadeEspecial(String nome, String descricao, TipoHabilidade tipo, int ordem) {
        habilidadesEspeciais.add(new RacaHabilidadeEspecial(this, nome, descricao, tipo, ordem));
    }

    public void definirAltura(double valorMenor, double valorMedio, double valorMaior) {
        this.altura = new RacaAltura(this, valorMenor, valorMedio, valorMaior);
    }

    public void definirPeso(double valorMenor, double valorMedio, double valorMaior) {
        this.peso = new RacaPeso(this, valorMenor, valorMedio, valorMaior);
    }

    public void definirIdade(int idadeAdulta, int expectativaVida) {
        this.idade = new RacaIdade(this, idadeAdulta, expectativaVida);
    }

    public void definirImagem(byte[] conteudo, String contentType) {
        this.imagem = new RacaImagem(this, conteudo, contentType);
    }

    public Long getId() { return id; }
    public String getSlug() { return slug; }
    public String getNome() { return nome; }
    public CategoriaRaca getCategoria() { return categoria; }
    public double getDeslocamento() { return deslocamento; }
    public TamanhoRaca getTamanho() { return tamanho; }
    public String getQuote() { return quote; }
    public String getIdiomas() { return idiomas; }
    public String getAnatomia() { return anatomia; }
    public String getAparencia() { return aparencia; }
    public String getNomesRaciais() { return nomesRaciais; }
    public String getTracosCulturais() { return tracosCulturais; }
    public LocalDateTime getCriadoEm() { return criadoEm; }
    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }
    public List<RacaAtributo> getAtributos() { return atributos; }
    public List<RacaHabilidadeEspecial> getHabilidadesEspeciais() { return habilidadesEspeciais; }
    public RacaAltura getAltura() { return altura; }
    public RacaPeso getPeso() { return peso; }
    public RacaIdade getIdade() { return idade; }
    public RacaImagem getImagem() { return imagem; }

    public void setSlug(String slug) { this.slug = slug; }
    public void setNome(String nome) { this.nome = nome; }
    public void setCategoria(CategoriaRaca categoria) { this.categoria = categoria; }
    public void setDeslocamento(double deslocamento) { this.deslocamento = deslocamento; }
    public void setTamanho(TamanhoRaca tamanho) { this.tamanho = tamanho; }
    public void setQuote(String quote) { this.quote = quote; }
    public void setIdiomas(String idiomas) { this.idiomas = idiomas; }
    public void setAnatomia(String anatomia) { this.anatomia = anatomia; }
    public void setAparencia(String aparencia) { this.aparencia = aparencia; }
    public void setNomesRaciais(String nomesRaciais) { this.nomesRaciais = nomesRaciais; }
    public void setTracosCulturais(String tracosCulturais) { this.tracosCulturais = tracosCulturais; }
}