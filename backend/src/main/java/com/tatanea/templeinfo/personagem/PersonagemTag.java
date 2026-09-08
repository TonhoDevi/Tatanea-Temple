package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_tags")
public class PersonagemTag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(nullable = false, length = 20)
    private String tipo; // "resistencia" ou "vulnerabilidade"

    @Column(nullable = false, length = 120)
    private String texto;

    private int ordem;

    protected PersonagemTag() {
    }

    public PersonagemTag(Personagem personagem, String tipo, String texto, int ordem) {
        this.personagem = personagem;
        this.tipo = tipo;
        this.texto = texto;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getTexto() { return texto; }
    public void setTexto(String texto) { this.texto = texto; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}