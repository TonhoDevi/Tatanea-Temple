function toggleNavbar() {
    document.querySelector('.navbar-menu').classList.toggle('active');
}

/* ── SISTEMA DE TABS PRINCIPAL ── */
function switchTab(id) {
    // Desativa todos
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));

    // Ativa o alvo
    const pane = document.getElementById('tab-' + id);
    if (pane) pane.classList.add('active');

    // Ativa o botão correspondente
    document.querySelectorAll('.tab-btn').forEach(b => {
        if (b.getAttribute('onclick')?.includes(`'${id}'`)) b.classList.add('active');
    });

    // Scroll para o topo do conteúdo
    window.scrollTo({ top: document.querySelector('.tabs-wrapper').offsetTop, behavior: 'smooth' });
}

/* ── SISTEMA DE SUBCLASSES ── */
function switchSub(id) {
    document.querySelectorAll('.sub-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.sub-panel').forEach(p => p.classList.remove('active'));

    const panel = document.getElementById('sub-' + id);
    if (panel) panel.classList.add('active');

    document.querySelectorAll('.sub-btn').forEach(b => {
        if (b.getAttribute('onclick')?.includes(`'${id}'`)) b.classList.add('active');
    });
}

/* ── LINKS DE HABILIDADE DA TABELA ── */
document.querySelectorAll('.prog-table a[href^="#"]').forEach(link => {
    link.addEventListener('click', e => {
        e.preventDefault();
        const targetId = link.getAttribute('href').slice(1);
        // Vai para a aba de habilidades
        switchTab('habilidades');
        setTimeout(() => {
            const target = document.getElementById(targetId);
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'center' });
                target.style.boxShadow = '0 0 32px rgba(74,143,160,.55)';
                target.style.borderColor = 'var(--cls-accent)';
                setTimeout(() => {
                    target.style.boxShadow = '';
                    target.style.borderColor = '';
                }, 1800);
            }
        }, 350);
    });
});

/* ── Tenta mostrar imagem hero ── */
(function () {
    const heroImg = document.getElementById('heroImg');
    const img = new Image();
    img.onload = () => heroImg.classList.add('loaded');
    img.src = heroImg.style.backgroundImage.replace(/url\(['"]?(.*?)['"]?\)/, '$1');
})();
