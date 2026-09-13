package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_niveis")
public class ClasseNivel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @Column(nullable = false)
    private int nivel;

    @Column(name = "bonus_proficiencia", length = 8)
    private String bonusProficiencia;

    @Column(columnDefinition = "TEXT")
    private String caracteristicas;

    protected ClasseNivel() {
    }

    public ClasseNivel(Classe classe, int nivel, String bonusProficiencia, String caracteristicas) {
        this.classe = classe;
        this.nivel = nivel;
        this.bonusProficiencia = bonusProficiencia;
        this.caracteristicas = caracteristicas;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public int getNivel() { return nivel; }
    public void setNivel(int nivel) { this.nivel = nivel; }
    public String getBonusProficiencia() { return bonusProficiencia; }
    public void setBonusProficiencia(String bonusProficiencia) { this.bonusProficiencia = bonusProficiencia; }
    public String getCaracteristicas() { return caracteristicas; }
    public void setCaracteristicas(String caracteristicas) { this.caracteristicas = caracteristicas; }
}
