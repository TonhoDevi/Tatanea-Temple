package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.comum.Atributo;
import jakarta.persistence.*;

@Entity
@Table(name = "talento_atributos")
public class TalentoAtributo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "talento_id", nullable = false)
    private Talento talento;

    @Column(length = 20)
    private Atributo atributo; // null quando for bônus "à escolha"

    @Column(nullable = false)
    private int valor;

    @Column(name = "quantidade_escolhas")
    private Integer quantidadeEscolhas; // só preenchido quando atributo é null

    @Column(nullable = false)
    private int ordem;

    protected TalentoAtributo() {
        // JPA
    }

    private TalentoAtributo(Talento talento, Atributo atributo, int valor, Integer quantidadeEscolhas, int ordem) {
        this.talento = talento;
        this.atributo = atributo;
        this.valor = valor;
        this.quantidadeEscolhas = quantidadeEscolhas;
        this.ordem = ordem;
    }

    public static TalentoAtributo fixo(Talento talento, Atributo atributo, int valor, int ordem) {
        return new TalentoAtributo(talento, atributo, valor, null, ordem);
    }

    public static TalentoAtributo escolha(Talento talento, int valor, int quantidadeEscolhas, int ordem) {
        return new TalentoAtributo(talento, null, valor, quantidadeEscolhas, ordem);
    }

    public boolean isEscolha() {
        return atributo == null;
    }

    public Long getId() { return id; }
    public Atributo getAtributo() { return atributo; }
    public int getValor() { return valor; }
    public Integer getQuantidadeEscolhas() { return quantidadeEscolhas; }
    public int getOrdem() { return ordem; }
}
