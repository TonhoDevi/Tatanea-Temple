package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_subclasse_caracteristicas")
public class ClasseSubclasseCaracteristica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subclasse_id", nullable = false)
    private ClasseSubclasse subclasse;

    @Column(nullable = false, length = 160)
    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String corpo;

    // Nível em que a subclasse concede essa característica — usado pela
    // ficha pra trazer as habilidades corretas quando o nível do personagem
    // muda. Sempre é uma HABILIDADE (subclasse não tem "fundamento" próprio).
    @Column
    private Integer nivel;

    @Column(nullable = false)
    private int ordem;

    protected ClasseSubclasseCaracteristica() {
    }

    public ClasseSubclasseCaracteristica(ClasseSubclasse subclasse, String titulo, String corpo, Integer nivel, int ordem) {
        this.subclasse = subclasse;
        this.titulo = titulo;
        this.corpo = corpo;
        this.nivel = nivel;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public ClasseSubclasse getSubclasse() { return subclasse; }
    public void setSubclasse(ClasseSubclasse subclasse) { this.subclasse = subclasse; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getCorpo() { return corpo; }
    public void setCorpo(String corpo) { this.corpo = corpo; }
    public Integer getNivel() { return nivel; }
    public void setNivel(Integer nivel) { this.nivel = nivel; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}
