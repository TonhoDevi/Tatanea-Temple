package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_slots_magia")
public class PersonagemSlotMagia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    private int nivel;

    private int total;

    private int restantes;

    protected PersonagemSlotMagia() {
    }

    public PersonagemSlotMagia(Personagem personagem, int nivel, int total, int restantes) {
        this.personagem = personagem;
        this.nivel = nivel;
        this.total = total;
        this.restantes = restantes;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public int getNivel() { return nivel; }
    public void setNivel(int nivel) { this.nivel = nivel; }
    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
    public int getRestantes() { return restantes; }
    public void setRestantes(int restantes) { this.restantes = restantes; }
}
