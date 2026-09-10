<template>
  <div>
    <div class="fc-box">
      <div class="fc-box-title">Habilidades de classe</div>
      <div v-for="(h, i) in ficha.habilidades" :key="i" class="fc-list-row-vertical">
        <input type="text" v-model="h.nome" placeholder="Nome da habilidade" @input="agendarSalvar" />
        <textarea v-model="h.descricao" placeholder="Descrição" @input="agendarSalvar"></textarea>
        <button class="fc-btn-add fc-btn-remove-wide" @click="removerItem(ficha.habilidades, i)">× Remover</button>
      </div>
      <button class="fc-btn-add" @click="adicionarHabilidade">+ Adicionar habilidade de classe</button>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Habilidades de raça</div>
      <p v-if="!ficha.racaId" class="fc-hint">Selecione uma raça na aba Características para trazer as habilidades raciais aqui.</p>
      <p v-else-if="!habilidadesRaca.length" class="fc-hint">Essa raça não tem habilidades especiais cadastradas no compêndio.</p>
      <div v-else class="fc-hab-raca-lista">
        <div class="fc-hab-raca-item" v-for="(h, i) in habilidadesRaca" :key="i">
          <div class="fc-hab-raca-header">
            <span class="fc-hab-raca-nome">{{ h.nome }}</span>
            <span class="fc-hab-raca-tipo">{{ tipoHabilidadeLabel(h.tipo) }}</span>
          </div>
          <p class="fc-hab-raca-descricao">{{ h.descricao }}</p>
        </div>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Talentos</div>
      <div v-for="t in ficha.talentos" :key="t.talentoId" class="fc-talento-card">
        <div class="fc-talento-header">
          <span class="fc-talento-nome">{{ t.nome }}</span>
          <button class="fc-btn-remove" @click="removerTalentoDaFicha(t.talentoId)">×</button>
        </div>
        <div v-if="atributosFixos(t.atributos).length" class="fc-talento-bonus-row">
          <span v-for="(a, i) in atributosFixos(t.atributos)" :key="i" class="fc-talento-bonus">
            +{{ a.valor }} {{ atributoNome(a.atributo) }}
          </span>
        </div>

        <template v-for="(a, ai) in atributosEscolha(t.atributos)" :key="'esc-' + ai">
          <div v-if="slotsEscolhidos('talento', t.talentoId, ai, a.quantidadeEscolhas).length" class="fc-talento-bonus-row">
            <button
                v-for="n in slotsEscolhidos('talento', t.talentoId, ai, a.quantidadeEscolhas)"
                :key="n"
                type="button"
                class="fc-talento-bonus fc-talento-bonus-clicavel"
                title="Clique para mudar a escolha"
                @click="editandoEscolha[chaveEscolha('talento', t.talentoId, ai, n)] = true"
            >
              +{{ a.valor }} {{ atributoNome(escolhasAtributo[chaveEscolha('talento', t.talentoId, ai, n)]) }}
            </button>
          </div>

          <div v-if="slotsPendentes('talento', t.talentoId, ai, a.quantidadeEscolhas).length" class="fc-talento-escolha">
            <p class="fc-talento-escolha-titulo">
              Escolha {{ slotsPendentes('talento', t.talentoId, ai, a.quantidadeEscolhas).length }}
              atributo{{ slotsPendentes('talento', t.talentoId, ai, a.quantidadeEscolhas).length > 1 ? 's' : '' }}
              para +{{ a.valor }}{{ a.quantidadeEscolhas > 1 ? ' cada' : '' }}
            </p>
            <div class="fc-talento-escolha-selects">
              <label class="fc-escolha-slot" v-for="n in slotsPendentes('talento', t.talentoId, ai, a.quantidadeEscolhas)" :key="n">
                <span class="fc-escolha-slot-num">{{ n }}º</span>
                <select
                    v-model="escolhasAtributo[chaveEscolha('talento', t.talentoId, ai, n)]"
                    class="fc-select"
                    @change="editandoEscolha[chaveEscolha('talento', t.talentoId, ai, n)] = false"
                >
                  <option value="">Selecione...</option>
                  <option
                      v-for="attr in opcoesParaSlot('talento', t.talentoId, ai, a.quantidadeEscolhas, n)"
                      :key="attr.chave"
                      :value="attr.chave"
                  >{{ attr.nome }}</option>
                </select>
              </label>
            </div>
            <p class="fc-hint">Provisório — a escolha ainda não é salva com a ficha.</p>
          </div>
        </template>

        <p v-if="t.descricao" class="fc-talento-descricao">{{ t.descricao }}</p>
      </div>
      <p v-if="!ficha.talentos.length" class="fc-hint">Nenhum talento ainda.</p>

      <div class="fc-talento-add">
        <select v-model="talentoSelecionado" class="fc-select">
          <option value="">Escolha um talento...</option>
          <option v-for="t in talentosDisponiveis" :key="t.id" :value="t.id">{{ t.nome }}</option>
        </select>
        <button class="fc-btn-add" @click="adicionarTalentoNaFicha">+ Adicionar</button>
      </div>
      <p v-if="erroTalento" class="fc-hint fc-hint-erro">{{ erroTalento }}</p>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, habilidadesRaca, talentosDisponiveis, talentoSelecionado, erroTalento,
  agendarSalvar, removerItem, adicionarHabilidade,
  adicionarTalentoNaFicha, removerTalentoDaFicha,
  atributosFixos, atributosEscolha, atributoNome, tipoHabilidadeLabel,
  escolhasAtributo, editandoEscolha, chaveEscolha, opcoesParaSlot,
  slotsEscolhidos, slotsPendentes,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-list-row-vertical {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding-bottom: 10px;
  border-bottom: 1px dashed color-mix(in srgb, var(--accent-title) 60%, transparent);
}

.fc-hab-raca-lista {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.fc-hab-raca-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 10px 0;
  border-bottom: 1px dashed color-mix(in srgb, var(--accent-title) 40%, transparent);
}

.fc-hab-raca-item:last-child {
  border-bottom: none;
}

.fc-hab-raca-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.fc-hab-raca-nome {
  font-weight: 600;
}

.fc-hab-raca-tipo {
  flex: none;
  font-family: 'Cinzel', serif;
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  padding: 3px 8px;
  border: 1px solid var(--tribal-gold);
  color: var(--tribal-yellow);
}

.fc-hab-raca-descricao {
  margin: 0;
  font-size: 14px;
  line-height: 1.6;
  color: var(--pale-green);
}

.fc-talento-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px 0;
  border-bottom: 1px dashed color-mix(in srgb, var(--accent-title) 40%, transparent);
}

.fc-talento-header {
  display: flex;
  align-items: center;
  gap: 10px;
}

.fc-talento-nome {
  flex: 1;
  min-width: 0;
  font-weight: 600;
}

.fc-talento-bonus-row {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.fc-talento-bonus {
  display: inline-block;
  padding: 4px 10px;
  border: 1px solid var(--accent-title);
  border-radius: 3px;
  background: color-mix(in srgb, var(--accent-title) 18%, transparent);
  font-family: 'Cinzel', serif;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: color-mix(in srgb, var(--accent-title) 60%, white);
}

.fc-talento-bonus-clicavel {
  cursor: pointer;
  transition: background-color 0.15s ease, border-color 0.15s ease;
}

.fc-talento-bonus-clicavel:hover {
  background: color-mix(in srgb, var(--accent-title) 30%, transparent);
  border-color: color-mix(in srgb, var(--accent-title) 60%, white);
}

.fc-talento-escolha {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px 12px;
  border: 1px dashed var(--tribal-gold);
  background: color-mix(in srgb, var(--accent-title) 10%, transparent);
}

.fc-talento-escolha-titulo {
  margin: 0;
  font-family: 'Cinzel', serif;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--tribal-gold);
}

.fc-talento-escolha-selects {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.fc-escolha-slot {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1 1 160px;
}

.fc-escolha-slot-num {
  flex: none;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 1px solid var(--tribal-gold);
  background: var(--jungle-void);
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 11px;
  color: var(--tribal-yellow);
}

.fc-escolha-slot .fc-select {
  flex: 1;
  min-width: 0;
}

.fc-talento-descricao {
  margin: 0;
  padding: 10px 12px;
  background: var(--jungle-darkest);
  border-left: 3px solid var(--jungle-green);
  font-size: 14px;
  line-height: 1.6;
  color: var(--bone);
  white-space: pre-line;
}

.fc-talento-add {
  display: flex;
  gap: 8px;
  margin-top: 10px;
}

.fc-talento-add .fc-select {
  flex: 1;
}

.fc-hint-erro {
  color: var(--tribal-red);
}
</style>