package com.tatanea.templeinfo.classe;

import com.tatanea.templeinfo.classe.ClasseDtos.ClasseDetalheDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseRequestDto;
import com.tatanea.templeinfo.classe.ClasseDtos.ClasseResumoDto;
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
                dto.dadoDeVida(), dto.atributoChave(), dto.armadura(), dto.armas(),
                dto.ferramentas(), dto.resistencias(), dto.pericias(),
                dto.descricao(), dto.dificuldade()
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

        List<ClasseSubclasse> subclasses = new ArrayList<>();
        if (dto.subclasses() != null) {
            for (int i = 0; i < dto.subclasses().size(); i++) {
                SubclasseDto s = dto.subclasses().get(i);
                subclasses.add(new ClasseSubclasse(classe, s.nome(), s.icone(), s.descricao(), i));
            }
        }
        classe.getSubclasses().clear();
        classe.getSubclasses().addAll(subclasses);

        List<ClasseHabilidadeDestaque> habilidades = new ArrayList<>();
        if (dto.habilidadesDestaque() != null) {
            for (int i = 0; i < dto.habilidadesDestaque().size(); i++) {
                habilidades.add(new ClasseHabilidadeDestaque(classe, dto.habilidadesDestaque().get(i), i));
            }
        }
        classe.getHabilidadesDestaque().clear();
        classe.getHabilidadesDestaque().addAll(habilidades);
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
                c.getDadoDeVida(), c.getAtributoChave(), c.getArmadura(), c.getArmas(),
                c.getFerramentas(), c.getResistencias(), c.getPericias(), c.getDescricao(),
                c.getDificuldade(),
                c.getPapeis().stream().map(ClassePapel::getPapel).collect(Collectors.toList()),
                c.getSubclasses().stream()
                        .map(s -> new SubclasseDto(s.getNome(), s.getIcone(), s.getDescricao()))
                        .collect(Collectors.toList()),
                c.getHabilidadesDestaque().stream()
                        .map(ClasseHabilidadeDestaque::getNome)
                        .collect(Collectors.toList())
        );
    }
}