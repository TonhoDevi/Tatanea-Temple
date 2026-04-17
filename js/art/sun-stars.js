/**
 * Templo de Tatânea - Efeito de Estrelas Viajantes
 * Gerado proceduralmente para o núcleo do Sol Hollow.
 */

document.addEventListener('DOMContentLoaded', () => {
    const core = document.querySelector('.sun-starry-core');
    if (!core) return;

    // Configurações
    const STAR_COUNT = 45;
    const coreCenterX = 200;
    const coreCenterY = 50;
    const coreRadius = 112;

    const stars = [];

    // Helper para criar elementos SVG
    function createSVGElement(tag) {
        return document.createElementNS('http://www.w3.org/2000/svg', tag);
    }

    class Star {
        constructor() {
            this.element = createSVGElement('circle');
            this.init();
            core.appendChild(this.element);
        }

        init(isFirstLoad = false) {
            // Se for o primeiro carregamento, espalha por tudo. 
            // Se for reset (saiu da tela), coloca na borda esquerda ou topo.
            
            this.r = Math.random() * 0.8 + 0.3; // Tamanho entre 0.3 e 1.1
            
            if (isFirstLoad) {
                this.x = coreCenterX + (Math.random() - 0.5) * coreRadius * 2.2;
                this.y = coreCenterY + (Math.random() - 0.5) * coreRadius * 2.2;
            } else {
                // Reset na borda esquerda (viajando para a direita)
                this.x = coreCenterX - coreRadius - 20;
                this.y = coreCenterY + (Math.random() - 0.5) * coreRadius * 2;
            }

            // Velocidade aleatória (Drift constante)
            this.vx = Math.random() * 0.2 + 0.1; 
            this.vy = (Math.random() - 0.5) * 0.05;

            // Twinkle (Pulsação de opacidade)
            this.opacity = Math.random();
            this.twinkleSpeed = Math.random() * 0.02 + 0.01;
            
            this.element.setAttribute('fill', 'white');
            this.element.setAttribute('filter', 'url(#star-glow)');
            this.updateElement();
        }

        update() {
            this.x += this.vx;
            this.y += this.vy;

            // Twinkle logic
            this.opacity += this.twinkleSpeed;
            if (this.opacity > 1 || this.opacity < 0.2) {
                this.twinkleSpeed *= -1;
            }

            // Se sair muito longe do centro (considerando o clip-path circular de 112r)
            // Usamos uma margem maior para garantir que voltem de forma fluida
            const dist = Math.sqrt((this.x - coreCenterX)**2 + (this.y - coreCenterY)**2);
            if (this.x > coreCenterX + coreRadius + 10 || dist > coreRadius * 1.5) {
                this.init();
            }

            this.updateElement();
        }

        updateElement() {
            this.element.setAttribute('cx', this.x);
            this.element.setAttribute('cy', this.y);
            this.element.setAttribute('r', this.r);
            this.element.setAttribute('opacity', Math.max(0.1, this.opacity * 0.8));
        }
    }

    // Inicializa as estrelas
    for (let i = 0; i < STAR_COUNT; i++) {
        const star = new Star();
        star.init(true); // Espalha inicialmente
        stars.push(star);
    }

    // Loop de animação
    function animate() {
        stars.forEach(s => s.update());
        requestAnimationFrame(animate);
    }

    animate();
});
