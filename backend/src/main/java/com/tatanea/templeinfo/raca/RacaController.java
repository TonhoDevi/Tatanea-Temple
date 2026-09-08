package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.raca.RacaDtos.*;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/racas")
public class RacaController {

    private final RacaService racaService;

    public RacaController(RacaService racaService) {
        this.racaService = racaService;
    }

    @GetMapping
    public List<RacaResumoDto> listar() {
        return racaService.listarTodas();
    }

    @GetMapping("/{id}")
    public RacaDetalheDto buscar(@PathVariable String id) {
        return racaService.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<RacaDetalheDto> criar(@Valid @RequestBody RacaRequestDto request) {
        RacaDetalheDto criada = racaService.criar(request);
        return ResponseEntity.created(URI.create("/api/racas/" + criada.id())).body(criada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable String id) {
        racaService.excluir(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
