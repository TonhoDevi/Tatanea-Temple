package com.tatanea.templeinfo.raca;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RacaRepository extends JpaRepository<Raca, Long> {

    // JOIN FETCH pra evitar N+1: sem isso, cada raça dispara uma consulta
    // separada só pra contar habilidadesEspeciais (lazy), o que em produção
    // (backend e banco em regiões diferentes) multiplica a latência de rede
    // por raça.
    @Query("SELECT DISTINCT r FROM Raca r LEFT JOIN FETCH r.habilidadesEspeciais")
    List<Raca> findAllComHabilidades();

    @Query(value = "SELECT raca_id FROM raca_imagem", nativeQuery = true)
    List<Long> buscarIdsComImagem();
}
