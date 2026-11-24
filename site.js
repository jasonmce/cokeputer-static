const screen = document.getElementById('lcd');
const next = document.getElementById('lcd-next');
let mode = 0;
function renderLCD() {
 const views = ['***Last Purchases***\ncoker     beer\ncoker     sprite\ncoker     beer', '**2003 Inventory**\nCoke 48  Sprite 21\nOrange 11 RootB 11\nLem 12 G18 Beer48', '***Local time***\n' + new Date().toLocaleTimeString() + '\n' + new Date().toLocaleDateString() + '\nBrowser demo'];
 screen.textContent = views[mode];
}
next.addEventListener('click', () => { mode = (mode + 1) % 3; renderLCD(); });
setInterval(() => { if (mode === 2) renderLCD(); }, 1000);
renderLCD();
