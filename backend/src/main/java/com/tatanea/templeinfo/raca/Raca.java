package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "racas")
public class Raca {

    @Id
    @Column(length = 64)
    private String id; // slug, ex: "anao-rochoso"

    @Column(nullable = false, length = 120)
    private String nome;

    @Column(length = 60)
    private String categoria;

    @Column(length = 60)
    private String tamanho;

    @Column(length = 60)
    private String deslocamento;

    @Column(name = "imagem_url")
    private String imagemUrl;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    @OneToMany(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<RacaTraco> tracos = new ArrayList<>();

    @OneToMany(mappedBy = "raca", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("ordem ASC")
    private List<RacaHabilidade> habilidades = new ArrayList<>();

    protected Raca() {
        // JPA
    }

    public Raca(String id, String nome, String categoria, String tamanho, String deslocamento, String descricao) {
        this.id = id;
        this.nome = nome;
        this.categoria = categoria;
        this.tamanho = tamanho;
        this.deslocamento = deslocamento;
        this.descricao = descricao;
    }

    public void adicionarTraco(String texto, int ordem) {
        RacaTraco traco = new RacaTraco(this, texto, ordem);
        this.tracos.add(traco);
    }

    public void adicionarHabilidade(String nome, String descricao, int ordem) {
        RacaHabilidade habilidade = new RacaHabilidade(this, nome, descricao, ordem);
        this.habilidades.add(habilidade);
    }

    public String getId() { return id; }
    public String getNome() { return nome; }
    public String getCategoria() { return categoria; }
    public String getTamanho() { return tamanho; }
    public String getDeslocamento() { return deslocamento; }
    public String getImagemUrl() { return imagemUrl; }
    public String getDescricao() { return descricao; }
    public List<RacaTraco> getTracos() { return tracos; }
    public List<RacaHabilidade> getHabilidades() { return habilidades; }

    public void setNome(String nome) { this.nome = nome; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
    public void setTamanho(String tamanho) { this.tamanho = tamanho; }
    public void setDeslocamento(String deslocamento) { this.deslocamento = deslocamento; }
    public void setImagemUrl(String imagemUrl) { this.imagemUrl = imagemUrl; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
}
