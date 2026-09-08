package com.tatanea.templeinfo.alquimia.pocao;

public record PocaoDto(
        String id, String nome, String raridade, String icone, String formula,
        String duracao, String nucleo, String descricao, String melhoria
) {
    static PocaoDto de(Pocao p) {
        return new PocaoDto(p.getId(), p.getNome(), p.getRaridade(), p.getIcone(), p.getFormula(),
                p.getDuracao(), p.getNucleo(), p.getDescricao(), p.getMelhoria());
    }
}
