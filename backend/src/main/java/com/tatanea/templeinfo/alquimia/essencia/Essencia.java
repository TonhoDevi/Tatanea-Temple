package com.tatanea.templeinfo.alquimia.essencia;

import jakarta.persistence.*;

@Entity
@Table(name = "essencias")
public class Essencia {

    @Id
    @Column(length = 8)
    private String simbolo; // ex: "λ", "Φ", "Ω" — chave natural

    @Column(nullable = false, length = 60)
    private String nome;

    @Column(nullable = false, length = 20)
    private String cor;

    @Column(name = "cor_fundo", nullable = false, length = 40)
    private String corFundo;

    @Column(nullable = false, length = 60)
    private String elemento;

    protected Essencia() {
        // JPA
    }

    public Essencia(String simbolo, String nome, String cor, String corFundo, String elemento) {
        this.simbolo = simbolo;
        this.nome = nome;
        this.cor = cor;
        this.corFundo = corFundo;
        this.elemento = elemento;
    }

    public String getSimbolo() { return simbolo; }
    public String getNome() { return nome; }
    public String getCor() { return cor; }
    public String getCorFundo() { return corFundo; }
    public String getElemento() { return elemento; }
}
