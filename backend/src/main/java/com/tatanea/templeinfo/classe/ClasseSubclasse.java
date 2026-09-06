package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_subclasses")
public class ClasseSubclasse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(length = 16)
    private String icone;

    @Column(length = 500)
    private String descricao;

    @Column(nullable = false)
    private int ordem;

    protected ClasseSubclasse() {
    }

    public ClasseSubclasse(Classe classe, String nome, String icone, String descricao, int ordem) {
        this.classe = classe;
        this.nome = nome;
        this.icone = icone;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getIcone() { return icone; }
    public void setIcone(String icone) { this.icone = icone; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}