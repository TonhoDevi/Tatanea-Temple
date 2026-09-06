package com.tatanea.templeinfo.classe;

import com.tatanea.templeinfo.classe.ClasseDtos.ClasseDetalheDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseRequestDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseResumoDto;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/classes")
public class ClasseController {

    private final ClasseService service;

    public ClasseController(ClasseService service) {
        this.service = service;
    }

    @GetMapping
    public List<ClasseResumoDto> listar() {
        return service.listarTodas();
    }

    @GetMapping("/{id}")
    public ClasseDetalheDto buscar(@PathVariable String id) {
        return service.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<ClasseDetalheDto> criar(@Valid @RequestBody ClasseRequestDto dto) {
        ClasseDetalheDto criada = service.criar(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(criada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> remover(@PathVariable String id) {
        service.remover(id);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(ClasseNaoEncontradaException.class)
    public ResponseEntity<String> handleNaoEncontrada(ClasseNaoEncontradaException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidacao(MethodArgumentNotValidException ex) {
        Map<String, String> erros = ex.getBindingResult().getFieldErrors().stream()
                .collect(Collectors.toMap(
                        erro -> erro.getField(),
                        erro -> erro.getDefaultMessage(),
                        (a, b) -> a
                ));
        return ResponseEntity.badRequest().body(erros);
    }
}