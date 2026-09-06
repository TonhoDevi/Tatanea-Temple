package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_habilidades_destaque")
public class ClasseHabilidadeDestaque {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @Column(nullable = false, length = 160)
    private String nome;

    @Column(nullable = false)
    private int ordem;

    protected ClasseHabilidadeDestaque() {
    }

    public ClasseHabilidadeDestaque(Classe classe, String nome, int ordem) {
        this.classe = classe;
        this.nome = nome;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}