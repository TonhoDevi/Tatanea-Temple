package com.tatanea.templeinfo.talento;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "talentos")
public class Talento {

    @Id
    @Column(length = 64)
    private String id; // slug, ex: "adepto-marcial"

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(length = 60)
    private String categoria;

    @Column(length = 20)
    private String icone;

    @Column(length = 255)
    private String prereq;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    @OneToMany(mappedBy = "talento", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<TalentoBeneficio> beneficios = new ArrayList<>();

    protected Talento() {
        // JPA
    }

    public Talento(String id, String nome, String categoria, String icone, String prereq, String descricao) {
        this.id = id;
        this.nome = nome;
        this.categoria = categoria;
        this.icone = icone;
        this.prereq = prereq;
        this.descricao = descricao;
    }

    public void adicionarBeneficio(String texto, int ordem) {
        this.beneficios.add(new TalentoBeneficio(this, texto, ordem));
    }

    public String getId() { return id; }
    public String getNome() { return nome; }
    public String getCategoria() { return categoria; }
    public String getIcone() { return icone; }
    public String getPrereq() { return prereq; }
    public String getDescricao() { return descricao; }
    public List<TalentoBeneficio> getBeneficios() { return beneficios; }
}
