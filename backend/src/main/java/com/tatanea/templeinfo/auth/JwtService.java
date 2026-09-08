package com.tatanea.templeinfo.auth;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;

@Service
public class JwtService {

    private final SecretKey chave;
    private final long validadeMs;

    public JwtService(
            @Value("${app.jwt.secret}") String secretBase64,
            @Value("${app.jwt.validade-ms:86400000}") long validadeMs
    ) {
        this.chave = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secretBase64));
        this.validadeMs = validadeMs;
    }

    public String gerarToken(Usuario usuario) {
        Date agora = new Date();
        Date expiracao = new Date(agora.getTime() + validadeMs);
        return Jwts.builder()
                .subject(usuario.getId())
                .claim("email", usuario.getEmail())
                .issuedAt(agora)
                .expiration(expiracao)
                .signWith(chave, SignatureAlgorithm.HS256)
                .compact();
    }

    public String extrairUsuarioId(String token) {
        return Jwts.parser()
                .verifyWith(chave)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .getSubject();
    }

    public boolean tokenValido(String token) {
        try {
            Jwts.parser().verifyWith(chave).build().parseSignedClaims(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}