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

    @Column(name = "atributo_chave", length = 60)
    private String atributoChave;

    @Column(length = 255)
    private String armadura;

    @Column(length = 500)
    private String armas;

    @Column(length = 255)
    private String ferramentas;

    @Column(length = 255)
    private String resistencias;

    @Column(length = 5000)
    private String pericias;

    @Column(length = 5000)
    private String descricao;

    @Column(length = 40)
    private String dificuldade;

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClassePapel> papeis = new ArrayList<>();

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClasseSubclasse> subclasses = new ArrayList<>();

    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<ClasseHabilidadeDestaque> habilidadesDestaque = new ArrayList<>();

    protected Classe() {
    }

    public Classe(String id, String nome, String subtitulo, String icone, String cor,
                  String dadoDeVida, String atributoChave, String armadura, String armas,
                  String ferramentas, String resistencias, String pericias,
                  String descricao, String dificuldade) {
        this.id = id;
        this.nome = nome;
        this.subtitulo = subtitulo;
        this.icone = icone;
        this.cor = cor;
        this.dadoDeVida = dadoDeVida;
        this.atributoChave = atributoChave;
        this.armadura = armadura;
        this.armas = armas;
        this.ferramentas = ferramentas;
        this.resistencias = resistencias;
        this.pericias = pericias;
        this.descricao = descricao;
        this.dificuldade = dificuldade;
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

    public String getAtributoChave() { return atributoChave; }
    public void setAtributoChave(String atributoChave) { this.atributoChave = atributoChave; }

    public String getArmadura() { return armadura; }
    public void setArmadura(String armadura) { this.armadura = armadura; }

    public String getArmas() { return armas; }
    public void setArmas(String armas) { this.armas = armas; }

    public String getFerramentas() { return ferramentas; }
    public void setFerramentas(String ferramentas) { this.ferramentas = ferramentas; }

    public String getResistencias() { return resistencias; }
    public void setResistencias(String resistencias) { this.resistencias = resistencias; }

    public String getPericias() { return pericias; }
    public void setPericias(String pericias) { this.pericias = pericias; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public String getDificuldade() { return dificuldade; }
    public void setDificuldade(String dificuldade) { this.dificuldade = dificuldade; }

    public List<ClassePapel> getPapeis() { return papeis; }
    public List<ClasseSubclasse> getSubclasses() { return subclasses; }
    public List<ClasseHabilidadeDestaque> getHabilidadesDestaque() { return habilidadesDestaque; }
}