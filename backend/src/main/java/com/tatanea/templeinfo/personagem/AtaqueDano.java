package com.tatanea.templeinfo.personagem;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class AtaqueDano {

    @Column(name = "dano_quantidade", nullable = false)
    private int quantidade;

    @Column(name = "dano_dado", length = 4)
    private String dado;

    @Column(name = "dano_bonus", nullable = false)
    private int bonus;

    @Column(name = "tipo_dano", length = 30)
    private String tipoDano;

    protected AtaqueDano() {
    }

    public AtaqueDano(int quantidade, String dado, int bonus, String tipoDano) {
        this.quantidade = quantidade;
        this.dado = dado;
        this.bonus = bonus;
        this.tipoDano = tipoDano;
    }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public String getDado() { return dado; }
    public void setDado(String dado) { this.dado = dado; }
    public int getBonus() { return bonus; }
    public void setBonus(int bonus) { this.bonus = bonus; }
    public String getTipoDano() { return tipoDano; }
    public void setTipoDano(String tipoDano) { this.tipoDano = tipoDano; }
}
