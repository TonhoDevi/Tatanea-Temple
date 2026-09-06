package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

@Entity
@Table(name = "personagem_unidades")
public class PersonagemUnidade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "personagem_id", nullable = false)
    private Personagem personagem;

    @Column(nullable = false, length = 160)
    private String nome;

    @Column(length = 80)
    private String tipo;

    @Column(name = "dados_extra_json", length = 5000)
    private String dadosExtraJson;

    private int ordem;

    protected PersonagemUnidade() {
    }

    public PersonagemUnidade(Personagem personagem, String nome, String tipo, String dadosExtraJson, int ordem) {
        this.personagem = personagem;
        this.nome = nome;
        this.tipo = tipo;
        this.dadosExtraJson = dadosExtraJson;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getDadosExtraJson() { return dadosExtraJson; }
    public void setDadosExtraJson(String dadosExtraJson) { this.dadosExtraJson = dadosExtraJson; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}