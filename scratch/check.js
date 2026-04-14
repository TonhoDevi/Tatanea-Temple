const fs = require('fs');
const html = fs.readFileSync('html/sheet/ddt-character-sheet.html', 'utf8');
const css = fs.readFileSync('css/sheets/ddt-characters.css', 'utf8');

const htmlClasses = new Set();
const classRegex = /class=["']([^"']+)["']/g;
let match;
while ((match = classRegex.exec(html)) !== null) {
    match[1].split(/\s+/).forEach(c => {
        if(c.trim()) htmlClasses.add(c.trim());
    });
}

const cssClasses = new Set();
const cssClassRegex = /\.([a-zA-Z0-9_-]+)/g;
while ((match = cssClassRegex.exec(css)) !== null) {
    cssClasses.add(match[1]);
}

const missing = [];
htmlClasses.forEach(c => {
    if(!cssClasses.has(c)) {
        if (c.startsWith('ddt-')) {
            missing.push(c);
        }
    }
});
console.log(missing.join(','));
