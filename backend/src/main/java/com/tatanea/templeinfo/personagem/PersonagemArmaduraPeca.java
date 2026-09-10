package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_armadura_pecas")
public class PersonagemArmaduraPeca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(length = 120)
    private String nome;

    private int bonus;

    private int ordem;

    protected PersonagemArmaduraPeca() {
    }

    public PersonagemArmaduraPeca(Personagem personagem, String nome, int bonus, int ordem) {
        this.personagem = personagem;
        this.nome = nome;
        this.bonus = bonus;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getBonus() { return bonus; }
    public void setBonus(int bonus) { this.bonus = bonus; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}
