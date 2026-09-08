// ===== RacaAltura.java =====
package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;

@Entity
@Table(name = "raca_altura")
public class RacaAltura {

    @Id
    @Column(name = "raca_id")
    private Long racaId;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "raca_id")
    private Raca raca;

    @Column(name = "valor_menor", nullable = false)
    private double valorMenor;

    @Column(name = "valor_medio", nullable = false)
    private double valorMedio;

    @Column(name = "valor_maior", nullable = false)
    private double valorMaior;

    protected RacaAltura() {
        // JPA
    }

    public RacaAltura(Raca raca, double valorMenor, double valorMedio, double valorMaior) {
        this.raca = raca;
        this.valorMenor = valorMenor;
        this.valorMedio = valorMedio;
        this.valorMaior = valorMaior;
    }

    public double getValorMenor() { return valorMenor; }
    public double getValorMedio() { return valorMedio; }
    public double getValorMaior() { return valorMaior; }

    public void setValorMenor(double valorMenor) { this.valorMenor = valorMenor; }
    public void setValorMedio(double valorMedio) { this.valorMedio = valorMedio; }
    public void setValorMaior(double valorMaior) { this.valorMaior = valorMaior; }
}