package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_ataques")
public class PersonagemAtaque {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(name = "bonus_ataque", length = 20)
    private String bonusAtaque;

    @Column(length = 60)
    private String dano;

    @Column(name = "tipo_dano", length = 60)
    private String tipoDano;

    private int ordem;

    protected PersonagemAtaque() {
    }

    public PersonagemAtaque(Personagem personagem, String nome, String bonusAtaque, String dano, String tipoDano, int ordem) {
        this.personagem = personagem;
        this.nome = nome;
        this.bonusAtaque = bonusAtaque;
        this.dano = dano;
        this.tipoDano = tipoDano;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getBonusAtaque() { return bonusAtaque; }
    public void setBonusAtaque(String bonusAtaque) { this.bonusAtaque = bonusAtaque; }
    public String getDano() { return dano; }
    public void setDano(String dano) { this.dano = dano; }
    public String getTipoDano() { return tipoDano; }
    public void setTipoDano(String tipoDano) { this.tipoDano = tipoDano; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}