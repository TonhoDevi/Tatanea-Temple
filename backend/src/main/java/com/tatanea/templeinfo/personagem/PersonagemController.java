package com.tatanea.templeinfo.personagem;

import com.tatanea.templeinfo.personagem.PersonagemDtos.PersonagemDetalheDto;
import com.tatanea.templeinfo.personagem.PersonagemDtos.PersonagemRequestDto;
import com.tatanea.templeinfo.personagem.PersonagemDtos.PersonagemResumoDto;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/personagens")
public class PersonagemController {

    private final PersonagemService service;

    public PersonagemController(PersonagemService service) {
        this.service = service;
    }

    @GetMapping
    public List<PersonagemResumoDto> listar(Authentication auth) {
        return service.listarDoUsuario(usuarioId(auth));
    }

    @GetMapping("/{id}")
    public PersonagemDetalheDto buscar(@PathVariable String id, Authentication auth) {
        return service.buscar(id, usuarioId(auth));
    }

    @PostMapping
    public ResponseEntity<PersonagemDetalheDto> criar(@Valid @RequestBody PersonagemRequestDto dto, Authentication auth) {
        PersonagemDetalheDto criado = service.criar(usuarioId(auth), dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(criado);
    }

    @PutMapping("/{id}")
    public PersonagemDetalheDto atualizar(@PathVariable String id, @Valid @RequestBody PersonagemRequestDto dto, Authentication auth) {
        return service.atualizar(id, usuarioId(auth), dto);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> remover(@PathVariable String id, Authentication auth) {
        service.remover(id, usuarioId(auth));
        return ResponseEntity.noContent().build();
    }

    private String usuarioId(Authentication auth) {
        return (String) auth.getPrincipal();
    }

    @ExceptionHandler(PersonagemNaoEncontradoException.class)
    public ResponseEntity<String> handleNaoEncontrado(PersonagemNaoEncontradoException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
    }

    @ExceptionHandler(AcessoNegadoException.class)
    public ResponseEntity<String> handleAcessoNegado(AcessoNegadoException ex) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
    }

    // Dispara quando algum campo fura os limites do @Size/@NotBlank (ex: história com
    // mais de 5000 caracteres). Sem isso, o Spring devolveria um 400 genérico sem
    // dizer qual campo é o problema.
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