package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_tesouro")
public class PersonagemTesouroItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(length = 160)
    private String nome;

    private int quantidade;

    @Column(name = "valor_unitario")
    private double valorUnitario;

    @Column(length = 500)
    private String descricao;

    private int ordem;

    protected PersonagemTesouroItem() {
    }

    public PersonagemTesouroItem(Personagem personagem, String nome, int quantidade, double valorUnitario, String descricao, int ordem) {
        this.personagem = personagem;
        this.nome = nome;
        this.quantidade = quantidade;
        this.valorUnitario = valorUnitario;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public double getValorUnitario() { return valorUnitario; }
    public void setValorUnitario(double valorUnitario) { this.valorUnitario = valorUnitario; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}
