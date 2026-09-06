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

    private int ordem;

    protected PersonagemMagia() {
    }

    public PersonagemMagia(Personagem personagem, int nivel, String nome, boolean preparada, int ordem) {
        this.personagem = personagem;
        this.nivel = nivel;
        this.nome = nome;
        this.preparada = preparada;
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
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}