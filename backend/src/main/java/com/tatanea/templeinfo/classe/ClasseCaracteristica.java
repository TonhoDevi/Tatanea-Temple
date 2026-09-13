package com.tatanea.templeinfo.classe;

import jakarta.persistence.*;

@Entity
@Table(name = "classe_caracteristicas")
public class ClasseCaracteristica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @Column(nullable = false, length = 160)
    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String corpo;

    // HABILIDADE = característica própria da classe, ganha num nível
    // específico — é o que a ficha usa pra trazer as habilidades corretas
    // conforme o nível do personagem. FUNDAMENTO = regra fixa que toda
    // classe tem (Pontos de Vida, Proficiências, Equipamento, Incrementos
    // de Habilidade), não "ganha" num nível, por isso nivel fica nulo.
    // CONJURACAO = regras de conjuração de magia (não é uma habilidade
    // nomeada e concedida — é a explicação do mecanismo de conjuração da
    // classe, só existe pra quem tem magia).
    @Column(nullable = false, length = 20)
    private String tipo;

    @Column
    private Integer nivel;

    @Column(nullable = false)
    private int ordem;

    protected ClasseCaracteristica() {
    }

    public ClasseCaracteristica(Classe classe, String titulo, String corpo, String tipo, Integer nivel, int ordem) {
        this.classe = classe;
        this.titulo = titulo;
        this.corpo = corpo;
        this.tipo = tipo;
        this.nivel = nivel;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getCorpo() { return corpo; }
    public void setCorpo(String corpo) { this.corpo = corpo; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public Integer getNivel() { return nivel; }
    public void setNivel(Integer nivel) { this.nivel = nivel; }
    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}
