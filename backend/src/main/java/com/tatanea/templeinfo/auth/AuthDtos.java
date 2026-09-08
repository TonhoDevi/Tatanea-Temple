package com.tatanea.templeinfo.auth;

public class AuthDtos {

    private AuthDtos() {
    }

    public record RegistroRequest(String email, String senha, String nome) {
    }

    public record LoginRequest(String email, String senha) {
    }

    public record AuthResponse(String token, String usuarioId, String email, String nome) {
    }
}