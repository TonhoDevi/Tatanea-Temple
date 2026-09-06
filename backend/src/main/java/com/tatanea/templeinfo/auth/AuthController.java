package com.tatanea.templeinfo.auth;

import com.tatanea.templeinfo.auth.AuthDtos.AuthResponse;
import com.tatanea.templeinfo.auth.AuthDtos.LoginRequest;
import com.tatanea.templeinfo.auth.AuthDtos.RegistroRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    public AuthController(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
    }

    @PostMapping("/registrar")
    public ResponseEntity<?> registrar(@RequestBody RegistroRequest dto) {
        if (usuarioRepository.existsByEmail(dto.email())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("E-mail já cadastrado.");
        }
        Usuario usuario = new Usuario(dto.email(), passwordEncoder.encode(dto.senha()), dto.nome());
        usuarioRepository.save(usuario);
        String token = jwtService.gerarToken(usuario);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(new AuthResponse(token, usuario.getId(), usuario.getEmail(), usuario.getNome()));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest dto) {
        Usuario usuario = usuarioRepository.findByEmail(dto.email()).orElse(null);
        if (usuario == null || !passwordEncoder.matches(dto.senha(), usuario.getSenhaHash())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("E-mail ou senha inválidos.");
        }
        String token = jwtService.gerarToken(usuario);
        return ResponseEntity.ok(new AuthResponse(token, usuario.getId(), usuario.getEmail(), usuario.getNome()));
    }
}