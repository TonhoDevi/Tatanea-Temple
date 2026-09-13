package com.tatanea.templeinfo.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Arrays;

@Configuration
public class TempleConfig implements WebMvcConfigurer {

    @Value("${app.cors.allowed-origins}")
    private String allowedOrigins;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // allowedOriginPatterns (em vez de allowedOrigins) porque precisamos do
        // wildcard "*.vercel.app": cada preview de PR/branch na Vercel ganha um
        // subdominio aleatorio, e allowedOrigins só faz comparação exata de string.
        String[] configuredOrigins = allowedOrigins.split(",");
        String[] origins = Arrays.copyOf(configuredOrigins, configuredOrigins.length + 1);
        origins[origins.length - 1] = "https://*.vercel.app";

        registry.addMapping("/api/**")
                .allowedOriginPatterns(origins)
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*");
    }
}
