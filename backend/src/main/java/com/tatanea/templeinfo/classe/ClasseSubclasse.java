package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

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

    @Column(name = "intro_texto", columnDefinition = "TEXT")
    private String introTexto;

    @Column(name = "magias_texto", columnDefinition = "TEXT")
    private String magiasTexto;

    @Column(nullable = false)
    private int ordem;

    @OneToMany(mappedBy = "subclasse", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClasseSubclasseCaracteristica> caracteristicas = new ArrayList<>();

    protected ClasseSubclasse() {
    }

    public ClasseSubclasse(Classe classe, String nome, String icone, String introTexto, String magiasTexto, int ordem) {
        this.classe = classe;
        this.nome = nome;
        this.icone = icone;
        this.introTexto = introTexto;
        this.magiasTexto = magiasTexto;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getIcone() { return icone; }
    public void setIcone(String icone) { this.icone = icone; }
    public String getIntroTexto() { return introTexto; }
    public void setIntroTexto(String introTexto) { this.introTexto = introTexto; }
    public String getMagiasTexto() { return magiasTexto; }
    public void setMagiasTexto(String magiasTexto) { this.magiasTexto = magiasTexto; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
    public List<ClasseSubclasseCaracteristica> getCaracteristicas() { return caracteristicas; }
}
