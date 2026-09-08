package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.talento.TalentoDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class TalentoService {

    private final TalentoRepository talentoRepository;

    public TalentoService(TalentoRepository talentoRepository) {
        this.talentoRepository = talentoRepository;
    }

    public List<TalentoResumoDto> listarTodos() {
        return talentoRepository.findAll().stream().map(TalentoResumoDto::de).toList();
    }

    public TalentoDetalheDto buscarPorId(String id) {
        Talento talento = talentoRepository.findById(id)
                .orElseThrow(() -> new TalentoNaoEncontradoException(id));
        return TalentoDetalheDto.de(talento);
    }

    @Transactional
    public TalentoDetalheDto criar(TalentoRequestDto request) {
        Talento talento = new Talento(request.id(), request.nome(), request.categoria(),
                request.icone(), request.prereq(), request.descricao());

        if (request.beneficios() != null) {
            request.beneficios().forEach(b -> talento.adicionarBeneficio(b.texto(), b.ordem()));
        }

        return TalentoDetalheDto.de(talentoRepository.save(talento));
    }

    @Transactional
    public void excluir(String id) {
        if (!talentoRepository.existsById(id)) {
            throw new TalentoNaoEncontradoException(id);
        }
        talentoRepository.deleteById(id);
    }
}
