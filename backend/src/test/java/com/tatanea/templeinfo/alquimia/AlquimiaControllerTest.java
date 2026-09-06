package com.tatanea.templeinfo.alquimia;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class AlquimiaControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void deveListarEssenciasSeedadas() throws Exception {
        mockMvc.perform(get("/api/alquimia/essencias"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(4));
    }

    @Test
    void deveListarPocoesSeedadas() throws Exception {
        mockMvc.perform(get("/api/alquimia/pocoes"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value("pocao-cura"));
    }

    @Test
    void deveBuscarPocaoPorId() throws Exception {
        mockMvc.perform(get("/api/alquimia/pocoes/pocao-cura"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.formula").value("ζ ζ"));
    }

    @Test
    void deveRetornar404ParaPocaoInexistente() throws Exception {
        mockMvc.perform(get("/api/alquimia/pocoes/nao-existe"))
                .andExpect(status().isNotFound());
    }
}
