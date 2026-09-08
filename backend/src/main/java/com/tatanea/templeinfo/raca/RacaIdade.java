// ===== RacaIdade.java =====
package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;

@Entity
@Table(name = "raca_idade")
public class RacaIdade {

    @Id
    @Column(name = "raca_id")
    private Long racaId;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "raca_id")
    private Raca raca;

    @Column(name = "idade_adulta", nullable = false)
    private int idadeAdulta;

    @Column(name = "expectativa_vida", nullable = false)
    private int expectativaVida;

    protected RacaIdade() {
        // JPA
    }

    public RacaIdade(Raca raca, int idadeAdulta, int expectativaVida) {
        this.raca = raca;
        this.idadeAdulta = idadeAdulta;
        this.expectativaVida = expectativaVida;
    }

    public int getIdadeAdulta() { return idadeAdulta; }
    public int getExpectativaVida() { return expectativaVida; }

    public void setIdadeAdulta(int idadeAdulta) { this.idadeAdulta = idadeAdulta; }
    public void setExpectativaVida(int expectativaVida) { this.expectativaVida = expectativaVida; }
}