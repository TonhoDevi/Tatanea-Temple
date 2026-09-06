package com.tatanea.templeinfo.talento;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class TalentoControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void deveListarTalentosSeedados() throws Exception {
        mockMvc.perform(get("/api/talentos"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value("adepto-marcial"));
    }

    @Test
    void deveBuscarTalentoPorIdComBeneficios() throws Exception {
        mockMvc.perform(get("/api/talentos/adepto-marcial"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.beneficios.length()").value(2));
    }

    @Test
    void deveRetornar404ParaTalentoInexistente() throws Exception {
        mockMvc.perform(get("/api/talentos/nao-existe"))
                .andExpect(status().isNotFound());
    }
}
