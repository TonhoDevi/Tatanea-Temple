package com.ddt.cosmossombrio.raca;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class RacaControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void deveListarRacasSeedadas() throws Exception {
        mockMvc.perform(get("/api/racas"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value("anao-rochoso"))
                .andExpect(jsonPath("$[0].nome").value("Anão Rochoso"));
    }

    @Test
    void deveBuscarRacaPorIdComTracosEHabilidades() throws Exception {
        mockMvc.perform(get("/api/racas/anao-rochoso"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.tracos.length()").value(2))
                .andExpect(jsonPath("$.habilidades[0].nome").value("Visão Sísmica"));
    }

    @Test
    void deveRetornar404ParaRacaInexistente() throws Exception {
        mockMvc.perform(get("/api/racas/nao-existe"))
                .andExpect(status().isNotFound());
    }
}
