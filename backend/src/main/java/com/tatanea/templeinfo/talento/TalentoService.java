package com.tatanea.templeinfo.talento;

import com.tatanea.templeinfo.comum.Atributo;
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

        if (request.atributos() != null) {
            request.atributos().forEach(a -> {
                if (a.atributo() != null) {
                    talento.adicionarAtributoFixo(Atributo.fromCodigo(a.atributo()), a.valor(), a.ordem());
                } else {
                    talento.adicionarAtributoEscolha(a.valor(), a.quantidadeEscolhas(), a.ordem());
                }
            });
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
