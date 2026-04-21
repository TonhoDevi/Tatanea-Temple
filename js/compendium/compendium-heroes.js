// ============================================
// COMPÊNDIO DE HERÓIS — SCRIPT
// Arquivo: js/compendium/compendium-heroes.js
// ============================================

'use strict';

const STATE_HEROES = {
    categoria: '',
    search: '',
    sort: 'default',
    view: 'grid',
};

// ── Init ─────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    if (!document.getElementById('heroesGrid')) return;
    preencherContadoresHerois();
    bindFiltrosHerois();
    renderHerois();
});

// ── Contadores ───────────────────────────────
function preencherContadoresHerois() {
    const total = HEROES_DATA.length;
    const porCat = {};
    HEROES_DATA.forEach(h => { porCat[h.categoria] = (porCat[h.categoria] || 0) + 1; });

    setElH('totalHerois', total);
    Object.keys(HERO_CATEGORIAS).forEach(cat => {
        setElH(`count-${cat}`, porCat[cat] || 0);
        setElH(`tab-count-${cat}`, porCat[cat] || 0);
    });
    setElH('tab-count-all', total);
}

// ── Binding ──────────────────────────────────
function bindFiltrosHerois() {
    document.getElementById('searchHero')?.addEventListener('input', e => {
        STATE_HEROES.search = e.target.value.trim();
        renderHerois();
    });

    document.getElementById('sortHeroes')?.addEventListener('change', e => {
        STATE_HEROES.sort = e.target.value;
        renderHerois();
    });

    document.querySelectorAll('.cat-tab').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.cat-tab').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            STATE_HEROES.categoria = btn.dataset.cat;
            renderHerois();
        });
    });

    // Modal: fechar ESC e clique fora
    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeHeroModal(); });
    document.getElementById('heroModal')?.addEventListener('click', e => {
        if (e.target === document.getElementById('heroModal')) closeHeroModal();
    });
}

// ── Filtrar ──────────────────────────────────
function getFilteredHerois() {
    let list = [...HEROES_DATA];

    if (STATE_HEROES.categoria) {
        list = list.filter(h => h.categoria === STATE_HEROES.categoria);
    }

    if (STATE_HEROES.search) {
        const q = STATE_HEROES.search.toLowerCase();
        list = list.filter(h =>
            h.nome.toLowerCase().includes(q) ||
            h.alcunha.toLowerCase().includes(q) ||
            h.classe.toLowerCase().includes(q) ||
            h.especie.toLowerCase().includes(q) ||
            h.historia.toLowerCase().includes(q)
        );
    }

    switch (STATE_HEROES.sort) {
        case 'az': list.sort((a, b) => a.nome.localeCompare(b.nome, 'pt')); break;
        case 'za': list.sort((a, b) => b.nome.localeCompare(a.nome, 'pt')); break;
    }

    return list;
}

// ── Render ───────────────────────────────────
function renderHerois() {
    const grid = document.getElementById('heroesGrid');
    const count = document.getElementById('heroesCount');
    if (!grid) return;

    const lista = getFilteredHerois();

    if (count) count.innerHTML = `Mostrando <strong>${lista.length}</strong> de <strong>${HEROES_DATA.length}</strong> heróis`;

    grid.innerHTML = '';
    grid.classList.toggle('list-view', STATE_HEROES.view === 'list');

    if (!lista.length) {
        grid.innerHTML = `
            <div class="no-results" style="grid-column:1/-1">
                <span class="no-results-icon">🗡️</span>
                Nenhum herói encontrado para os filtros selecionados.
            </div>`;
        return;
    }

    lista.forEach((heroi, i) => {
        const idx = HEROES_DATA.indexOf(heroi);
        const cat = HERO_CATEGORIAS[heroi.categoria] || { label: heroi.categoria, cor: '#c9a96e', bg: 'rgba(180,130,40,.15)', borda: 'rgba(200,160,60,.3)' };
        const prime = heroi.versoes.find(v => v.id === heroi.versaoAtual) || heroi.versoes[heroi.versoes.length - 1];

        const card = document.createElement('div');
        card.className = 'hero-card';
        card.dataset.cat = heroi.categoria;
        card.style.animationDelay = `${Math.min(i * 0.05, 0.5)}s`;
        card.setAttribute('tabindex', '0');
        card.setAttribute('role', 'button');
        card.setAttribute('aria-label', `Ver herói ${heroi.nome}`);

        card.innerHTML = `
            <div class="hero-card-img-wrap">
                ${heroi.imagem
                ? `<img src="${heroi.imagem}" alt="${heroi.nome}" onerror="this.parentElement.innerHTML='<span class=hero-card-fallback>${heroi.icone}</span>'">`
                : `<span class="hero-card-fallback">${heroi.icone}</span>`
            }
                <div class="hero-card-overlay"></div>
                <span class="hero-card-badge" style="color:${cat.cor};background:${cat.bg};border:1px solid ${cat.borda}">${cat.label}</span>
            </div>
            <div class="hero-card-body">
                <h3 class="hero-card-nome">${heroi.nome}</h3>
                <p class="hero-card-alcunha">"${heroi.alcunha}"</p>
                <div class="hero-card-stats">
                    <span class="hstat-chip">⚔️ ${heroi.classe}</span>
                    <span class="hstat-chip">🧬 ${heroi.especie}</span>
                    <span class="hstat-chip">Nv.${heroi.nivel}</span>
                </div>
                <p class="hero-card-desc">${heroi.historia.substring(0, 120)}…</p>
                <div class="hero-card-versions">
                    ${heroi.versoes.map(v => `<span class="hero-version-pip ${v.id === heroi.versaoAtual ? 'active' : ''}" title="${v.nome}">${v.icone}</span>`).join('')}
                </div>
                <div class="hero-card-footer">
                    <button class="hero-btn-details">Ver Herói →</button>
                    <a class="hero-btn-page" href="html/heroes/hero-page.html?id=${heroi.id}" onclick="event.stopPropagation()">Página Completa ↗</a>
                </div>
            </div>`;

        card.addEventListener('click', () => showHeroModal(idx));
        card.addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); showHeroModal(idx); } });
        grid.appendChild(card);
    });
}

// ── Toggle view ──────────────────────────────
function setHeroView(mode) {
    STATE_HEROES.view = mode;
    document.getElementById('viewHeroGrid')?.classList.toggle('active', mode === 'grid');
    document.getElementById('viewHeroList')?.classList.toggle('active', mode === 'list');
    renderHerois();
}

// ── Modal ────────────────────────────────────
function showHeroModal(index) {
    const heroi = HEROES_DATA[index];
    if (!heroi) return;
    const modal = document.getElementById('heroModal');
    const cat = HERO_CATEGORIAS[heroi.categoria] || { label: heroi.categoria, cor: '#c9a96e', bg: 'rgba(180,130,40,.15)', borda: 'rgba(200,160,60,.3)' };
    const prime = heroi.versoes.find(v => v.id === heroi.versaoAtual) || heroi.versoes[heroi.versoes.length - 1];

    // Photo/icon
    const imgEl = document.getElementById('modalHeroImg');
    if (imgEl) {
        if (heroi.imagem) {
            imgEl.innerHTML = `<img src="${heroi.imagem}" alt="${heroi.nome}" style="width:100%;height:100%;object-fit:cover;" onerror="this.parentElement.innerHTML='<span style=font-size:5rem;line-height:1>${heroi.icone}</span>'">`;
        } else {
            imgEl.innerHTML = `<span style="font-size:5rem;line-height:1">${heroi.icone}</span>`;
        }
    }

    setElH('modalHeroNome', heroi.nome);
    setElH('modalHeroAlcunha', `"${heroi.alcunha}"`);

    const badgeEl = document.getElementById('modalHeroBadge');
    if (badgeEl) {
        badgeEl.textContent = cat.label;
        badgeEl.style.cssText = `color:${cat.cor};background:${cat.bg};border:1px solid ${cat.borda}`;
    }

    setElH('mqsClasse', heroi.classe);
    setElH('mqsEspecie', heroi.especie);
    setElH('mqsNivel', `Nível ${heroi.nivel}`);
    setElH('mqsPlano', heroi.planoDeOrigem);
    setElH('mqsTempo', heroi.tempo);
    setElH('mqsVersoes', `${heroi.versoes.length} versões`);

    setElH('modalHeroDesc', heroi.historia.substring(0, 300) + '…');

    // Versões no modal
    const versoesEl = document.getElementById('modalVersoes');
    if (versoesEl) {
        versoesEl.innerHTML = heroi.versoes.map(v => `
            <div class="modal-versao-pill">
                <span>${v.icone}</span>
                <span>${v.nome}</span>
            </div>`).join('');
    }

    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeHeroModal() {
    document.getElementById('heroModal')?.classList.remove('active');
    document.body.style.overflow = '';
}

// ── Utilitários ──────────────────────────────
function setElH(id, text) {
    const el = document.getElementById(id);
    if (el) el.textContent = text;
}