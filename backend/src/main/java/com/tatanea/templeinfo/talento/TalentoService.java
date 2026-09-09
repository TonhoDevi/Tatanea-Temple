package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.raca.Raca;
import com.tatanea.templeinfo.raca.RacaNaoEncontradaException;
import com.tatanea.templeinfo.raca.RacaRepository;
import com.tatanea.templeinfo.talento.TalentoDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class TalentoService {

    private final TalentoRepository talentoRepository;
    private final RacaRepository racaRepository;

    public TalentoService(TalentoRepository talentoRepository, RacaRepository racaRepository) {
        this.talentoRepository = talentoRepository;
        this.racaRepository = racaRepository;
    }

    public List<TalentoResumoDto> listarTodos() {
        return talentoRepository.findAll().stream().map(TalentoResumoDto::de).toList();
    }

    public TalentoDetalheDto buscarPorId(Long id) {
        return TalentoDetalheDto.de(buscarEntidade(id));
    }

    Talento buscarEntidade(Long id) {
        return talentoRepository.findById(id).orElseThrow(() -> new TalentoNaoEncontradoException(id));
    }

    @Transactional
    public TalentoDetalheDto criar(TalentoRequestDto request) {
        Talento talento = new Talento(request.slug(), request.nome(), request.icone(),
                request.historia(), request.descricao());

        if (request.atributoRecebido() != null) {
            talento.definirAtributoRecebido(
                    Atributo.fromCodigo(request.atributoRecebido()), request.valorAtributoRecebido());
        }
        if (request.racaRequeridaId() != null) {
            Raca raca = racaRepository.findById(request.racaRequeridaId())
                    .orElseThrow(() -> new RacaNaoEncontradaException(request.racaRequeridaId()));
            talento.definirPreRequisitoRaca(raca);
        }
        if (request.atributoRequerido() != null) {
            talento.definirPreRequisitoAtributo(
                    Atributo.fromCodigo(request.atributoRequerido()), request.valorMinimoAtributoRequerido());
        }

        return TalentoDetalheDto.de(talentoRepository.save(talento));
    }

    @Transactional
    public void excluir(Long id) {
        if (!talentoRepository.existsById(id)) {
            throw new TalentoNaoEncontradoException(id);
        }
        talentoRepository.deleteById(id);
    }
}
