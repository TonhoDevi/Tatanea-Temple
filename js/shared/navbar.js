// ========================================
// NAVBAR - COMPARTILHADO
// Usado em todas as páginas
// ========================================

function toggleNavbar() {
    const menu = document.querySelector('.navbar-menu');
    if (menu) {
        menu.classList.toggle('active');
    }
}

// Fechar menu ao clicar num link, no fundo, ou fora (mobile)
document.addEventListener('click', function(e) {
    const menu = document.querySelector('.navbar-menu');
    const toggle = document.querySelector('.navbar-toggle');
    
    if (menu && toggle && menu.classList.contains('active')) {
        const isClickInsideMenuContext = menu.contains(e.target);
        const isClickOnToggle = toggle.contains(e.target);
        const isClickOnLink = e.target.closest('a') !== null;
        const isClickOnBackground = e.target === menu || e.target.tagName.toLowerCase() === 'ul';
        
        if ((!isClickInsideMenuContext && !isClickOnToggle) || isClickOnLink || isClickOnBackground) {
            menu.classList.remove('active');
        }
    }
});