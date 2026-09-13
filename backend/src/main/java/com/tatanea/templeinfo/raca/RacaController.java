package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.raca.RacaDtos.*;
import jakarta.validation.Valid;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import java.net.URI;
import java.time.ZoneOffset;
import java.util.List;
import java.util.concurrent.TimeUnit;

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
    public RacaDetalheDto buscar(@PathVariable Long id) {
        return racaService.buscarPorId(id);
    }

    @GetMapping("/{id}/imagem")
    public ResponseEntity<byte[]> buscarImagem(@PathVariable Long id, WebRequest request) {
        // Checa o ETag antes de tocar no byte[] — evita puxar a imagem inteira
        // do banco (Render -> Supabase) quando o navegador já tem a versão
        // atual em cache. Isso importa porque o compêndio renderiza dezenas
        // de <img> de uma vez, cada uma batendo nesse endpoint sozinha.
        RacaImagemRepository.Metadata metadata = racaService.buscarMetadataImagem(id);
        String eTag = "\"" + id + "-" + metadata.getAtualizadoEm().toEpochSecond(ZoneOffset.UTC) + "\"";

        if (request.checkNotModified(eTag)) {
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
        }

        RacaImagem imagem = racaService.buscarImagem(id);
        return ResponseEntity.ok()
                .cacheControl(CacheControl.maxAge(1, TimeUnit.DAYS).cachePublic())
                .eTag(eTag)
                .contentType(MediaType.parseMediaType(imagem.getContentType()))
                .body(imagem.getConteudo());
    }

    @PostMapping
    public ResponseEntity<RacaDetalheDto> criar(@Valid @RequestBody RacaRequestDto request) {
        RacaDetalheDto criada = racaService.criar(request);
        return ResponseEntity.created(URI.create("/api/racas/" + criada.id())).body(criada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        racaService.excluir(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleCodigoInvalido(IllegalArgumentException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }
}
