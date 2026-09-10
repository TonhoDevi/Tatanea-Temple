package com.tatanea.templeinfo.talentoracial;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.raca.Raca;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "talentos_raciais")
public class TalentoRacial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 64)
    private String slug;

    @Column(nullable = false, length = 120)
    private String nome;

    // Símbolo exibido no compêndio (emoji), ex: "⚔️".
    @Column(length = 20)
    private String icone;

    @Column(columnDefinition = "TEXT")
    private String historia;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    // Pré-requisitos — sempre os dois: talento racial é praticamente biológico,
    // então é preso à raça dona e só se manifesta a partir de um nível mínimo.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "raca_id", nullable = false)
    private Raca raca;

    @Column(name = "nivel_minimo", nullable = false)
    private int nivelMinimo;

    // Bônus de atributo recebido ao pegar o talento — mesma estrutura de TalentoAtributo/RacaAtributo.
    @OneToMany(mappedBy = "talentoRacial", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<TalentoRacialAtributo> atributos = new ArrayList<>();

    protected TalentoRacial() {
        // JPA
    }

    public TalentoRacial(String slug, String nome, String icone, String historia, String descricao,
                          Raca raca, int nivelMinimo) {
        this.slug = slug;
        this.nome = nome;
        this.icone = icone;
        this.historia = historia;
        this.descricao = descricao;
        this.raca = raca;
        this.nivelMinimo = nivelMinimo;
    }

    public void adicionarAtributoFixo(Atributo atributo, int valor, int ordem) {
        atributos.add(TalentoRacialAtributo.fixo(this, atributo, valor, ordem));
    }

    public void adicionarAtributoEscolha(int valor, int quantidadeEscolhas, int ordem) {
        atributos.add(TalentoRacialAtributo.escolha(this, valor, quantidadeEscolhas, ordem));
    }

    public Long getId() { return id; }
    public String getSlug() { return slug; }
    public String getNome() { return nome; }
    public String getIcone() { return icone; }
    public String getHistoria() { return historia; }
    public String getDescricao() { return descricao; }
    public Raca getRaca() { return raca; }
    public int getNivelMinimo() { return nivelMinimo; }
    public List<TalentoRacialAtributo> getAtributos() { return atributos; }

    public void setSlug(String slug) { this.slug = slug; }
    public void setNome(String nome) { this.nome = nome; }
    public void setIcone(String icone) { this.icone = icone; }
    public void setHistoria(String historia) { this.historia = historia; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
}
