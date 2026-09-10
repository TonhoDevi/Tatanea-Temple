package com.tatanea.templeinfo.talentoracial;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.raca.Raca;
import com.tatanea.templeinfo.raca.RacaNaoEncontradaException;
import com.tatanea.templeinfo.raca.RacaRepository;
import com.tatanea.templeinfo.talentoracial.TalentoRacialDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class TalentoRacialService {

    private final TalentoRacialRepository talentoRacialRepository;
    private final RacaRepository racaRepository;

    public TalentoRacialService(TalentoRacialRepository talentoRacialRepository, RacaRepository racaRepository) {
        this.talentoRacialRepository = talentoRacialRepository;
        this.racaRepository = racaRepository;
    }

    public List<TalentoRacialResumoDto> listarTodos() {
        return talentoRacialRepository.findAll().stream().map(TalentoRacialResumoDto::de).toList();
    }

    public TalentoRacialDetalheDto buscarPorId(Long id) {
        return TalentoRacialDetalheDto.de(buscarEntidade(id));
    }

    TalentoRacial buscarEntidade(Long id) {
        return talentoRacialRepository.findById(id).orElseThrow(() -> new TalentoRacialNaoEncontradoException(id));
    }

    @Transactional
    public TalentoRacialDetalheDto criar(TalentoRacialRequestDto request) {
        Raca raca = racaRepository.findById(request.racaId())
                .orElseThrow(() -> new RacaNaoEncontradaException(request.racaId()));

        TalentoRacial talento = new TalentoRacial(request.slug(), request.nome(), request.icone(),
                request.historia(), request.descricao(), raca, request.nivelMinimo());

        if (request.atributos() != null) {
            request.atributos().forEach(a -> {
                if (a.atributo() != null) {
                    talento.adicionarAtributoFixo(Atributo.fromCodigo(a.atributo()), a.valor(), a.ordem());
                } else {
                    talento.adicionarAtributoEscolha(a.valor(), a.quantidadeEscolhas(), a.ordem());
                }
            });
        }

        return TalentoRacialDetalheDto.de(talentoRacialRepository.save(talento));
    }

    @Transactional
    public void excluir(Long id) {
        if (!talentoRacialRepository.existsById(id)) {
            throw new TalentoRacialNaoEncontradoException(id);
        }
        talentoRacialRepository.deleteById(id);
    }
}
