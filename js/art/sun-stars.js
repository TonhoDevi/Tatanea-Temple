/**
 * Templo de Tatânea - Efeito de Estrelas Viajantes
 * Gerado proceduralmente para o núcleo do Sol Hollow.
 */

document.addEventListener('DOMContentLoaded', () => {
    const core = document.querySelector('.sun-starry-core');
    if (!core) return;

    // Configurações
    const STAR_COUNT = 80; // Reduzido para performance
    const coreX = 100;
    const coreY = -100;
    const coreWidth = 200;
    const coreHeight = 1100;

    const stars = [];

    // Helper para criar elementos SVG
    function createSVGElement(tag) {
        return document.createElementNS('http://www.w3.org/2000/svg', tag);
    }

    class Star {
        constructor() {
            this.element = createSVGElement('circle');
            this.init(true);
            core.appendChild(this.element);
        }

        init(isFirstLoad = false) {
            this.r = Math.random() * 0.8 + 0.3;
            
            if (isFirstLoad) {
                this.x = coreX + Math.random() * coreWidth;
                this.y = coreY + Math.random() * coreHeight;
            } else {
                // Reset no topo (viajando para baixo)
                this.x = coreX + Math.random() * coreWidth;
                this.y = coreY - 10;
            }

            // Velocidade aleatória (Drift vertical predominante)
            this.vx = (Math.random() - 0.5) * 0.05; 
            this.vy = Math.random() * 0.3 + 0.1; // Caindo suavemente

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

            // Reset logic para o Retângulo do Pilar
            if (this.y > coreY + coreHeight + 10 || 
                this.x < coreX - 10 || 
                this.x > coreX + coreWidth + 10) {
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
        stars.push(star);
    }

    // Loop de animação
    function animate() {
        stars.forEach(s => s.update());
        requestAnimationFrame(animate);
    }

    animate();
});
