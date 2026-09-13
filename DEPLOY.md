# Guia de Implantação — Tatanea Temple

Arquitetura de produção, com custo zero e sem precisar de cartão de crédito:

- **Frontend** → [Vercel](https://vercel.com/) (free tier)
- **Backend** → [Render](https://render.com/) (free tier, deploy via Docker)
- **Banco de dados** → PostgreSQL do [Supabase](https://supabase.com/) (free tier)

Nenhum passo aqui te cobra nada dentro dos limites gratuitos de cada serviço.

> **Nota sobre o free tier do Render**: o serviço "dorme" depois de ~15 minutos
> sem receber requisições. A próxima requisição acorda o container, o que leva
> uns 30-50 segundos na primeira chamada. Os dados no Supabase não são afetados
> — só o servidor da API fica temporariamente parado até a próxima visita.

---

## 1. Banco de dados (Supabase)

1. Crie uma conta em [supabase.com](https://supabase.com/) e um novo projeto.
2. Guarde a senha do banco que você definir na criação — ela some depois (dá
   pra resetar em **Project Settings → Database → Reset database password**
   se perder).
3. Em **Project Settings → Database → Connection string**, use a aba
   **Connection pooling** (não a "Direct connection"):
   - O host direto (`db.<ref>.supabase.co`) hoje só resolve em **IPv6**, e a
     maioria das plataformas free tier (Render incluso) não tem saída IPv6 —
     a conexão falha silenciosamente. O pooler (Supavisor) tem um host
     compatível com IPv4.
   - `DB_URL`: `jdbc:postgresql://<host-do-pooler>.pooler.supabase.com:6543/postgres?prepareThreshold=0`
     — o `prepareThreshold=0` é obrigatório: sem ele o driver JDBC quebra com
     `prepared statement "S_1" already exists` assim que o Hikari reutiliza
     uma conexão, porque o pooler roda em modo *transaction* (não guarda
     prepared statements entre requisições).
   - `DB_USER`: `postgres.<referência-do-projeto>` (não é só `postgres` — inclui o ref)
   - `DB_PASSWORD`: a senha que você definiu (ou resetou)
4. Não precisa criar tabelas manualmente — o Flyway cria o schema sozinho no primeiro start do backend (mesma coisa que já acontece hoje com o H2 local).

---

## 2. Backend (Render)

1. Crie uma conta em [render.com](https://render.com/) (dá pra logar direto com o GitHub, sem cartão).
2. **New → Web Service** → conecte o repositório `Tatanea-Temple`.
3. Configurações do serviço:
   - **Root Directory**: `backend`
   - **Runtime**: **Docker** (o Render detecta o `backend/Dockerfile` automaticamente)
   - **Instance Type**: `Free`
4. Em **Environment → Environment Variables**, adicione:
   - `SPRING_PROFILES_ACTIVE` = `prod`
   - `DB_URL`, `DB_USER`, `DB_PASSWORD` = valores do passo 1 (Supabase pooler)
   - `JWT_SECRET` = gere com `openssl rand -base64 32`
   - `FRONTEND_URL` = a URL que a Vercel vai gerar no passo 3 (pode deixar um valor provisório e voltar aqui depois)
5. Clique em **Create Web Service**. O primeiro build demora alguns minutos (compila o Maven dentro do Docker).
6. Quando o deploy terminar, o Render te dá uma URL pública, tipo `https://tatanea-backend.onrender.com`. Essa é o `BACKEND_DOMAIN` — já vem com HTTPS automático, sem precisar configurar nada de certificado.
7. Teste com `https://<sua-url>.onrender.com/swagger-ui.html`.

### 2.1. Atualizar o backend depois de mudanças
Basta dar `git push` na branch conectada ao serviço (normalmente `main`) — o Render redeploya automaticamente. Não precisa de SSH nem comandos manuais.

---

## 3. Frontend (Vercel)

1. Crie uma conta em [vercel.com](https://vercel.com/) e importe o repositório do GitHub.
2. Configure o projeto:
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build` (padrão do Vite, já detectado)
   - **Output Directory**: `dist` (padrão)
3. Em **Settings → Environment Variables**, adicione:
   - `VITE_API_BASE_URL` = `https://<sua-url>.onrender.com/api` (a URL do Render do passo 2)
4. Faça o deploy. O `frontend/vercel.json` já está configurado para redirecionar todas as rotas pro `index.html` (necessário porque o Vue Router usa modo `history`).
5. Volte nas variáveis de ambiente do serviço no Render e confirme que `FRONTEND_URL` é exatamente a URL que a Vercel gerou (ou seu domínio customizado), senão o CORS bloqueia as chamadas.

---

## 4. Checklist final

- [ ] `https://<sua-url>.onrender.com/swagger-ui.html` abre e lista os endpoints
- [ ] `https://<sua-url>.onrender.com/api/racas` retorna a lista de raças
- [ ] O frontend na Vercel carrega o compêndio (confirma que `VITE_API_BASE_URL` está correto)
- [ ] Cadastro/login funcionam (confirma `JWT_SECRET` e CORS/`FRONTEND_URL`)
- [ ] O serviço no Render aparece como `Live` no dashboard
