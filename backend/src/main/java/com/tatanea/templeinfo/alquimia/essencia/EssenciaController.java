package com.tatanea.templeinfo.alquimia.essencia;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/alquimia/essencias")
public class EssenciaController {

    private final EssenciaRepository essenciaRepository;

    public EssenciaController(EssenciaRepository essenciaRepository) {
        this.essenciaRepository = essenciaRepository;
    }

    @GetMapping
    public List<EssenciaDto> listar() {
        return essenciaRepository.findAll().stream().map(EssenciaDto::de).toList();
    }
}
