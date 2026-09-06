package com.tatanea.templeinfo.raca;

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
                .andExpect(jsonPath("$.tracos").isNotEmpty());
    }

    @Test
    void deveRetornar404ParaRacaInexistente() throws Exception {
        mockMvc.perform(get("/api/racas/nao-existe"))
                .andExpect(status().isNotFound());
    }
}
