package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_inventario")
public class PersonagemInventarioItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(nullable = false, length = 160)
    private String nome;

    private int quantidade = 1;

    private Double peso;

    @Column(length = 500)
    private String descricao;

    private int ordem;

    protected PersonagemInventarioItem() {
    }

    public PersonagemInventarioItem(Personagem personagem, String nome, int quantidade, Double peso, String descricao, int ordem) {
        this.personagem = personagem;
        this.nome = nome;
        this.quantidade = quantidade;
        this.peso = peso;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public Double getPeso() { return peso; }
    public void setPeso(Double peso) { this.peso = peso; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}