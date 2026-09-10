package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_magias")
public class PersonagemMagia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    private int nivel;

    @Column(nullable = false, length = 160)
    private String nome;

    private boolean preparada;

    @Column(name = "tempo_conjuracao", length = 120)
    private String tempoConjuracao;

    @Column(length = 2000)
    private String descricao;

    private int ordem;

    protected PersonagemMagia() {
    }

    public PersonagemMagia(Personagem personagem, int nivel, String nome, boolean preparada, String tempoConjuracao, String descricao, int ordem) {
        this.personagem = personagem;
        this.nivel = nivel;
        this.nome = nome;
        this.preparada = preparada;
        this.tempoConjuracao = tempoConjuracao;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public int getNivel() { return nivel; }
    public void setNivel(int nivel) { this.nivel = nivel; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public boolean isPreparada() { return preparada; }
    public void setPreparada(boolean preparada) { this.preparada = preparada; }
    public String getTempoConjuracao() { return tempoConjuracao; }
    public void setTempoConjuracao(String tempoConjuracao) { this.tempoConjuracao = tempoConjuracao; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}