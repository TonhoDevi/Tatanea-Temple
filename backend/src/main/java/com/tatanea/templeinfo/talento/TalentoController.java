package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.talento.TalentoDtos.*;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/talentos")
public class TalentoController {

    private final TalentoService talentoService;

    public TalentoController(TalentoService talentoService) {
        this.talentoService = talentoService;
    }

    @GetMapping
    public List<TalentoResumoDto> listar() {
        return talentoService.listarTodos();
    }

    @GetMapping("/{id}")
    public TalentoDetalheDto buscar(@PathVariable Long id) {
        return talentoService.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<TalentoDetalheDto> criar(@Valid @RequestBody TalentoRequestDto request) {
        TalentoDetalheDto criado = talentoService.criar(request);
        return ResponseEntity.created(URI.create("/api/talentos/" + criado.id())).body(criado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        talentoService.excluir(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleCodigoInvalido(IllegalArgumentException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }
}
