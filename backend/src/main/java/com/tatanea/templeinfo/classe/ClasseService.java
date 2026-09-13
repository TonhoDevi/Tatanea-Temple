package com.tatanea.templeinfo.classe;

import com.tatanea.templeinfo.classe.ClasseDtos.CaracteristicaDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseDetalheDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseRequestDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseResumoDto;
import com.tatanea.templeinfo.classe.ClasseDtos.NivelDto;
import com.tatanea.templeinfo.classe.ClasseDtos.SubclasseCaracteristicaDto;
import com.tatanea.templeinfo.classe.ClasseDtos.SubclasseDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ClasseService {

    private final ClasseRepository repository;

    public ClasseService(ClasseRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<ClasseResumoDto> listarTodas() {
        return repository.findAll().stream()
                .map(this::paraResumo)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public ClasseDetalheDto buscarPorId(String id) {
        Classe classe = repository.findById(id)
                .orElseThrow(() -> new ClasseNaoEncontradaException(id));
        return paraDetalhe(classe);
    }

    public ClasseDetalheDto criar(ClasseRequestDto dto) {
        Classe classe = new Classe(
                dto.id(), dto.nome(), dto.subtitulo(), dto.icone(), dto.cor(),
                dto.dadoDeVida(), dto.dificuldade(), dto.descricaoIntro(), dto.tabelasTextoBruto()
        );
        aplicarListas(classe, dto);
        return paraDetalhe(repository.save(classe));
    }

    public void remover(String id) {
        if (!repository.existsById(id)) {
            throw new ClasseNaoEncontradaException(id);
        }
        repository.deleteById(id);
    }

    private void aplicarListas(Classe classe, ClasseRequestDto dto) {
        List<ClassePapel> papeis = new ArrayList<>();
        if (dto.papeis() != null) {
            for (int i = 0; i < dto.papeis().size(); i++) {
                papeis.add(new ClassePapel(classe, dto.papeis().get(i), i));
            }
        }
        classe.getPapeis().clear();
        classe.getPapeis().addAll(papeis);

        List<ClasseNivel> niveis = new ArrayList<>();
        if (dto.niveis() != null) {
            for (NivelDto n : dto.niveis()) {
                niveis.add(new ClasseNivel(classe, n.nivel(), n.bonusProficiencia(), n.caracteristicas()));
            }
        }
        classe.getNiveis().clear();
        classe.getNiveis().addAll(niveis);

        List<ClasseCaracteristica> caracteristicas = new ArrayList<>();
        if (dto.caracteristicas() != null) {
            for (int i = 0; i < dto.caracteristicas().size(); i++) {
                CaracteristicaDto c = dto.caracteristicas().get(i);
                caracteristicas.add(new ClasseCaracteristica(classe, c.titulo(), c.corpo(), c.tipo(), c.nivel(), i));
            }
        }
        classe.getCaracteristicas().clear();
        classe.getCaracteristicas().addAll(caracteristicas);

        List<ClasseSubclasse> subclasses = new ArrayList<>();
        if (dto.subclasses() != null) {
            for (int i = 0; i < dto.subclasses().size(); i++) {
                SubclasseDto s = dto.subclasses().get(i);
                ClasseSubclasse subclasse = new ClasseSubclasse(classe, s.nome(), s.icone(), s.introTexto(), s.magiasTexto(), i);
                if (s.caracteristicas() != null) {
                    for (int j = 0; j < s.caracteristicas().size(); j++) {
                        SubclasseCaracteristicaDto c = s.caracteristicas().get(j);
                        subclasse.getCaracteristicas().add(new ClasseSubclasseCaracteristica(subclasse, c.titulo(), c.corpo(), c.nivel(), j));
                    }
                }
                subclasses.add(subclasse);
            }
        }
        classe.getSubclasses().clear();
        classe.getSubclasses().addAll(subclasses);
    }

    private ClasseResumoDto paraResumo(Classe c) {
        return new ClasseResumoDto(
                c.getId(), c.getNome(), c.getSubtitulo(), c.getIcone(), c.getCor(),
                c.getDadoDeVida(), c.getDificuldade(),
                c.getPapeis().stream().map(ClassePapel::getPapel).collect(Collectors.toList())
        );
    }

    private ClasseDetalheDto paraDetalhe(Classe c) {
        return new ClasseDetalheDto(
                c.getId(), c.getNome(), c.getSubtitulo(), c.getIcone(), c.getCor(),
                c.getDadoDeVida(), c.getDificuldade(), c.getDescricaoIntro(), c.getTabelasTextoBruto(),
                c.getPapeis().stream().map(ClassePapel::getPapel).collect(Collectors.toList()),
                c.getNiveis().stream()
                        .map(n -> new NivelDto(n.getNivel(), n.getBonusProficiencia(), n.getCaracteristicas()))
                        .collect(Collectors.toList()),
                c.getCaracteristicas().stream()
                        .map(car -> new CaracteristicaDto(car.getTitulo(), car.getCorpo(), car.getTipo(), car.getNivel()))
                        .collect(Collectors.toList()),
                c.getSubclasses().stream()
                        .map(s -> new SubclasseDto(
                                s.getNome(), s.getIcone(), s.getIntroTexto(), s.getMagiasTexto(),
                                s.getCaracteristicas().stream()
                                        .map(car -> new SubclasseCaracteristicaDto(car.getTitulo(), car.getCorpo(), car.getNivel()))
                                        .collect(Collectors.toList())
                        ))
                        .collect(Collectors.toList())
        );
    }
}
