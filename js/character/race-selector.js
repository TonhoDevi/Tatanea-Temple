/**
 * race-selector.js
 * Seletor de raça com busca + exibição automática de habilidades na Aba 3.
 *
 * Depende de:
 *   - RACAS_DATA (js/compendium/data-races.js) já carregado
 *   - autoSave() global do ddt-character.js
 *
 * Uso: incluir APÓS data-races.js e ddt-character.js no HTML.
 */

(function () {
    'use strict';

    // ── Estado ──────────────────────────────────────────────────────
    let selectedRace   = null;   // objeto completo da raça
    let dropdownOpen   = false;
    let filterText     = '';
    let expandedHabs   = new Set();  // índices expandidos
    let tracosOpen     = false;

    // ── Referências de DOM (resolvidas após DOMContentLoaded) ───────
    let wrapEl, triggerEl, arrowEl, dropEl, searchEl, listEl;
    let abilitiesSectionEl;

    // ────────────────────────────────────────────────────────────────
    //  INICIALIZAÇÃO
    // ────────────────────────────────────────────────────────────────
    function init() {
        buildSelectorDOM();
        buildAbilitiesSectionDOM();
        bindEvents();
        renderDropdownOptions('');
        renderAbilities();           // estado vazio inicial
    }

    // ────────────────────────────────────────────────────────────────
    //  CONSTRUIR DOM — SELETOR (substitui o input #raca original)
    // ────────────────────────────────────────────────────────────────
    function buildSelectorDOM() {
        const originalInput = document.getElementById('raca');
        if (!originalInput) return;

        // Mantém o input original com o mesmo ID "raca" — apenas o esconde visualmente.
        // Assim, getCurrentCharacter() continua lendo document.getElementById('raca').value
        // sem nenhuma alteração no ddt-character.js.
        originalInput.style.display  = 'none';
        originalInput.style.position = 'absolute';
        originalInput.style.opacity  = '0';
        originalInput.style.pointerEvents = 'none';
        originalInput.tabIndex = -1;
        // NÃO muda o ID — permanece "raca"

        // Wrapper
        const parent = originalInput.parentElement;
        parent.style.position = 'relative';

        wrapEl = document.createElement('div');
        wrapEl.className = 'race-selector-wrap';
        wrapEl.id = 'raceSelectorWrap';

        triggerEl = document.createElement('input');
        triggerEl.type = 'text';
        triggerEl.className = 'race-search-input';
        triggerEl.id = 'raca-display';   // ID diferente — apenas visual
        triggerEl.placeholder = 'Escolha a Raça...';
        triggerEl.autocomplete = 'off';
        triggerEl.readOnly = true;

        arrowEl = document.createElement('span');
        arrowEl.className = 'race-selector-arrow';
        arrowEl.textContent = '▾';

        // Dropdown
        dropEl = document.createElement('div');
        dropEl.className = 'race-dropdown hidden';
        dropEl.innerHTML = `
            <div class="race-dropdown-search">
                <input type="text" id="raceDropdownSearch" placeholder="🔍 Buscar raça..." autocomplete="off">
            </div>
            <div class="race-options-list" id="raceOptionsList"></div>
        `;

        wrapEl.appendChild(triggerEl);
        wrapEl.appendChild(arrowEl);
        wrapEl.appendChild(dropEl);

        // Insere o wrapper logo antes do input oculto
        parent.insertBefore(wrapEl, originalInput);

        searchEl = document.getElementById('raceDropdownSearch');
        listEl   = document.getElementById('raceOptionsList');
    }

    // ────────────────────────────────────────────────────────────────
    //  CONSTRUIR DOM — SEÇÃO DE HABILIDADES NA ABA 3
    // ────────────────────────────────────────────────────────────────
    function buildAbilitiesSectionDOM() {
        // Localiza a aba 3 (Habilidades)
        const tab3 = document.getElementById('tab3');
        if (!tab3) return;

        // Cria container — insere no TOPO da aba, antes de tudo
        abilitiesSectionEl = document.createElement('div');
        abilitiesSectionEl.className = 'section race-abilities-section';
        abilitiesSectionEl.id = 'raceAbilitiesSection';
        abilitiesSectionEl.innerHTML = buildAbilitiesSectionHTML();

        tab3.insertBefore(abilitiesSectionEl, tab3.firstChild);
    }

    // ────────────────────────────────────────────────────────────────
    //  HTML DA SEÇÃO DE HABILIDADES
    // ────────────────────────────────────────────────────────────────
    function buildAbilitiesSectionHTML() {
        if (!selectedRace) {
            return `
                <div class="section-title">⚔ Habilidades de Raça</div>
                <div class="race-no-selection">
                    <span class="race-no-selection-icon">🧬</span>
                    <span>Selecione uma raça na aba <strong>Principal</strong> para ver as habilidades</span>
                </div>
            `;
        }

        const r = selectedRace;
        const catLabel = { global:'Global', tribal:'Tribal', mistica:'Mística', sobrenatural:'Sobrenatural' }[r.categoria] || r.categoria;

        // Habilidades expandíveis
        const habsHTML = r.habilidades.map((h, i) => {
            const isExp = expandedHabs.has(i);
            return `
                <div class="race-habilidade-card ${isExp ? 'expanded' : ''}" data-habidx="${i}">
                    <div class="race-habilidade-header" onclick="window._raceToggleHab(${i})">
                        <span class="race-habilidade-name">✦ ${h.nome}</span>
                        <button class="race-habilidade-toggle" tabindex="-1">▼</button>
                    </div>
                    <div class="race-habilidade-body">
                        <p class="race-habilidade-desc">${h.descricao}</p>
                    </div>
                </div>
            `;
        }).join('');

        // Traços resumidos (colapsável)
        const tracosHTML = r.tracos.map(t => `
            <li class="race-traco-item">${t}</li>
        `).join('');

        return `
            <div class="section-title">⚔ Habilidades de Raça</div>

            <div class="race-abilities-header">
                <div class="race-abilities-title-group">
                    <span class="race-abilities-racename">${r.nome}</span>
                    <span class="race-abilities-catbadge ${r.categoria}">${catLabel}</span>
                </div>
                <div class="race-abilities-meta">
                    <span class="race-meta-chip">📏 ${capitalize(r.tamanho)}</span>
                    <span class="race-meta-chip">👣 ${r.deslocamento}</span>
                    <span class="race-meta-chip">⚔ ${r.habilidades.length} habilidades</span>
                </div>
            </div>

            <div class="race-habilidades-list">
                ${habsHTML}
            </div>

            <div class="race-tracos-section">
                <button class="race-tracos-toggle-btn" onclick="window._raceToggleTracos()">
                    <span id="raceTtoggleIcon">${tracosOpen ? '▲' : '▼'}</span>
                    ${tracosOpen ? 'Ocultar' : 'Ver'} Traços Raciais (${r.tracos.length})
                </button>
                <ul class="race-tracos-list ${tracosOpen ? 'open' : ''}" id="raceTracosList">
                    ${tracosHTML}
                </ul>
            </div>
        `;
    }

    // ────────────────────────────────────────────────────────────────
    //  RENDERIZAR LISTA DO DROPDOWN
    // ────────────────────────────────────────────────────────────────
    function renderDropdownOptions(query) {
        if (!listEl) return;

        const q = query.toLowerCase().trim();
        const filtered = (typeof RACAS_DATA !== 'undefined' ? RACAS_DATA : [])
            .filter(r => !q || r.nome.toLowerCase().includes(q) || r.categoria.toLowerCase().includes(q));

        if (!filtered.length) {
            listEl.innerHTML = '<div class="race-option-empty">Nenhuma raça encontrada</div>';
            return;
        }

        const catLabel = { global:'Global', tribal:'Tribal', mistica:'Mística', sobrenatural:'Sobrenatural' };

        listEl.innerHTML = filtered.map((r, i) => `
            <div class="race-option ${selectedRace && selectedRace.nome === r.nome ? 'selected' : ''}"
                 data-raceidx="${RACAS_DATA.indexOf(r)}"
                 onclick="window._raceSelectByIdx(${RACAS_DATA.indexOf(r)})">
                <span class="race-option-name">${r.nome}</span>
                <span class="race-option-cat ${r.categoria}">${catLabel[r.categoria] || r.categoria}</span>
            </div>
        `).join('');
    }

    // ────────────────────────────────────────────────────────────────
    //  RENDERIZAR SEÇÃO DE HABILIDADES
    // ────────────────────────────────────────────────────────────────
    function renderAbilities() {
        if (!abilitiesSectionEl) return;
        abilitiesSectionEl.innerHTML = buildAbilitiesSectionHTML();
    }

    // ────────────────────────────────────────────────────────────────
    //  SELECIONAR RAÇA
    // ────────────────────────────────────────────────────────────────
    function selectRace(raceObj) {
        selectedRace = raceObj;
        expandedHabs.clear();
        tracosOpen   = false;

        // Atualiza o display visual
        if (triggerEl) triggerEl.value = raceObj ? raceObj.nome : '';

        // Atualiza o input ORIGINAL #raca (ainda oculto) — lido por getCurrentCharacter()
        const racaInput = document.getElementById('raca');
        if (racaInput) {
            racaInput.value = raceObj ? raceObj.nome : '';
        }

        closeDropdown();
        renderDropdownOptions(filterText);
        renderAbilities();

        if (typeof autoSave === 'function') autoSave();
    }

    // ────────────────────────────────────────────────────────────────
    //  ABRIR / FECHAR DROPDOWN
    // ────────────────────────────────────────────────────────────────
    function openDropdown() {
        if (!dropEl) return;
        dropdownOpen = true;
        dropEl.classList.remove('hidden');
        wrapEl.classList.add('open');
        filterText = '';
        if (searchEl) { searchEl.value = ''; searchEl.focus(); }
        renderDropdownOptions('');
    }

    function closeDropdown() {
        if (!dropEl) return;
        dropdownOpen = false;
        dropEl.classList.add('hidden');
        if (wrapEl) wrapEl.classList.remove('open');
    }

    // ────────────────────────────────────────────────────────────────
    //  BINDING DE EVENTOS
    // ────────────────────────────────────────────────────────────────
    function bindEvents() {
        // Abre dropdown ao clicar no trigger
        if (triggerEl) {
            triggerEl.addEventListener('click', (e) => {
                e.stopPropagation();
                dropdownOpen ? closeDropdown() : openDropdown();
            });
        }

        // Busca no dropdown
        document.addEventListener('input', (e) => {
            if (e.target && e.target.id === 'raceDropdownSearch') {
                filterText = e.target.value;
                renderDropdownOptions(filterText);
            }
        });

        // Fechar ao clicar fora
        document.addEventListener('click', (e) => {
            if (wrapEl && !wrapEl.contains(e.target)) closeDropdown();
        });

        // Fechar com ESC
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && dropdownOpen) closeDropdown();
        });
    }

    // ────────────────────────────────────────────────────────────────
    //  API GLOBAL (chamada pelos onclick inline do HTML gerado)
    // ────────────────────────────────────────────────────────────────
    window._raceSelectByIdx = function (idx) {
        const r = (typeof RACAS_DATA !== 'undefined') ? RACAS_DATA[idx] : null;
        if (r) selectRace(r);
    };

    window._raceToggleHab = function (idx) {
        if (expandedHabs.has(idx)) expandedHabs.delete(idx);
        else expandedHabs.add(idx);
        renderAbilities();
    };

    window._raceToggleTracos = function () {
        tracosOpen = !tracosOpen;
        renderAbilities();
    };

    // ────────────────────────────────────────────────────────────────
    //  INTEGRAÇÃO COM getCurrentCharacter / loadCharacterData
    // ────────────────────────────────────────────────────────────────

    // Patch: ao salvar, getCurrentCharacter já lê #raca-hidden (mesmo valor)
    // Patch: ao carregar, precisamos restaurar selectedRace a partir do nome salvo
    function patchLoadCharacter() {
        const originalLoad = window.loadCharacterData;
        if (!originalLoad) return;

        window.loadCharacterData = function (char) {
            originalLoad(char);

            // Restaura a raça selecionada pelo nome
            const racaNome = char && char.raca ? char.raca.trim() : '';
            if (racaNome && typeof RACAS_DATA !== 'undefined') {
                const found = RACAS_DATA.find(r => r.nome.toLowerCase() === racaNome.toLowerCase());
                if (found) {
                    selectedRace = found;
                    expandedHabs.clear();
                    tracosOpen = false;
                    if (triggerEl) triggerEl.value = found.nome;
                    renderDropdownOptions('');
                    renderAbilities();
                }
            }
        };
    }

    // Patch: getCurrentCharacter deve continuar lendo "raca" mesmo com o input oculto
    function patchGetCurrentCharacter() {
        const originalGet = window.getCurrentCharacter;
        if (!originalGet) return;

        window.getCurrentCharacter = function () {
            const data = originalGet();
            // Garante que o campo raca está correto (input oculto tem ID raca-hidden)
            data.raca = selectedRace ? selectedRace.nome : '';
            return data;
        };
    }

    // ────────────────────────────────────────────────────────────────
    //  BOOT
    // ────────────────────────────────────────────────────────────────
    function capitalize(s) {
        return s ? s.charAt(0).toUpperCase() + s.slice(1) : '';
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            init();
            patchLoadCharacter();
            patchGetCurrentCharacter();
        });
    } else {
        // DOMContentLoaded já disparou
        init();
        patchLoadCharacter();
        patchGetCurrentCharacter();
    }

})();