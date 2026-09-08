package com.tatanea.templeinfo.personagem;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tatanea.templeinfo.auth.AuthDtos.RegistroRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class PersonagemControllerTest {

    @Autowired
    private MockMvc mockMvc;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Test
    void deveExigirAutenticacaoParaListarPersonagens() throws Exception {
        mockMvc.perform(get("/api/personagens"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void deveRegistrarELogarUsuario() throws Exception {
        RegistroRequest registro = new RegistroRequest("teste-personagem@tatanea.dev", "senha123", "Testador");
        mockMvc.perform(post("/api/auth/registrar")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(registro)))
                .andExpect(status().isCreated());
    }
}