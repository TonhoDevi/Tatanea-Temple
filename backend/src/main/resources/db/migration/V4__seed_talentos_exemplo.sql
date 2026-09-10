-- Seed do compêndio de Talentos remodelado — 91 talentos portados do compêndio antigo
-- (mesmo nome, símbolo e descrição; benefícios estruturados viraram uma lista dentro da
-- descrição, já que o novo esquema não tem uma tabela própria pra benefícios).
-- Pré-requisitos em texto livre que casam com "Atributo N ou maior" viram pré-requisito
-- estruturado (atributo_requerido); os demais (proficiência, "X ou Y", etc.) continuam
-- só como texto no início da descrição, já que o novo esquema só suporta um único
-- atributo como pré-requisito de talento normal.

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-marcial', 'Adepto Marcial', '⚔️', 'Treinamento marcial avançado que permite realizar manobras de combate especiais do arquétipo Mestre de Batalha.

Benefícios:
- Aprende duas manobras à sua escolha da lista do Mestre de Batalha.
- CD das manobras: 8 + bônus de proficiência + mod. de Força ou Destreza.
- Ganha 1 dado de superioridade d6 (ou mais 1 se já possuir); recuperado em descanso curto ou longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('alerta', 'Alerta', '👁️', 'Sempre atento ao perigo, você reage mais rápido e nunca é pego de surpresa.

Benefícios:
- +5 de bônus em iniciativa.
- Não pode ser surpreendido enquanto estiver consciente.
- Outras criaturas não ganham vantagem em ataques por não serem visíveis para você.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ambidestro', 'Ambidestro', '🗡️', 'Domínio do estilo com duas armas, oferecendo proteção e velocidade de ataque superiores.

Benefícios:
- +1 de bônus na CA enquanto empunhar uma arma corpo a corpo em cada mão.
- Pode usar combater com duas armas mesmo que a arma não seja leve.
- Pode sacar ou guardar duas armas de uma mão de uma só vez.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atacante-bestial', 'Atacante Bestial', '🐾', 'Seus golpes corpo a corpo são devastadores — você pode repetir o dado de dano e escolher o melhor resultado.

Benefícios:
- Ao rolar dano em ataque corpo a corpo com arma, pode relançar o dado de dano da arma e usar qualquer dos valores.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atirador-aguçado', 'Atirador Aguçado', '🏹', 'Domínio total de armas à distância: ignore alcance, cobertura e troque precisão por poder de fogo.

Benefícios:
- Atacar além do alcance normal não impõe desvantagem.
- Ataques à distância ignoram meia-cobertura e três-quartos de cobertura.
- Pode sofrer –5 na jogada de ataque para ganhar +10 no dano.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('combatente-montado', 'Combatente Montado', '🐴', 'Oponente perigoso quando montado, com vantagem sobre alvos menores e proteção para a montaria.

Benefícios:
- Vantagem em ataques corpo a corpo contra criaturas desmontadas menores que sua montaria.
- Pode forçar ataques direcionados à montaria para si mesmo.
- Sua montaria não sofre dano em testes de resistência de Destreza bem-sucedidos.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('duelista-defensivo', 'Duelista Defensivo', '🤺', 'Pré-requisito: Destreza 13 ou maior

Ao ser atingido por ataque corpo a corpo, usa sua reação para adicionar o bônus de proficiência à CA.

Benefícios:
- Reação: adiciona o bônus de proficiência à CA quando atingido por ataque corpo a corpo.
- Requer empunhar uma arma de acuidade com proficiência.', 'destreza', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-veneno', 'Especialista em Veneno', '🧪', 'Pré-requisito: Proficiência com kit de Alquimia.

Mestre na criação e aplicação de venenos letais que ignoram resistências.

Benefícios:
- Você recebe resistência a dano venenoso.
- Você recebe um bonus de +3 em rolagem de fabricação de poções do tipo veneno.
- Dano de veneno criado por você é aumentado em uma quantidade igual ao seu bônus de proficiência.
- Você pode usar uma ação bônus para aplicar veneno em uma arma ou projétil.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('esmagador', 'Esmagador', '🔨', 'Especialista em dano contundente: empurra inimigos e explora críticos para dominar o campo de batalha.

Benefícios:
- +1 em Força ou Constituição (máx. 20).
- Uma vez por turno, ao acertar dano contundente, pode mover o alvo até 1,5 m.
- Ao acertar um crítico com dano contundente, ataques subsequentes contra o alvo têm vantagem até seu próximo turno.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-besta', 'Especialista em Besta', '🔫', 'Domínio completo de bestas: ignore a recarga, atire próximo a inimigos e use ação bônus para atacar.

Benefícios:
- Ignora a propriedade de recarga de bestas com ação bônus.
- Estar a 1,5 m de inimigos não impõe desvantagem nos ataques.
- Ao usar ação de Ataque com arma de uma mão, pode usar ação bônus para atacar com besta de mão.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-briga', 'Especialista em Briga', '👊', 'Veterano de brigas usando qualquer coisa como arma. Seus golpes desarmados causam mais dano.

Benefícios:
- +1 em Força ou Constituição (máx. 20).
- Ataques desarmados ou com armas improvisadas causam 1d4 de dano extra.
- Ao acertar ataque desarmado ou improvisado, pode usar ação bônus para tentar agarrar o alvo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('imobilizador', 'Imobilizador', '🪢', 'Pré-requisito: Força 13 ou maior

Especialista em prender e imobilizar oponentes em combate engajado.

Benefícios:
- Vantagem em jogadas de ataque contra criaturas agarradas.
- Ação: pode imobilizar criatura agarrada com outro teste de agarrar (ambos ficam impedidos).', 'forca', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-combate', 'Iniciado em Combate', '🛡️', 'Pré-requisito: Proficiência com arma marcial

Treinamento marcial único que ensina um Estilo de Luta da lista do guerreiro.

Benefícios:
- +1 em Força ou Destreza (máx. 20).
- Aprende um Estilo de Luta à sua escolha da lista de estilos de luta do guerreiro.
- Pode trocar o estilo ao subir de nível.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('investida-poderosa', 'Investida Poderosa', '💨', 'Ao usar Disparada, pode atacar ou empurrar com ação bônus — e ganhar bônus ao se mover antes.

Benefícios:
- Ao usar Disparada, ação bônus para atacar corpo a corpo ou empurrar.
- Se mover pelo menos 3 m antes do ataque: +5 no dano ou empurra até 3 m.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('lacerador', 'Lacerador', '🗡️', 'Cortes precisos reduzem o deslocamento do inimigo e impõem desvantagem em críticos.

Benefícios:
- +1 em Força ou Destreza (máx. 20).
- Uma vez por turno, ao acertar dano cortante, reduz deslocamento do alvo em 3 m até seu próximo turno.
- Crítico com dano cortante: alvo sofre desvantagem em ataques até o próximo turno.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-arma-haste', 'Maestria em Arma de Haste', '🪄', 'Pré-requisito: Proficiência com armas de Haste

Mantém inimigos afastados e ataca com a extremidade oposta como ação bônus.

Benefícios:
- Ao atacar com glaive, alabarda ou bordão, você pode usar uma ação bônus para atacar com a outra extremidade (1d4 contundente).
- Criaturas que entrarem no seu alcance enquanto empunha armas de haste provocam ataques de oportunidade.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('matador-conjuradores', 'Matador de Conjuradores', '🔮', 'Técnicas especializadas para combater conjuradores em distâncias curtas.

Benefícios:
- Reação: ao ver criatura a até 1,5 m conjurar, pode realizar ataque corpo a corpo contra ela.
- Dano em criatura concentrada causa desvantagem no teste de concentração.
- Vantagem em testes de resistência contra magias de criaturas a até 1,5 m.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-armas', 'Adepto de Armas', '⚙️', 'Treinamento extensivo com uma variedade de armas simples e marciais.

Benefícios:
- +1 em Força ou Destreza (máx. 20).
- Ganha proficiência com todas as armas.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-armas-grandes', 'Mestre de Armas Grandes', '🪓', 'Pré-requisito: Força 13 ou maior e proficiência com pelo menos uma arma pesada

Usa o peso das armas pesadas a seu favor, com ataques bônus em críticos e dano devastador.

Benefícios:
- Você causa o dobro de dano a construções e objetos.
- Ao acertar um acerto crítico ou reduzir alvo a 0 PV, você pode como parte desse mesmo ataque atingir uma outra criatua que esteja em seu alcance desde que a rolagem original também à atinja.
- Antes de realizar um ataque com arma pesada você pode escolher sofrer –5 na jogada de ataque para ganhar +10 no dano.', 'forca', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-escudo', 'Mestre de Escudo', '🛡️', 'Pré-requisito: Proficiência com escudos

Usa o escudo como arma ofensiva e proteção extra contra magias e efeitos de área.

Benefícios:
- Com uma ação bônus você pode empurrar uma criatura no alcance, para trás a até 3m de distância.
- Adiciona o bônus de CA do escudo a testes de resistência de Destreza.
- Quando um aliado a até 1,5m de você for alvo de um ataque corpo a corpo, você pode usar sua reação para impor desvantagem no ataque. Essa habilidade funciona em conjunto com o estilo de luta Defensor.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mobilidade', 'Mobilidade', '💨', 'Movimentação excepcional: mais velocidade, ignore terreno difícil ao disparar e evite contra-ataques.

Benefícios:
- Deslocamento aumenta em 3 metros.
- Ao usar Disparada, terreno difícil não custa movimento adicional.
- Ao atacar uma criatura corpo a corpo, ela não provoca ataque de oportunidade de você pelo resto do turno.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('perfurador', 'Perfurador', '🗡️', 'Precisão cirúrgica com dano perfurante: relance dados e potencialize críticos.

Benefícios:
- +1 em Força ou Destreza (máx. 20).
- Uma vez por turno, ao acertar dano perfurante, pode relançar um dado de dano e escolher o resultado.
- Crítico com dano perfurante: rola um dado de dano adicional.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sentinela', 'Sentinela', '🗡️', 'Dominador do ataque de oportunidade: para inimigos na fuga, pune quem desengaja e protege aliados.

Benefícios:
- Ao acertar ataque de oportunidade, o deslocamento da criatura se torna 0 e você pode mover o alvo 1,5 m em qualquer direção. Se o alvo colidir com obstáculo ou criatura, sofre dano extra igual ao bônus de proficiência.
- Criaturas provocam ataque de oportunidade mesmo ao usar Desengajar.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('tita-ataque', 'Titã de Ataque', '💪', 'Pré-requisito: Força 15 ou maior

Força imparável no campo de batalha: ignore a propriedade de duas mãos e destrua em sequência.

Benefícios:
- Você pode ignorar a propriedade de duas mãos de armas pesadas.
- Ao se mover pelo menos 3 m antes de atacar, rola dano duas vezes e fica com o melhor.', 'forca', 15);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-armadura-media', 'Maestria em Armadura Média', '🛡️', 'Pré-requisito: Proficiência em armadura média

Usa armadura média sem penalidade de furtividade e extrai o máximo de proteção com alta Destreza.

Benefícios:
- Armadura média não impõe desvantagem em Furtividade.
- Recebe um bonus de +1 em CA se tiver Destreza 16 ou maior e estiver usando armadura média.
- Se tiver Destreza 16 ou maior e estiver usando armadura média, recebe um bonus de +1 em testes de resistência de Destreza.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-armadura-pesada', 'Maestria em Armadura Pesada', '🛡️', 'Pré-requisito: Proficiência em armadura pesada

Armadura pesada reduz dano físico não-mágico recebido em 3 e aumenta a CA.

Benefícios:
- Dano de concussão, cortante e perfurante não-mágico recebido é reduzido em 3.
- Se tiver Força 16 ou maior e estiver usando armadura pesada, recebe um bonus de +1 em CA.
- Se tiver Força 16 ou maior e estiver usando armadura pesada, recebe um bonus de +1 em testes de resistência de Força.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('resiliente', 'Resiliente', '💠', 'Fortalece um atributo e concede proficiência no teste de resistência correspondente.

Benefícios:
- +1 no valor de habilidade escolhido (máx. 20).
- Ganha proficiência em testes de resistência com a habilidade escolhida.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('resistente', 'Resistente', '🪨', 'Corpo resistente que recebe mais cura.

Benefícios:
- +1 em Constituição (máx. 20).
- Ao receber uma cura, ela é aumentada em 50%.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('robusto', 'Robusto', '❤️', 'Reserva de PV muito maior — cresce a cada nível ganho.

Benefícios:
- +1 em Constituição (máx. 20).
- Máximo de PV aumenta em 3 × nível atual ao adquirir o talento.
- Cada nível subsequente concede +3 PV adicionais.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-elemental', 'Adepto Elemental', '🔥', 'Pré-requisito: Capacidade de conjurar pelo menos uma magia

Domina um tipo de dano elemental, ignorando resistências e relançando dados com resultado 1.

Benefícios:
- Escolha um tipo: ácido, elétrico, fogo, frio ou trovão.
- Suas magias ignoram resistência ao tipo escolhido.
- Ao rolar dano com esse tipo, pode relançar qualquer dado com resultado 1.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-metamagico', 'Adepto Metamágico', '✨', 'Pré-requisito: Habilidade de Conjuração ou Magia de Pacto

Aprende duas opções de Metamagia da lista do feiticeiro e ganha pontos de feitiçaria.

Benefícios:
- Aprende duas opções de Metamagia da lista do feiticeiro.
- Ganha 2 pontos de feitiçaria para usar com Metamagia.
- Pode substituir uma opção de Metamagia ao subir de nível.
- Recupera todos os pontos em descanso longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-mistico', 'Adepto Místico', '🌙', 'Pré-requisito: Habilidade de Conjuração ou Magia de Pacto

Desbloqueia uma Invocação Mística da classe do bruxo.

Benefícios:
- Aprende uma Invocação Mística da lista do bruxo.
- Se a invocação tiver requisito, só pode escolhê-la se for bruxo e cumpri-lo.
- Pode trocar a invocação por outra ao subir de nível.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atirador-magia', 'Atirador de Magia', '⚡', 'Pré-requisito: Capacidade de conjurar pelo menos uma magia

Magias de ataque com o dobro do alcance, ignorando coberturas.

Benefícios:
- Magias que exigem jogada de ataque têm o alcance dobrado.
- Ataques à distância com magia ignoram meia-cobertura e três-quartos de cobertura.
- Aprende um truque de ataque de uma lista à escolha.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('conjurador-guerra', 'Conjurador de Guerra', '⚔️', 'Pré-requisito: Capacidade de conjurar pelo menos uma magia

Conjura magias no meio do combate com maestria, mantendo concentração e usando ataques de oportunidade mágicos.

Benefícios:
- Vantagem em testes de Constituição para manter concentração após sofrer dano.
- Pode realizar componentes somáticos mesmo com armas ou escudo nas mãos.
- Quando uma criatura provocar ataque de oportunidade contra você, você pode com uma reação conjurar uma magia com tempo de conjuração de ação ou ação bônus com um alvo no lugar.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('conjurador-ritual', 'Conjurador de Ritual', '📜', 'Pré-requisito: Inteligência ou Sabedoria 13 ou maior

Aprende e conjura magias como rituais a partir de um livro especial.

Benefícios:
- Recebe um livro de rituais com duas magias de 1º nível com o descritor ritual.
- Escolha bardo, bruxo, clérigo, druida, feiticeiro ou mago para definir o atributo de conjuração.
- Pode adicionar magias rituais encontradas ao livro (2h + 50 po por nível).', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-artifice', 'Iniciado Artífice', '⚙️', 'Aprende habilidades dos artífices: um truque, uma magia de 1º nível e proficiência com ferramenta.

Benefícios:
- Aprende um truque e uma magia de 1º círculo do artífice (Inteligência).
- Pode conjurar a magia de 1º círculo gratuitamente uma vez por descanso longo.
- Proficiência com um tipo de ferramenta de artesão (pode ser foco de conjuração).', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-magia', 'Iniciado em Magia', '📖', 'Aprende dois truques e uma magia de 1º nível de outra classe conjuradora.

Benefícios:
- Escolha uma classe: bardo, bruxo, clérigo, druida, feiticeiro ou mago.
- Aprende dois truques da lista da classe escolhida.
- Aprende uma magia de 1º nível da mesma classe; pode conjurá-la uma vez por descanso longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('telepático', 'Telepático', '🧠', 'Comunica-se telepaticamente e lê pensamentos sem usar espaços de magia.

Benefícios:
- +1 em Inteligência, Sabedoria ou Carisma (máx. 20).
- Fala telepaticamente com criaturas à vista até 18 m (deve conhecer o idioma).
- Pode conjurar Detectar Pensamentos sem espaço de magia ou componentes.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('tocado-sombras', 'Tocado pelas Sombras', '🌑', 'Magia sombria modificou você: aprende Invisibilidade e uma magia de ilusão ou necromancia.

Benefícios:
- +1 em Inteligência, Sabedoria ou Carisma (máx. 20).
- Aprende Invisibilidade e uma magia de 1º círculo (Ilusão ou Necromancia).
- Pode conjurar ambas sem espaço de magia; recupera após descanso longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atleta', 'Atleta', '🏃', 'Treinamento físico intenso melhora movimentação, escalada e saltos.

Benefícios:
- +1 em Força ou Destreza (máx. 20).
- Se levantar do chão custa apenas 1,5 m de deslocamento.
- Escalar não custa deslocamento adicional.
- Salto em distância/altura com apenas 1,5 m de corrida.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('explorador-cavernas', 'Explorador de Cavernas', '🗺️', 'Detecta armadilhas e portas secretas com facilidade, e resiste melhor aos seus efeitos.

Benefícios:
- Vantagem em Percepção e Investigação para detectar portas secretas.
- Vantagem em testes de resistência contra armadilhas.
- Resistência a dano causado por armadilhas.
- Pode procurar armadilhas em ritmo normal de viagem.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especializado-pericia', 'Especializado em Perícia', '🎯', 'Aprimora uma perícia à escolha, concedendo especialidade e aumentando um atributo.

Benefícios:
- +1 em um atributo à escolha (máx. 20).
- Proficiência em uma perícia à escolha.
- Especialidade em uma perícia com proficiência (dobra o bônus de proficiência).', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mente-afiada', 'Mente Afiada', '🧭', 'Memória perfeita e senso de orientação infalível — nunca se perde nem esquece nada.

Benefícios:
- +1 em Inteligência (máx. 20).
- Sempre sabe a direção do norte.
- Sempre sabe o tempo restante para o próximo nascer ou pôr do sol.
- Recorda com precisão qualquer coisa vista ou ouvida no último mês.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('observador', 'Observador', '🔍', 'Percepção aguçada: lê lábios e possui altíssimos valores passivos de Percepção e Investigação.

Benefícios:
- +1 em Inteligência ou Sabedoria (máx. 20).
- Pode ler lábios de criatura que fale idioma que compreenda.
- +5 nos valores passivos de Percepção e Investigação.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('perito', 'Perito', '📚', 'Proficiência em três perícias ou ferramentas à escolha.

Benefícios:
- Ganha proficiência em qualquer combinação de três perícias ou ferramentas.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('poliglota', 'Poliglota', '🗣️', 'Domínio de idiomas e criptografia: aprende três línguas e cria códigos indecifráveis.

Benefícios:
- +1 em Inteligência (máx. 20).
- Aprende três idiomas à escolha.
- Pode criar criptogramas: outros só decifram com sucesso em Inteligência (CD = Int + prof.) ou magia.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sorrateiro', 'Sorrateiro', '🌑', 'Pré-requisito: Destreza 13 ou maior

Especialista em furtividade: se esconde na penumbra e mantém posição após errar ataques.

Benefícios:
- Pode tentar se esconder quando estiver levemente obscurecido.
- Errar um ataque à distância estando escondido não revela sua posição.
- Penumbra não impõe desvantagem em testes de Percepção visual.', 'destreza', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ator', 'Ator', '🎭', 'Mestre da mímica e do disfarce: vantagem em Atuação e Enganação ao se passar por outra pessoa.

Benefícios:
- +1 em Carisma (máx. 20).
- Vantagem em Atuação e Enganação ao se disfarçar.
- Pode imitar a voz ou sons de qualquer criatura ouvida por ao menos 1 minuto.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('chef', 'Chef', '🍖', 'Cozinheiro habilidoso que prepara alimentos que curam e concedem PV temporários.

Benefícios:
- +1 em Constituição ou Sabedoria (máx. 20).
- Proficiência com Utensílios de Cozinheiro.
- Descanso curto: prepara refeição para prof.+4 criaturas que recuperam 1d8 PV extras ao gastar Dados de Vida.
- Descanso longo: cria aperitivos (= bônus de prof.) que concedem PV temporários iguais ao bônus de proficiência.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('curandeiro', 'Curandeiro', '⚕️', 'Cirurgião capacitado que estabiliza aliados com PV e cura de forma eficiente.

Benefícios:
- Ao estabilizar criatura morrendo com kit de primeiros-socorros, ela recupera 1 PV.
- Ação: gasta kit para restaurar 1d6+4 + Dados de Vida totais da criatura em PV (uma vez por descanso).', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('lider-inspirador', 'Líder Inspirador', '👑', 'Pré-requisito: Carisma 13 ou maior

Inspira aliados com um discurso de 10 minutos, concedendo PV temporários.

Benefícios:
- 10 minutos: até 6 criaturas amigáveis recebem PV temporários = nível + mod. de Carisma.
- Criaturas só podem se beneficiar novamente após descanso curto ou longo.', 'carisma', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sortudo', 'Sortudo', '🍀', 'Sorte inexplicável: rerrole dados em momentos críticos usando pontos de sorte.

Benefícios:
- 3 pontos de sorte recuperados em descanso longo.
- Gasta 1 ponto para rolar d20 adicional em qualquer ataque, teste ou resistência — escolhendo qual usar.
- Também pode influenciar ataques de inimigos contra você.
- Pontos se cancelam se múltiplas criaturas os usam na mesma jogada.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('intimidacao-brutal', 'Intimidação Brutal', '💪', 'Sua presença física é mais assustadora do que palavras.

Benefícios:
- Você pode usar Força em vez de Carisma em testes de Intimidação.
- Se estiver adjacente ao alvo, adiciona +2 ao teste.
- Em caso de sucesso por 5 ou mais, o alvo não pode se aproximar voluntariamente de você até o fim do próximo turno.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('vontade-resistente', 'Vontade Resistente', '🫀', 'Sua vitalidade impede que você sucumba facilmente à morte.

Benefícios:
- Você adiciona seu modificador de Constituição em testes de resistência contra morte.
- Ao obter 3 sucessos em teste de morte, recupera 1 PV.
- Em um sucesso crítico você ignora penalidade de ferimento.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('leitura-combate', 'Leitura de Combate', '👁️', 'Você analisa padrões de ataque e defesa durante o combate.

Benefícios:
- Uma vez por turno, ao errar um ataque, recebe +2 na próxima jogada de ataque contra o mesmo alvo até o fim do turno.
- Se acertar esse ataque, o alvo recebe uma penalidade de -2 na próxima jogada de ataque contra você.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('passo-calculado', 'Passo Calculado', '🧭', 'Você se move com precisão, evitando riscos desnecessários.

Benefícios:
- Ao se mover metade do seu deslocamento ou menos no turno, recebe +2 na CA até o início do próximo turno.
- Esse bônus não se aplica se estiver com armadura pesada.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sobrevivente-nato', 'Sobrevivente Nato', '🌿', 'Você resiste melhor às adversidades naturais e situações extremas.

Benefícios:
- Recebe +2 em testes de resistência contra exaustão.
- Pode passar o dobro do tempo normal sem comida ou água antes de sofrer penalidades.
- Testes para rastrear você têm CD aumentada em +2.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('reacao-instintiva', 'Reação Instintiva', '⚡', 'Seu corpo reage antes mesmo de você pensar.

Benefícios:
- Adiciona o seu bônus de proficiência em testes de Iniciativa.
- Na primeira rodada de combate, se ainda não tiver agido, recebe um bônus na CA igual ao seu bônus de proficiência.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('foco-disciplinado', 'Foco Disciplinado', '🎯', 'Você mantém concentração e precisão mesmo sob pressão.

Benefícios:
- Recebe +2 em testes de Constituição para manter concentração.
- Ao falhar por 2 ou menos, pode repetir o teste mais uma única vez.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('leitor-intencoes', 'Leitor de Intenções', '🧠', 'Você lê microexpressões e intenções ocultas, detectando mentiras e hostilidade com precisão.

Benefícios:
- +1 em Sabedoria (máx. 20).
- +5 em testes de Intuição para detectar mentiras.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('olhar-analitico', 'Olhar Analítico', '🔍', 'Você avalia rapidamente criaturas e identifica padrões físicos e fraquezas.

Benefícios:
- Ação bônus: escolha uma criatura a até 12 m e realize um teste de Intuição (CD = 10 + metade do CR da criatura ou 10 + mod. de Enganação do alvo).
- Em sucesso, você descobre uma resistência, imunidade ou vulnerabilidade da criatura (à escolha do mestre).
- Em um sucesso por 5 ou mais, pode escolher qual dessas informações deseja saber.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('improvisador', 'Improvisador', '🛠️', 'Você transforma qualquer objeto em ferramenta útil, encontrando soluções mesmo sem o equipamento adequado.

Benefícios:
- Você pode usar um kit de ferramentas diferente do necessário; a rolagem é feita com desvantagem.
- Você recebe proficiência em um kit de ferramenta à sua escolha.
- Você consome metade do material em produção.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('planejador-nato', 'Planejador Nato', '🧭', 'Pré-requisito: Inteligência 13 ou maior

Você antecipa cenários e prepara aliados com instruções táticas antes da ação começar.

Benefícios:
- Após 1 minuto de planejamento, escolha até 6 criaturas aliadas.
- Cada uma pode adicionar 1d6 a uma única jogada de ataque, teste de habilidade ou resistência nas próximas 1 hora.
- Uma criatura só pode se beneficiar uma vez por uso deste talento.
- Pode usar essa habilidade uma vez por descanso curto ou longo.', 'inteligencia', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mente-inabalavel', 'Mente Inabalável', '🧱', 'Sua mente resiste a manipulações externas e efeitos debilitantes.

Benefícios:
- +2 em testes de resistência contra ser Amedrontado ou Enfeitiçado.
- Reação: ao falhar em um teste contra esses efeitos, pode repetir o teste.
- Em sucesso, torna-se imune ao mesmo efeito pela duração original.
- Pode usar essa reação uma vez por descanso curto.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('intervencao-rapida', 'Intervenção Rápida', '⚡', 'Você reage rapidamente a situações inesperadas, auxiliando aliados no momento crítico.

Benefícios:
- Reação: quando um aliado a até 1,5 m falhar em um teste de habilidade ou resistência, você pode conceder +1d6 ao resultado.
- Se isso transformar a falha em sucesso, o aliado pode se mover até 3 m sem provocar ataques de oportunidade.
- Pode usar essa reação um número de vezes igual ao bônus de proficiência por descanso longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('momentos-heroicos', 'Momentos Heroicos', '🌟', 'Você ultrapassa seus limites quando mais precisa.

Benefícios:
- +1 em Constituição (máx. 20).
- No momento que você for levado a 0 pontos de vida, você pode usar sua reação para realizar uma ação completa.
- Você pode usar essa habilidade uma vez por descanso longo.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adaptado-a-noite', 'Adaptado à Noite', '🌙', 'Seu corpo se acostumou à ausência de luz e descanso irregular.

Benefícios:
- +1 em Sabedoria (máx. 20).
- Você adquire visão no escuro de 9 m, ou aumenta em 9 m se já possuir.
- Você não sofre desvantagem em qualquer teste de perícia realizado na escuridão total.
- Recebe +2 em testes contra exaustão causada por falta de descanso.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sentido-sismico', 'Sentido Sísmico', '🌍', 'Pré-requisito: Proficiência em Percepção

Você percebe o ambiente através das vibrações do solo.

Benefícios:
- +1 em Sabedoria (máx. 20).
- Enquanto estiver cego ou de olhos fechados, você possui visão sísmica em 9 m.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-anatomia', 'Especialista em Anatomia', '🫀', 'Pré-requisito: Inteligência ou Sabedoria 13 ou maior

Você estudou criaturas e sabe exatamente onde atingir.

Benefícios:
- Escolha dois tipos de criatura.
- Seus ataques contra esses tipos são críticos com 19–20.
- Ao realizar um acerto crítico, adiciona seu modificador de Inteligência ou Sabedoria ao dano.
- Recebe +2 em testes para recordar informações sobre esses tipos.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ataque-preciso', 'Ataque Preciso', '🎯', 'Você maximiza precisão em condições favoráveis.

Benefícios:
- Quando tiver vantagem em ataques, rola 3 dados em vez de 2.
- Se tiver vantagem, seu crítico ocorre com 19–20.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('valentao', 'Valentão', '👊', 'Você gosta de bater em pessoas mais fracas que você.

Benefícios:
- Sempre que você causar dano a uma criatura com ND menor que metade do seu nível, causa 1d10 de dano extra.
- Se o ND for menor que um quarto do seu nível, causa 2d10 de dano extra.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('afortunado', 'Afortunado', '🎲', 'A sorte parece sorrir para você em momentos aleatórios.

Benefícios:
- Rolagens de d100 envolvendo encontros ou tesouros que afetem você são feitas duas vezes, escolhendo o melhor resultado.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('vicio-apostas', 'Vício em Apostas', '🃏', 'Você vive no risco constante, com resultados imprevisíveis.

Benefícios:
- No início de cada turno, role 1d20.
- Resultado par: +2 em ataques, testes e resistências até o próximo turno.
- Resultado ímpar: –1 nessas rolagens.
- 20: bônus se torna +3.
- 1: penalidade se torna –2.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('multi-tarefa', 'Multitarefa', '🧩', 'Você executa múltiplas atividades simultaneamente.

Benefícios:
- Você pode realizar duas ações no turno, desde que nenhuma seja Ataque ou conjuração de magia.
- Pode usar essa habilidade uma vez por descanso curto.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-alquimia', 'Mestre de Alquimia', '⚗️', 'Você domina a criação e manipulação de compostos alquímicos.

Benefícios:
- Ganha proficiência com kit de alquimia.
- Duração de poções criadas por você é multiplicada pelo bônus de proficiência.
- Pode gastar um uso extra do kit para rolar testes de fabricação com vantagem.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-ferreiro', 'Mestre Ferreiro', '🔨', 'Você domina a criação e modificação de armas e armaduras.

Benefícios:
- Ganha proficiência com ferramentas de ferreiro.
- Itens criados por você possuem +1 em testes relacionados à sua função.
- Você reduz o custo de criação de itens metálicos em 25%.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('capitalista', 'Capitalista', '💰', 'Você domina a arte do comércio e lucro.

Benefícios:
- +1 em Carisma (máx. 20).
- Ao rolagar um teste de Persuasão ou Enganação para obter lucro financeiro, role 1d6 e adicione ao teste.
- Ao administrar um negócio, aumente os ganhos em 25% ou reduza os custos em 25%', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('evasivo', 'Evasivo', '💨', 'Você evita ataques com extrema eficiência.

Benefícios:
- Ao usar Esquiva, recebe bônus de CA igual ao bônus de proficiência.
- Recebe +2 em testes de resistência de Destreza enquanto estiver esquivando.
- Reação: reduz pela metade dano que permitir teste de Destreza para metade.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('explorador-masmorras', 'Explorador de Masmorras', '🏰', 'Você domina ambientes confinados e perigosos.

Benefícios:
- +1 em Sabedoria (máx. 20).
- Você e até 6 aliados não se perdem em masmorras.
- Aliados a até 3 m recebem +2 em Percepção, Investigação e Sobrevivência para detectar armadilhas e caminhos.
- Luz fraca é tratada como luz plena para você.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ossos-de-colosso', 'Ossos de Colosso', '🦴', 'Pré-requisito: Constituição 15 ou maior

Seu corpo resiste como aço, absorvendo impactos pesados.

Benefícios:
- Reduz todo dano físico (Concutente, Perfurante e Cortante) recebido em valor igual ao bonus de proficiencia.', 'constituicao', 15);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('resistencia-sob-pressao', 'Resistência Sob Pressão', '🔥', 'Quanto mais ferido você está, mais difícil é derrubá-lo.

Benefícios:
- Enquanto estiver com menos da metade dos PV, recebe +2 na CA.
- Recebe +2 em testes de resistência.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('equilibrio-perfeito', 'Equilíbrio Perfeito', '⚖️', 'Pré-requisito: Destreza 13 ou maior

Você mantém postura impecável mesmo em situações adversas.

Benefícios:
- Não pode ser derrubado enquanto estiver consciente, a menos que fique incapacitado.
- Recebe +2 na CA contra ataques feitos com vantagem.', 'destreza', 13);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('reserva-arcana', 'Reserva Arcana', '🔋', 'Pré-requisito: Capacidade de conjurar magia e personagem de 5° nível ou superior.

Você possui energia mágica adicional para momentos críticos.

Benefícios:
- Ganha um espaço de magia adicional do menor nível disponível.
- Uma vez por descanso longo, pode recuperar um espaço de magia gasto como ação bônus.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('explosao-controlada', 'Explosão Controlada', '💣', 'Você molda suas magias para evitar aliados.

Benefícios:
- Magias de área podem excluir um número de criaturas igual ao seu bonus de proficiência.
- Criaturas excluídas não sofrem dano nem efeitos.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('conjuracao-economica', 'Conjuração Econômica', '📉', 'Pré-requisito: Capacidade de conjurar magia

Você otimiza o uso de energia mágica, reduzindo desperdícios.

Benefícios:
- Quando uma magia requer componentes verbais e somáticos, você pode ignorar um dos dois à sua escolha.
- Uma vez por descanso longo, ao conjurar uma magia, pode tratar o seu custo em espaços de magia como se fosse de um nível inferior (mínimo 1º nível).', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ancora-arcana', 'Âncora Arcana', '⚓', 'Pré-requisito: Capacidade de conjurar magia com concentração

Você fixa suas magias no tecido da realidade, tornando-as mais difíceis de dissipar.

Benefícios:
- Criaturas têm desvantagem em testes para dissipar ou encerrar suas magias.
- Se sua concentração for quebrada, o efeito da magia persiste até o final do turno atual.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('alcance-flexivel', 'Alcance Flexível', '📏', 'Pré-requisito: Capacidade de conjurar magia

Você manipula o alcance de suas magias com precisão.

Benefícios:
- Uma vez por turno, pode aumentar ou reduzir pela metade o alcance de uma magia.
- Magias de toque podem ser conjuradas a até 3 m.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('retencao-magica', 'Retenção Mágica', '🧠', 'Pré-requisito: Capacidade de conjurar magia

Você segura o fluxo da magia antes de liberá-la.

Benefícios:
- Ao preparar uma ação para conjurar magia, não precisa manter concentração até o gatilho ocorrer.
- Se o gatilho não ocorrer, você não perde o espaço de magia.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('contrafluxo', 'Contrafluxo', '🔄', 'Pré-requisito: Capacidade de conjurar magia

Você manipula energia mágica residual ao seu redor.

Benefícios:
- Reação: quando uma criatura a até 9 m conjurar uma magia que você tenha preparada, você recebe +2 no próximo teste de resistência contra magia até o fim do turno.
- Se passar no teste, pode mover-se 3 m sem provocar ataques de oportunidade.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('estabilidade-ritual', 'Estabilidade Ritual', '📜', 'Pré-requisito: Capacidade de conjurar rituais

Seus rituais são mais seguros e rápidos.

Benefícios:
- Tempo adicional para conjurar rituais é reduzido pela metade.
- Você não pode ser interrompido durante um ritual, a menos que fique incapacitado.', NULL, NULL);
INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('eco-defensivo', 'Eco Defensivo', '🛡️', 'Pré-requisito: Capacidade de conjurar magia

Resquícios mágicos protegem você após conjuração.

Benefícios:
- Após conjurar uma magia de 1º nível ou superior, recebe +1 na CA até o início do próximo turno.
- Se a magia exigir concentração, o bônus aumenta para +2 até o início do seu próximo turno.', NULL, NULL);

-- Segundo talento de demonstração: exercita o bônus "à escolha" (igual
-- raca_atributos), caso que nenhum outro talento acima usa.
INSERT INTO talentos (slug, nome, icone, descricao)
VALUES (
    'aprimoramento-versatil',
    'Aprimoramento Versátil',
    '🎯',
    'Seu treinamento não segue um único caminho — você aprimora a si mesmo onde mais precisa.

Benefícios:
- Aumenta um atributo à sua escolha em +1 (máx. 20).'
);

INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'aprimoramento-versatil'), NULL, 1, 1, 0);

-- Terceiro talento de demonstração: exercita mais de um bônus "fixo" no mesmo
-- talento (dois atributos diferentes, cada um com seu próprio valor).
INSERT INTO talentos (slug, nome, icone, descricao)
VALUES (
    'presenca-marcante',
    'Presença Marcante',
    '👑',
    'Sua palavra pesa e sua calma impõe respeito — poucos sustentam seu olhar por muito tempo.

Benefícios:
- Vantagem em testes de Persuasão e Intimidação contra criaturas que já te viram em combate.'
);

INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES
    ((SELECT id FROM talentos WHERE slug = 'presenca-marcante'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM talentos WHERE slug = 'presenca-marcante'), 'sabedoria', 1, NULL, 1);

-- ===== Seed de demonstração: talentos raciais =====
-- Diferente do talento normal, aqui raça e nível mínimo são sempre obrigatórios
-- (não há pré-requisito de atributo). Só há 'humano' seedado em racas por enquanto,
-- então os dois exemplos abaixo usam essa raça.

INSERT INTO talentos_raciais (slug, nome, icone, descricao, raca_id, nivel_minimo)
VALUES (
    'sangue-de-tatanea',
    'Sangue de Tatânea',
    '🩸',
    'Reservado a quem nasceu sob o teto do templo, esse talento é a marca de quem já sobreviveu ao próprio corpo mais de uma vez.

Benefícios:
- Você ganha resistência a dano de veneno e vantagem em testes de resistência contra doenças.
- Uma vez por descanso longo, pode estabilizar automaticamente ao cair a 0 pontos de vida.',
    (SELECT id FROM racas WHERE slug = 'humano'),
    1
);

-- Bônus de atributo do talento acima: exercita o caso "fixo".
INSERT INTO talento_racial_atributos (talento_racial_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos_raciais WHERE slug = 'sangue-de-tatanea'), 'sabedoria', 1, NULL, 0);

-- Segundo talento racial de demonstração: exercita o bônus "à escolha" e um
-- nível mínimo mais alto, caso que o exemplo acima não usa.
INSERT INTO talentos_raciais (slug, nome, icone, descricao, raca_id, nivel_minimo)
VALUES (
    'instinto-do-templo',
    'Instinto do Templo',
    '🦉',
    'Quem cresce entre os totens do templo aprende a ler seus sinais antes mesmo de entender por quê.

Benefícios:
- Vantagem em testes de resistência contra ser Amedrontado enquanto estiver a até 9 m de uma estrutura do templo.
- Uma vez por descanso longo, pode repetir um teste de Sobrevivência ou Percepção falho.',
    (SELECT id FROM racas WHERE slug = 'humano'),
    5
);

INSERT INTO talento_racial_atributos (talento_racial_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos_raciais WHERE slug = 'instinto-do-templo'), NULL, 1, 1, 0);
