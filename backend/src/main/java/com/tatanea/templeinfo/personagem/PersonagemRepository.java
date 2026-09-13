package com.tatanea.templeinfo.personagem;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PersonagemRepository extends JpaRepository<Personagem, String> {
    List<Personagem> findByUsuarioId(String usuarioId);
    long countByUsuarioId(String usuarioId);
}