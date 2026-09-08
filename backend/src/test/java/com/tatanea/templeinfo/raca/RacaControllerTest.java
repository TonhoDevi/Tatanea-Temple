package com.tatanea.templeinfo.raca;

import com.tatanea.templeinfo.comum.TipoHabilidade;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class RacaControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private RacaRepository racaRepository;

    private Long anaoRochosoId;

    @BeforeEach
    void setUp() {
        racaRepository.deleteAll();
        Raca raca = new Raca("anao-rochoso", "Anão Rochoso", CategoriaRaca.TRIBAL, 9, TamanhoRaca.MEDIO);
        raca.adicionarHabilidadeEspecial("Visão no Escuro", "Enxerga no escuro até 18 metros.", TipoHabilidade.PASSIVA, 0);
        anaoRochosoId = racaRepository.save(raca).getId();
    }

    @Test
    void deveListarRacasCadastradas() throws Exception {
        mockMvc.perform(get("/api/racas"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].slug").value("anao-rochoso"))
                .andExpect(jsonPath("$[0].nome").value("Anão Rochoso"));
    }

    @Test
    void deveBuscarRacaPorIdComHabilidadesEspeciais() throws Exception {
        mockMvc.perform(get("/api/racas/" + anaoRochosoId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.habilidadesEspeciais").isNotEmpty());
    }

    @Test
    void deveRetornar404ParaRacaInexistente() throws Exception {
        mockMvc.perform(get("/api/racas/999999"))
                .andExpect(status().isNotFound());
    }
}
