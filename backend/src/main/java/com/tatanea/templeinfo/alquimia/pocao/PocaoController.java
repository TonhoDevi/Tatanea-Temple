package com.tatanea.templeinfo.alquimia.pocao;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/alquimia/pocoes")
public class PocaoController {

    private final PocaoRepository pocaoRepository;

    public PocaoController(PocaoRepository pocaoRepository) {
        this.pocaoRepository = pocaoRepository;
    }

    @GetMapping
    public List<PocaoDto> listar() {
        return pocaoRepository.findAll().stream().map(PocaoDto::de).toList();
    }

    @GetMapping("/{id}")
    public PocaoDto buscar(@PathVariable String id) {
        return pocaoRepository.findById(id).map(PocaoDto::de)
                .orElseThrow(() -> new PocaoNaoEncontradaException(id));
    }
}
