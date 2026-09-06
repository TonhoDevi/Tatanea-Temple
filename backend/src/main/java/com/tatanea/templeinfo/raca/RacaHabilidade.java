package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;

@Entity
@Table(name = "raca_habilidades")
public class RacaHabilidade {

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

    @Column(nullable = false)
    private int ordem;

    protected RacaHabilidade() {
        // JPA
    }

    public RacaHabilidade(Raca raca, String nome, String descricao, int ordem) {
        this.raca = raca;
        this.nome = nome;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public int getOrdem() { return ordem; }
}
