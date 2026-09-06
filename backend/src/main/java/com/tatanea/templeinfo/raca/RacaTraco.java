package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;

@Entity
@Table(name = "raca_tracos")
public class RacaTraco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "raca_id", nullable = false)
    private Raca raca;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String texto;

    @Column(nullable = false)
    private int ordem;

    protected RacaTraco() {
        // JPA
    }

    public RacaTraco(Raca raca, String texto, int ordem) {
        this.raca = raca;
        this.texto = texto;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public String getTexto() { return texto; }
    public int getOrdem() { return ordem; }
}
