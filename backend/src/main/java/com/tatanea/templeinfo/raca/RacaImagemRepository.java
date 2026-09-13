package com.tatanea.templeinfo.raca;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RacaImagemRepository extends JpaRepository<RacaImagem, Long> {

    // Projeção só do id — evita carregar o byte[] da imagem inteira quando
    // só precisamos saber quais raças têm imagem (ex.: listagem do compêndio).
    @Query("SELECT ri.racaId FROM RacaImagem ri WHERE ri.racaId IN :racaIds")
    List<Long> encontrarIdsComImagem(List<Long> racaIds);
}
