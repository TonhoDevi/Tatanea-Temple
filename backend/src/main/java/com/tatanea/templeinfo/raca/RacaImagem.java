// ===== RacaImagem.java =====
package com.tatanea.templeinfo.raca;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "raca_imagem")
public class RacaImagem {

    @Id
    @Column(name = "raca_id")
    private Long racaId;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "raca_id")
    private Raca raca;

    @Column(nullable = false)
    private byte[] conteudo;

    @Column(name = "content_type", nullable = false, length = 50)
    private String contentType;

    @Column(name = "tamanho_bytes", nullable = false)
    private int tamanhoBytes;

    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    protected RacaImagem() {
        // JPA
    }

    public RacaImagem(Raca raca, byte[] conteudo, String contentType) {
        this.raca = raca;
        this.conteudo = conteudo;
        this.contentType = contentType;
        this.tamanhoBytes = conteudo.length;
        this.atualizadoEm = LocalDateTime.now();
    }

    public byte[] getConteudo() { return conteudo; }
    public String getContentType() { return contentType; }
    public int getTamanhoBytes() { return tamanhoBytes; }
    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }
}