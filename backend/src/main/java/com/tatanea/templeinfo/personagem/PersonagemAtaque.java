package com.tatanea.templeinfo.personagem;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

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

    @Column(name = "bonus_atributo", length = 20)
    private String bonusAtributo;

    @Column(name = "bonus_proficiente", nullable = false)
    private boolean bonusProficiente;

    @Column(name = "bonus_extra", nullable = false)
    private int bonusExtra;

    // Um ataque pode ter mais de um dano (ex: espada flamejante = cortante + fogo).
    @ElementCollection
    @CollectionTable(name = "personagem_ataque_danos", joinColumns = @JoinColumn(name = "ataque_id"))
    @OrderColumn(name = "ordem")
    private List<AtaqueDano> danos = new ArrayList<>();

    @Column(length = 1000)
    private String descricao;

    private int ordem;

    protected PersonagemAtaque() {
    }

    public PersonagemAtaque(
            Personagem personagem, String nome, String bonusAtributo, boolean bonusProficiente, int bonusExtra,
            List<AtaqueDano> danos, String descricao, int ordem
    ) {
        this.personagem = personagem;
        this.nome = nome;
        this.bonusAtributo = bonusAtributo;
        this.bonusProficiente = bonusProficiente;
        this.bonusExtra = bonusExtra;
        this.danos = danos;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Personagem getPersonagem() { return personagem; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getBonusAtributo() { return bonusAtributo; }
    public void setBonusAtributo(String bonusAtributo) { this.bonusAtributo = bonusAtributo; }
    public boolean isBonusProficiente() { return bonusProficiente; }
    public void setBonusProficiente(boolean bonusProficiente) { this.bonusProficiente = bonusProficiente; }
    public int getBonusExtra() { return bonusExtra; }
    public void setBonusExtra(int bonusExtra) { this.bonusExtra = bonusExtra; }
    public List<AtaqueDano> getDanos() { return danos; }
    public void setDanos(List<AtaqueDano> danos) { this.danos = danos; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}
