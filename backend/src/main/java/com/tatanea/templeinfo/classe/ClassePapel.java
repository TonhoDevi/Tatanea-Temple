package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_papeis")
public class ClassePapel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @Column(nullable = false, length = 60)
    private String papel;

    @Column(nullable = false)
    private int ordem;

    protected ClassePapel() {
    }

    public ClassePapel(Classe classe, String papel, int ordem) {
        this.classe = classe;
        this.papel = papel;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public String getPapel() { return papel; }
    public void setPapel(String papel) { this.papel = papel; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}