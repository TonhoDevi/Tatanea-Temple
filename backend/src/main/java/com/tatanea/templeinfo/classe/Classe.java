package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "classes")
public class Classe {

    @Id
    @Column(length = 64)
    private String id;

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(length = 160)
    private String subtitulo;

    @Column(length = 16)
    private String icone;

    @Column(length = 16)
    private String cor;

    @Column(name = "dado_de_vida", nullable = false, length = 8)
    private String dadoDeVida;

    @Column(length = 40)
    private String dificuldade;

    @Column(name = "descricao_intro", columnDefinition = "TEXT")
    private String descricaoIntro;

    // Dump bruto e verbatim das tabelas originais (progressão + espaços de
    // magia), preservado à parte da reconstrução estruturada em ClasseNivel —
    // nenhuma informação da fonte se perde mesmo que a extração automática de
    // uma tabela específica não seja 100% confiável.
    @Column(name = "tabelas_texto_bruto", columnDefinition = "TEXT")
    private String tabelasTextoBruto;

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClassePapel> papeis = new ArrayList<>();

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("nivel ASC")
    private List<ClasseNivel> niveis = new ArrayList<>();

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClasseCaracteristica> caracteristicas = new ArrayList<>();

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClasseSubclasse> subclasses = new ArrayList<>();

    protected Classe() {
    }

    public Classe(String id, String nome, String subtitulo, String icone, String cor,
                  String dadoDeVida, String dificuldade, String descricaoIntro, String tabelasTextoBruto) {
        this.id = id;
        this.nome = nome;
        this.subtitulo = subtitulo;
        this.icone = icone;
        this.cor = cor;
        this.dadoDeVida = dadoDeVida;
        this.dificuldade = dificuldade;
        this.descricaoIntro = descricaoIntro;
        this.tabelasTextoBruto = tabelasTextoBruto;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getSubtitulo() { return subtitulo; }
    public void setSubtitulo(String subtitulo) { this.subtitulo = subtitulo; }

    public String getIcone() { return icone; }
    public void setIcone(String icone) { this.icone = icone; }

    public String getCor() { return cor; }
    public void setCor(String cor) { this.cor = cor; }

    public String getDadoDeVida() { return dadoDeVida; }
    public void setDadoDeVida(String dadoDeVida) { this.dadoDeVida = dadoDeVida; }

    public String getDificuldade() { return dificuldade; }
    public void setDificuldade(String dificuldade) { this.dificuldade = dificuldade; }

    public String getDescricaoIntro() { return descricaoIntro; }
    public void setDescricaoIntro(String descricaoIntro) { this.descricaoIntro = descricaoIntro; }

    public String getTabelasTextoBruto() { return tabelasTextoBruto; }
    public void setTabelasTextoBruto(String tabelasTextoBruto) { this.tabelasTextoBruto = tabelasTextoBruto; }

    public List<ClassePapel> getPapeis() { return papeis; }
    public List<ClasseNivel> getNiveis() { return niveis; }
    public List<ClasseCaracteristica> getCaracteristicas() { return caracteristicas; }
    public List<ClasseSubclasse> getSubclasses() { return subclasses; }
}
