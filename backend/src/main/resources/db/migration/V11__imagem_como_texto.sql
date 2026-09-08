-- Remove todas as colunas TEXT (tamanho ilimitado) e troca por VARCHAR(5000).
-- Isso não é só estética: um VARCHAR com limite é rejeitado pelo próprio banco
-- se alguém tentar mandar um texto absurdamente grande (ataque de negação de
-- serviço via payload gigante), enquanto TEXT aceitaria qualquer tamanho.

ALTER TABLE personagens ALTER COLUMN idiomas SET DATA TYPE VARCHAR(5000);
ALTER TABLE personagens ALTER COLUMN historia SET DATA TYPE VARCHAR(5000);
ALTER TABLE personagens ALTER COLUMN anotacoes SET DATA TYPE VARCHAR(5000);

ALTER TABLE personagem_unidades ALTER COLUMN dados_extra_json SET DATA TYPE VARCHAR(5000);

ALTER TABLE classes ALTER COLUMN pericias SET DATA TYPE VARCHAR(5000);
ALTER TABLE classes ALTER COLUMN descricao SET DATA TYPE VARCHAR(5000);