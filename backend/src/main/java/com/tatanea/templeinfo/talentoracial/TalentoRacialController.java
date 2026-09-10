package com.tatanea.templeinfo.talentoracial;

import com.tatanea.templeinfo.talentoracial.TalentoRacialDtos.*;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/talentos-raciais")
public class TalentoRacialController {

    private final TalentoRacialService talentoRacialService;

    public TalentoRacialController(TalentoRacialService talentoRacialService) {
        this.talentoRacialService = talentoRacialService;
    }

    @GetMapping
    public List<TalentoRacialResumoDto> listar() {
        return talentoRacialService.listarTodos();
    }

    @GetMapping("/{id}")
    public TalentoRacialDetalheDto buscar(@PathVariable Long id) {
        return talentoRacialService.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<TalentoRacialDetalheDto> criar(@Valid @RequestBody TalentoRacialRequestDto request) {
        TalentoRacialDetalheDto criado = talentoRacialService.criar(request);
        return ResponseEntity.created(URI.create("/api/talentos-raciais/" + criado.id())).body(criado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        talentoRacialService.excluir(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleCodigoInvalido(IllegalArgumentException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }
}
