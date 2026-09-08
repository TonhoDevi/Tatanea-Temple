// ===== RacaHabilidadeEspecial.java =====
package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.comum.TipoHabilidade;
import jakarta.persistence.*;

@Entity
@Table(name = "raca_habilidade_especial")
public class RacaHabilidadeEspecial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "raca_id", nullable = false)
    private Raca raca;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String descricao;

    @Column(nullable = false, length = 20)
    private TipoHabilidade tipo;

    @Column(nullable = false)
    private int ordem;

    protected RacaHabilidadeEspecial() {
        // JPA
    }

    public RacaHabilidadeEspecial(Raca raca, String nome, String descricao, TipoHabilidade tipo, int ordem) {
        this.raca = raca;
        this.nome = nome;
        this.descricao = descricao;
        this.tipo = tipo;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public TipoHabilidade getTipo() { return tipo; }
    public int getOrdem() { return ordem; }
}