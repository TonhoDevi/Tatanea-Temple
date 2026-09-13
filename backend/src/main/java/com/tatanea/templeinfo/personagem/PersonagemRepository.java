package com.tatanea.templeinfo.personagem;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PersonagemRepository extends JpaRepository<Personagem, String> {
    List<Personagem> findByUsuarioId(String usuarioId);
    long countByUsuarioId(String usuarioId);

    // JOIN FETCH nos talentos equipados (e o Talento de cada um) — sem isso,
    // cada PersonagemTalento.getTalento() dispara sua própria consulta lazy.
    // Só dá pra fazer JOIN FETCH numa lista (bag) por consulta, então os
    // outros ~13 relacionamentos da ficha continuam sendo carregados à parte;
    // esses ganham batching automático do hibernate.default_batch_fetch_size.
    @Query("SELECT DISTINCT p FROM Personagem p " +
            "LEFT JOIN FETCH p.talentos pt " +
            "LEFT JOIN FETCH pt.talento " +
            "WHERE p.id = :id")
    Optional<Personagem> findByIdComTalentos(@Param("id") String id);
}