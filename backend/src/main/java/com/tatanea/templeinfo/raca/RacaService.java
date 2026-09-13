package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.comum.Atributo;
import com.tatanea.templeinfo.comum.TipoHabilidade;
import com.tatanea.templeinfo.raca.RacaDtos.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class RacaService {

    private final RacaRepository racaRepository;
    private final RacaImagemRepository racaImagemRepository;

    public RacaService(RacaRepository racaRepository, RacaImagemRepository racaImagemRepository) {
        this.racaRepository = racaRepository;
        this.racaImagemRepository = racaImagemRepository;
    }

    public List<RacaResumoDto> listarTodas() {
        List<Raca> racas = racaRepository.findAll();

        // Consulta separada só com os ids de raça que têm imagem, em vez de
        // carregar o byte[] de cada imagem (raca.getImagem()) durante a listagem.
        List<Long> ids = racas.stream().map(Raca::getId).toList();
        Set<Long> idsComImagem = new HashSet<>(racaImagemRepository.encontrarIdsComImagem(ids));

        return racas.stream().map(r -> RacaResumoDto.de(r, idsComImagem.contains(r.getId()))).toList();
    }

    public RacaDetalheDto buscarPorId(Long id) {
        return RacaDetalheDto.de(buscarEntidade(id));
    }

    public RacaImagem buscarImagem(Long id) {
        Raca raca = buscarEntidade(id);
        if (raca.getImagem() == null) {
            throw new RacaNaoEncontradaException(id);
        }
        return raca.getImagem();
    }

    private Raca buscarEntidade(Long id) {
        return racaRepository.findById(id).orElseThrow(() -> new RacaNaoEncontradaException(id));
    }

    @Transactional
    public RacaDetalheDto criar(RacaRequestDto request) {
        Raca raca = new Raca(request.slug(), request.nome(), CategoriaRaca.fromCodigo(request.categoria()),
                request.deslocamento(), TamanhoRaca.fromCodigo(request.tamanho()));
        raca.setQuote(request.quote());
        raca.setIdiomas(request.idiomas());
        raca.setAnatomia(request.anatomia());
        raca.setAparencia(request.aparencia());
        raca.setNomesRaciais(request.nomesRaciais());
        raca.setTracosCulturais(request.tracosCulturais());

        if (request.atributos() != null) {
            request.atributos().forEach(a -> {
                if (a.atributo() != null) {
                    raca.adicionarAtributoFixo(Atributo.fromCodigo(a.atributo()), a.valor(), a.ordem());
                } else {
                    raca.adicionarAtributoEscolha(a.valor(), a.quantidadeEscolhas(), a.ordem());
                }
            });
        }
        if (request.habilidadesEspeciais() != null) {
            request.habilidadesEspeciais().forEach(h -> raca.adicionarHabilidadeEspecial(
                    h.nome(), h.descricao(), TipoHabilidade.fromCodigo(h.tipo()), h.ordem()));
        }
        if (request.altura() != null) {
            raca.definirAltura(request.altura().valorMenor(), request.altura().valorMedio(), request.altura().valorMaior());
        }
        if (request.peso() != null) {
            raca.definirPeso(request.peso().valorMenor(), request.peso().valorMedio(), request.peso().valorMaior());
        }
        if (request.idade() != null) {
            raca.definirIdade(request.idade().idadeAdulta(), request.idade().expectativaVida());
        }

        return RacaDetalheDto.de(racaRepository.save(raca));
    }

    @Transactional
    public void excluir(Long id) {
        if (!racaRepository.existsById(id)) {
            throw new RacaNaoEncontradaException(id);
        }
        racaRepository.deleteById(id);
    }
}
