package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.raca.Raca;
import jakarta.persistence.*;

@Entity
@Table(name = "talentos")
public class Talento {

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

    // Atributo recebido ao pegar o talento — a maioria dos talentos tem, alguns não.
    @Column(name = "atributo_recebido", length = 20)
    private Atributo atributoRecebido;

    @Column(name = "valor_atributo_recebido")
    private Integer valorAtributoRecebido;

    // Pré-requisitos — ambos opcionais, e combinam com E quando os dois estão presentes.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "raca_requerida_id")
    private Raca racaRequerida;

    @Column(name = "atributo_requerido", length = 20)
    private Atributo atributoRequerido;

    @Column(name = "valor_minimo_atributo_requerido")
    private Integer valorMinimoAtributoRequerido;

    protected Talento() {
        // JPA
    }

    public Talento(String slug, String nome, String icone, String historia, String descricao) {
        this.slug = slug;
        this.nome = nome;
        this.icone = icone;
        this.historia = historia;
        this.descricao = descricao;
    }

    public void definirAtributoRecebido(Atributo atributo, int valor) {
        this.atributoRecebido = atributo;
        this.valorAtributoRecebido = valor;
    }

    public void definirPreRequisitoRaca(Raca raca) {
        this.racaRequerida = raca;
    }

    public void definirPreRequisitoAtributo(Atributo atributo, int valorMinimo) {
        this.atributoRequerido = atributo;
        this.valorMinimoAtributoRequerido = valorMinimo;
    }

    public Long getId() { return id; }
    public String getSlug() { return slug; }
    public String getNome() { return nome; }
    public String getIcone() { return icone; }
    public String getHistoria() { return historia; }
    public String getDescricao() { return descricao; }
    public Atributo getAtributoRecebido() { return atributoRecebido; }
    public Integer getValorAtributoRecebido() { return valorAtributoRecebido; }
    public Raca getRacaRequerida() { return racaRequerida; }
    public Atributo getAtributoRequerido() { return atributoRequerido; }
    public Integer getValorMinimoAtributoRequerido() { return valorMinimoAtributoRequerido; }

    public void setSlug(String slug) { this.slug = slug; }
    public void setNome(String nome) { this.nome = nome; }
    public void setIcone(String icone) { this.icone = icone; }
    public void setHistoria(String historia) { this.historia = historia; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
}
