package com.tatanea.templeinfo.raca;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface RacaImagemRepository extends JpaRepository<RacaImagem, Long> {

    // Projeção só do id — evita carregar o byte[] da imagem inteira quando
    // só precisamos saber quais raças têm imagem (ex.: listagem do compêndio).
    @Query("SELECT ri.racaId FROM RacaImagem ri WHERE ri.racaId IN :racaIds")
    List<Long> encontrarIdsComImagem(List<Long> racaIds);

    // Metadados sem o byte[] — usado pra checar o ETag (cache HTTP) sem puxar
    // a imagem inteira do banco quando o navegador já tem a versão atual.
    @Query("SELECT ri.contentType AS contentType, ri.atualizadoEm AS atualizadoEm "
            + "FROM RacaImagem ri WHERE ri.racaId = :racaId")
    Optional<Metadata> encontrarMetadata(Long racaId);

    interface Metadata {
        String getContentType();
        LocalDateTime getAtualizadoEm();
    }
}
