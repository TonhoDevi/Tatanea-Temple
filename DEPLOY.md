# Guia de Implantação — Tatanea Temple

Arquitetura de produção, com custo zero:

- **Frontend** → [Vercel](https://vercel.com/) (free tier)
- **Backend** → VM "Always Free" da [Oracle Cloud](https://cloud.oracle.com/), rodando em Docker atrás de um Caddy (HTTPS automático)
- **Banco de dados** → PostgreSQL do [Supabase](https://supabase.com/) (free tier)

Nenhum passo aqui te cobra nada dentro dos limites gratuitos de cada serviço.

---

## 1. Banco de dados (Supabase)

1. Crie uma conta em [supabase.com](https://supabase.com/) e um novo projeto.
2. Guarde a senha do banco que você definir na criação — ela some depois.
3. Em **Project Settings → Database → Connection string**, use a aba **URI** (ou monte manualmente):
   - `DB_URL`: `jdbc:postgresql://<host>:5432/postgres` (troque `postgresql://` por `jdbc:postgresql://` e tire usuário/senha da URL)
   - `DB_USER`: normalmente `postgres`
   - `DB_PASSWORD`: a senha que você definiu
4. Não precisa criar tabelas manualmente — o Flyway cria o schema sozinho no primeiro start do backend (mesma coisa que já acontece hoje com o H2 local).

---

## 2. Backend (Oracle Cloud Always Free)

### 2.1. Criar a VM
1. Crie uma conta em [cloud.oracle.com](https://cloud.oracle.com/free) (Always Free).
2. Crie uma instância de computação:
   - **Shape**: `VM.Standard.A1.Flex` (Ampere/ARM) — é a opção "Always Free" com mais RAM disponível (até 24 GB / 4 OCPUs no total da conta). Use algo como 1 OCPU / 6 GB pra essa VM.
   - **Imagem**: Ubuntu (22.04 ou mais recente).
   - Gere ou envie uma chave SSH — vai precisar dela pra entrar na VM.
3. Anote o **IP público** da instância.

### 2.2. Abrir as portas 80 e 443
Duas camadas de firewall bloqueiam tráfego por padrão na Oracle Cloud:

**a) Regras da rede (VCN)**: no painel, vá em sua instância → **Subnet** → **Security List** (ou crie uma **Network Security Group**) → adicione regras de *Ingress* liberando as portas `80` e `443` (TCP) pra `0.0.0.0/0`.

**b) Firewall da própria VM** (Ubuntu vem com `iptables`/`netfilter-persistent` bloqueando por padrão nas imagens Oracle):
```bash
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
sudo netfilter-persistent save
```

### 2.3. Instalar Docker
Conecte via SSH (`ssh ubuntu@<ip-da-vm>`) e rode:
```bash
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
newgrp docker
```

### 2.4. Domínio pro backend
O Caddy (usado aqui como proxy reverso) emite HTTPS automático via Let's Encrypt, mas isso exige um domínio de verdade apontando pro IP da VM — não funciona com IP puro.

- **Se você já tem um domínio**: crie um registro `A` (ex.: `api.seudominio.com` → IP da VM).
- **Se não tem**: use o [nip.io](https://nip.io/) — qualquer endereço `<ip>.nip.io` resolve sozinho pro IP embutido no nome, sem cadastro nenhum. Ex.: se o IP da VM for `203.0.113.10`, use `203.0.113.10.nip.io` como domínio. Dá pra trocar por um domínio de verdade depois sem mudar mais nada além dessa variável.

### 2.5. Subir o backend
Ainda na VM:
```bash
git clone https://github.com/TonhoDevi/Tatanea-Temple.git
cd Tatanea-Temple/deploy
cp .env.example .env
nano .env   # preencha DB_URL, DB_USER, DB_PASSWORD, JWT_SECRET, FRONTEND_URL, BACKEND_DOMAIN
```
Gere o `JWT_SECRET` com:
```bash
openssl rand -base64 32
```
Depois:
```bash
docker compose up -d --build
docker compose logs -f backend   # acompanha o start; Ctrl+C sai do log sem parar o container
```
Teste com `curl https://<BACKEND_DOMAIN>/swagger-ui.html` (pode levar um ou dois minutos na primeira emissão do certificado).

### 2.6. Atualizar o backend depois de mudanças
```bash
cd Tatanea-Temple
git pull
cd deploy
docker compose up -d --build
```

---

## 3. Frontend (Vercel)

1. Crie uma conta em [vercel.com](https://vercel.com/) e importe o repositório do GitHub.
2. Configure o projeto:
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build` (padrão do Vite, já detectado)
   - **Output Directory**: `dist` (padrão)
3. Em **Settings → Environment Variables**, adicione:
   - `VITE_API_BASE_URL` = `https://<BACKEND_DOMAIN>/api` (o mesmo domínio configurado no passo 2.4)
4. Faça o deploy. O `frontend/vercel.json` já está configurado para redirecionar todas as rotas pro `index.html` (necessário porque o Vue Router usa modo `history`).
5. Volte no `.env` da VM do backend e confirme que `FRONTEND_URL` é exatamente a URL que a Vercel gerou (ou seu domínio customizado), senão o CORS bloqueia as chamadas.

---

## 4. Checklist final

- [ ] `https://<BACKEND_DOMAIN>/swagger-ui.html` abre e lista os endpoints
- [ ] `https://<BACKEND_DOMAIN>/api/racas` retorna a lista de raças
- [ ] O frontend na Vercel carrega o compêndio (confirma que `VITE_API_BASE_URL` está correto)
- [ ] Cadastro/login funcionam (confirma `JWT_SECRET` e CORS/`FRONTEND_URL`)
- [ ] `docker compose ps` na VM mostra `backend` e `caddy` como `Up`
