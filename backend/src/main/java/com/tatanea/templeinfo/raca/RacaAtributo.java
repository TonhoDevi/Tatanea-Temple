// ===== RacaAtributo.java =====
package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.comum.Atributo;
import jakarta.persistence.*;

@Entity
@Table(name = "raca_atributos")
public class RacaAtributo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "raca_id", nullable = false)
    private Raca raca;

    @Column(length = 20)
    private Atributo atributo; // null quando for bônus "à escolha"

    @Column(nullable = false)
    private int valor;

    @Column(name = "quantidade_escolhas")
    private Integer quantidadeEscolhas; // só preenchido quando atributo é null

    @Column(nullable = false)
    private int ordem;

    protected RacaAtributo() {
        // JPA
    }

    private RacaAtributo(Raca raca, Atributo atributo, int valor, Integer quantidadeEscolhas, int ordem) {
        this.raca = raca;
        this.atributo = atributo;
        this.valor = valor;
        this.quantidadeEscolhas = quantidadeEscolhas;
        this.ordem = ordem;
    }

    public static RacaAtributo fixo(Raca raca, Atributo atributo, int valor, int ordem) {
        return new RacaAtributo(raca, atributo, valor, null, ordem);
    }

    public static RacaAtributo escolha(Raca raca, int valor, int quantidadeEscolhas, int ordem) {
        return new RacaAtributo(raca, null, valor, quantidadeEscolhas, ordem);
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