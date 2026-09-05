package com.ddt.cosmossombrio.raca;

import com.ddt.cosmossombrio.raca.RacaDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class RacaService {

    private final RacaRepository racaRepository;

    public RacaService(RacaRepository racaRepository) {
        this.racaRepository = racaRepository;
    }

    public List<RacaResumoDto> listarTodas() {
        return racaRepository.findAll().stream().map(RacaResumoDto::de).toList();
    }

    public RacaDetalheDto buscarPorId(String id) {
        Raca raca = racaRepository.findById(id).orElseThrow(() -> new RacaNaoEncontradaException(id));
        return RacaDetalheDto.de(raca);
    }

    @Transactional
    public RacaDetalheDto criar(RacaRequestDto request) {
        Raca raca = new Raca(request.id(), request.nome(), request.categoria(),
                request.tamanho(), request.deslocamento(), request.descricao());
        raca.setImagemUrl(request.imagemUrl());

        if (request.tracos() != null) {
            request.tracos().forEach(t -> raca.adicionarTraco(t.texto(), t.ordem()));
        }
        if (request.habilidades() != null) {
            request.habilidades().forEach(h -> raca.adicionarHabilidade(h.nome(), h.descricao(), h.ordem()));
        }

        return RacaDetalheDto.de(racaRepository.save(raca));
    }

    @Transactional
    public void excluir(String id) {
        if (!racaRepository.existsById(id)) {
            throw new RacaNaoEncontradaException(id);
        }
        racaRepository.deleteById(id);
    }
}
