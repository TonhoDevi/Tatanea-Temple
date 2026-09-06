package com.tatanea.templeinfo.alquimia.pocao;

import jakarta.persistence.*;

@Entity
@Table(name = "pocoes")
public class Pocao {

    @Id
    @Column(length = 64)
    private String id; // slug, ex: "pocao-cura"

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(nullable = false, length = 30)
    private String raridade;

    @Column(length = 20)
    private String icone;

    @Column(nullable = false, length = 120)
    private String formula;

    @Column(length = 60)
    private String duracao;

    @Column(columnDefinition = "TEXT")
    private String nucleo;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    @Column(columnDefinition = "TEXT")
    private String melhoria;

    protected Pocao() {
        // JPA
    }

    public Pocao(String id, String nome, String raridade, String icone, String formula,
                 String duracao, String nucleo, String descricao, String melhoria) {
        this.id = id;
        this.nome = nome;
        this.raridade = raridade;
        this.icone = icone;
        this.formula = formula;
        this.duracao = duracao;
        this.nucleo = nucleo;
        this.descricao = descricao;
        this.melhoria = melhoria;
    }

    public String getId() { return id; }
    public String getNome() { return nome; }
    public String getRaridade() { return raridade; }
    public String getIcone() { return icone; }
    public String getFormula() { return formula; }
    public String getDuracao() { return duracao; }
    public String getNucleo() { return nucleo; }
    public String getDescricao() { return descricao; }
    public String getMelhoria() { return melhoria; }
}
