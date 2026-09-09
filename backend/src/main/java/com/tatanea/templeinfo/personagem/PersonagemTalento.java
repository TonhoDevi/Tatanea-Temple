package com.tatanea.templeinfo.personagem;

import com.tatanea.templeinfo.talento.Talento;
import jakarta.persistence.*;

@Entity
@Table(name = "personagem_talentos")
public class PersonagemTalento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "talento_id", nullable = false)
    private Talento talento;

    @Column(nullable = false)
    private int ordem;

    protected PersonagemTalento() {
        // JPA
    }

    public PersonagemTalento(Personagem personagem, Talento talento, int ordem) {
        this.personagem = personagem;
        this.talento = talento;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Talento getTalento() { return talento; }
    public int getOrdem() { return ordem; }
}
