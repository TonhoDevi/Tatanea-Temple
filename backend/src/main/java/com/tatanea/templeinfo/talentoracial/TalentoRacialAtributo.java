package com.tatanea.templeinfo.talentoracial;

import com.tatanea.templeinfo.comum.Atributo;
import jakarta.persistence.*;

@Entity
@Table(name = "talento_racial_atributos")
public class TalentoRacialAtributo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "talento_racial_id", nullable = false)
    private TalentoRacial talentoRacial;

    @Column(length = 20)
    private Atributo atributo; // null quando for bônus "à escolha"

    @Column(nullable = false)
    private int valor;

    @Column(name = "quantidade_escolhas")
    private Integer quantidadeEscolhas; // só preenchido quando atributo é null

    @Column(nullable = false)
    private int ordem;

    protected TalentoRacialAtributo() {
        // JPA
    }

    private TalentoRacialAtributo(TalentoRacial talentoRacial, Atributo atributo, int valor,
                                   Integer quantidadeEscolhas, int ordem) {
        this.talentoRacial = talentoRacial;
        this.atributo = atributo;
        this.valor = valor;
        this.quantidadeEscolhas = quantidadeEscolhas;
        this.ordem = ordem;
    }

    public static TalentoRacialAtributo fixo(TalentoRacial talentoRacial, Atributo atributo, int valor, int ordem) {
        return new TalentoRacialAtributo(talentoRacial, atributo, valor, null, ordem);
    }

    public static TalentoRacialAtributo escolha(TalentoRacial talentoRacial, int valor, int quantidadeEscolhas, int ordem) {
        return new TalentoRacialAtributo(talentoRacial, null, valor, quantidadeEscolhas, ordem);
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
