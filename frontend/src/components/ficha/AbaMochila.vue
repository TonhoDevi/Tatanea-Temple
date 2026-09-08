<template>
  <div>
    <div class="fc-box">
      <div class="fc-box-title">Moedas</div>
      <div class="fc-coin-grid">
        <div class="fc-coin-card" v-for="moeda in MOEDAS" :key="moeda.chave">
          <div class="fc-coin-name-row"><span class="fc-coin-name">{{ moeda.label }}</span></div>
          <div class="fc-coin-icon-row">
            <span class="fc-coin-hept" :class="`fc-coin-hept-${moeda.chave.toLowerCase()}`">
              <span class="fc-coin-glyph">{{ moeda.glifo }}</span>
            </span>
          </div>
          <div class="fc-coin-stepper">
            <button
                type="button"
                class="fc-coin-step-btn"
                @click="ficha[moeda.campo] = Math.max(0, (ficha[moeda.campo] || 0) - 1); agendarSalvar()"
            >−</button>
            <span class="fc-coin-value">{{ ficha[moeda.campo] || 0 }}</span>
            <button
                type="button"
                class="fc-coin-step-btn"
                @click="ficha[moeda.campo] = (ficha[moeda.campo] || 0) + 1; agendarSalvar()"
            >+</button>
          </div>
        </div>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-box-title">Inventário</div>
      <div v-for="(item, i) in ficha.inventario" :key="i" class="fc-list-row">
        <input type="text" v-model="item.nome" placeholder="Nome" @input="agendarSalvar" />
        <input type="number" v-model.number="item.quantidade" placeholder="Qtd" class="fc-col-tiny" @input="agendarSalvar" />
        <input type="number" v-model.number="item.peso" placeholder="Peso" class="fc-col-tiny" @input="agendarSalvar" />
        <input type="text" v-model="item.descricao" placeholder="Descrição" @input="agendarSalvar" />
        <button class="fc-btn-remove" @click="removerItem(ficha.inventario, i)">×</button>
      </div>
      <button class="fc-btn-add" @click="adicionarInventario">+ Adicionar item</button>
    </div>

    <div class="fc-box">
      <div class="fc-tesouro-heading">
        <div class="fc-box-title" style="margin: 0">Tesouro</div>
        <span class="fc-mini-label">{{ tesouro.length }} itens</span>
      </div>
      <p class="fc-hint">Provisório — ainda só neste navegador, não é salvo com a ficha. Valores em peças de bronze.</p>
      <div v-for="(b, i) in tesouro" :key="b.id" class="fc-list-row">
        <input type="number" v-model.number="b.quantidade" placeholder="Qtd" class="fc-col-tiny" min="1" />
        <input type="text" v-model="b.nome" placeholder="Nome" />
        <input type="number" v-model.number="b.valorUnitario" placeholder="Valor" class="fc-col-tiny" min="0" />
        <input type="text" v-model="b.descricao" placeholder="Descrição" />
        <button class="fc-btn-remove" @click="removerTesouro(i)">×</button>
      </div>
      <button class="fc-btn-add" @click="adicionarTesouro">+ Adicionar item de tesouro</button>
      <div class="fc-tesouro-footer">
        <span>Soma do tesouro</span>
        <span class="fc-tesouro-footer-total">{{ somaTesouro }} PB</span>
      </div>
    </div>

    <div class="fc-box">
      <div class="fc-tesouro-heading">
        <div class="fc-box-title" style="margin: 0">Itens mágicos</div>
        <label class="fc-sync-limite">
          <span class="fc-mini-label">Sincronizados {{ contarSincronizados() }}/</span>
          <input type="number" class="fc-mini-number" v-model.number="limiteSincronizados" min="1" />
        </label>
      </div>
      <p class="fc-hint">Sincronização — provisório, ainda só neste navegador, não é salvo com a ficha.</p>
      <div v-for="(item, i) in ficha.itensMagicos" :key="i" class="fc-list-row">
        <button
            type="button"
            class="fc-sync-mark"
            :class="{ active: itemMagicoSync[i] }"
            @click="alternarSincronizado(i)"
            title="Sincronizado"
        >
          <span v-if="itemMagicoSync[i]">✓</span>
        </button>
        <input type="text" v-model="item.nome" placeholder="Nome" @input="agendarSalvar" />
        <input type="text" v-model="item.descricao" placeholder="Descrição" @input="agendarSalvar" />
        <button class="fc-btn-remove" @click="removerItemMagico(i)">×</button>
      </div>
      <button class="fc-btn-add" @click="adicionarItemMagico">+ Adicionar item mágico</button>
    </div>
  </div>
</template>

<script setup>
import { useFichaPersonagem } from '../../composables/useFichaPersonagem';

const {
  ficha, MOEDAS, tesouro, somaTesouro, itemMagicoSync, limiteSincronizados,
  agendarSalvar, removerItem, adicionarInventario,
  adicionarTesouro, removerTesouro,
  contarSincronizados, alternarSincronizado,
  adicionarItemMagico, removerItemMagico,
} = useFichaPersonagem();
</script>

<style scoped>
.fc-coin-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 6px;
}

.fc-coin-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px;
  border: 1px solid var(--jungle-green);
  background: var(--jungle-void);
  min-width: 0;
}

.fc-coin-name-row {
  border-bottom: 1px solid var(--jungle-green);
  padding-bottom: 6px;
}

.fc-coin-name {
  font-family: 'Cinzel', serif;
  font-weight: 700;
  font-size: 16px;
  letter-spacing: 0.06em;
  color: var(--pale-green);
}

.fc-coin-icon-row {
  display: flex;
  justify-content: center;
  padding: 4px 0;
}

.fc-coin-hept {
  flex: none;
  width: 46px;
  height: 46px;
  display: flex;
  align-items: center;
  justify-content: center;
  clip-path: polygon(30% 0%, 70% 0%, 100% 30%, 100% 70%, 70% 100%, 30% 100%, 0% 70%, 0% 30%);
}

.fc-coin-glyph {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  color: var(--jungle-void);
}

.fc-coin-hept-pc {
  background: #b5722e;
}

.fc-coin-hept-pp {
  background: #c7cdd1;
}

.fc-coin-hept-pe {
  background: #b9c98a;
}

.fc-coin-hept-po {
  background: var(--tribal-yellow);
}

.fc-coin-hept-pl {
  background: #e3e9ee;
}

.fc-coin-stepper {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.fc-coin-step-btn {
  width: 26px;
  height: 26px;
  flex: none;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--jungle-void);
  border: 1px solid var(--jungle-green);
  color: var(--pale-green);
  font-size: 15px;
  cursor: pointer;
}

.fc-coin-step-btn:hover {
  border-color: var(--tribal-gold);
  color: var(--tribal-gold);
}

.fc-coin-value {
  min-width: 40px;
  text-align: center;
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-weight: 700;
  font-size: 18px;
  color: var(--tribal-yellow);
  background: var(--jungle-void);
  border: 1px solid var(--jungle-moss);
  padding: 4px 6px;
}

.fc-tesouro-heading {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  flex-wrap: wrap;
  gap: 6px;
}

.fc-sync-limite {
  display: flex;
  align-items: center;
  gap: 6px;
}

.fc-sync-limite .fc-mini-number {
  width: 46px;
}

.fc-tesouro-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 12px;
  border: 1px solid var(--jungle-green);
  background: #123020;
  font-family: 'Cinzel', serif;
  font-size: 11px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--pale-green);
}

.fc-tesouro-footer-total {
  font-family: 'Cinzel Decorative', 'Cinzel', serif;
  font-size: 16px;
  letter-spacing: normal;
  text-transform: none;
  color: var(--tribal-yellow);
}

.fc-sync-mark {
  flex: none;
  width: 34px;
  height: 35px;
  box-sizing: border-box;
  background: var(--jungle-void);
  border: 1px solid var(--jungle-green);
  color: var(--bone);
  font-size: 15px;
  font-weight: 700;
  line-height: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background-color 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.fc-sync-mark.active {
  background: #2a75d3;
  border-color: #2a75d3;
  box-shadow: 0 0 8px 2px rgba(42, 117, 211, 0.65);
}
</style>