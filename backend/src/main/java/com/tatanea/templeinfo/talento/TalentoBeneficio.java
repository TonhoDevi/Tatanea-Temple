package com.tatanea.templeinfo.talento;

import jakarta.persistence.*;

@Entity
@Table(name = "talento_beneficios")
public class TalentoBeneficio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "talento_id", nullable = false)
    private Talento talento;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String texto;

    @Column(nullable = false)
    private int ordem;

    protected TalentoBeneficio() {
        // JPA
    }

    public TalentoBeneficio(Talento talento, String texto, int ordem) {
        this.talento = talento;
        this.texto = texto;
        this.ordem = ordem;
    }

    public Long getId() { return id; }
    public String getTexto() { return texto; }
    public int getOrdem() { return ordem; }
}
