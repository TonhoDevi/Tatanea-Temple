package com.tatanea.templeinfo.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

@Configuration
public class TempleConfig {

    @Value("${app.cors.allowed-origins}")
    private String allowedOrigins;

    // Exposto como bean (em vez de WebMvcConfigurer.addCorsMappings) pra poder
    // ser plugado direto no SecurityConfig via http.cors(...) -- sem isso, o
    // Spring Security responde 401 no preflight OPTIONS de qualquer rota
    // autenticada antes da requisição sequer chegar na configuração de CORS
    // do Spring MVC (que só entra em ação depois do filtro de segurança).
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        // allowedOriginPatterns (em vez de allowedOrigins) porque precisamos do
        // wildcard "*.vercel.app": cada preview de PR/branch na Vercel ganha um
        // subdominio aleatorio, e allowedOrigins só faz comparação exata de string.
        String[] configuredOrigins = allowedOrigins.split(",");
        String[] origins = Arrays.copyOf(configuredOrigins, configuredOrigins.length + 1);
        origins[origins.length - 1] = "https://*.vercel.app";

        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOriginPatterns(List.of(origins));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("*"));

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/api/**", config);
        return source;
    }
}
