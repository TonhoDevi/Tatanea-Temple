package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_pericias")
public class PersonagemPericia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(nullable = false, length = 60)
    private String pericia;

    private boolean proficiente;
    private boolean expertise;

    protected PersonagemPericia() {
    }

    public PersonagemPericia(Personagem personagem, String pericia, boolean proficiente, boolean expertise) {
        this.personagem = personagem;
        this.pericia = pericia;
        this.proficiente = proficiente;
        this.expertise = expertise;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getPericia() { return pericia; }
    public void setPericia(String pericia) { this.pericia = pericia; }
    public boolean isProficiente() { return proficiente; }
    public void setProficiente(boolean proficiente) { this.proficiente = proficiente; }
    public boolean isExpertise() { return expertise; }
    public void setExpertise(boolean expertise) { this.expertise = expertise; }
}