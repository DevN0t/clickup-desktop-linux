const { app, BrowserWindow } = require('electron');

function createWindow() {
  const win = new BrowserWindow({
    width: 1280,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  win.loadURL('https://app.clickup.com');
  win.setTitle("ClickUp (unofficial)");

  win.setMenu(null); // Remove a barra de menus (File, Edit, etc.)

  win.webContents.on('did-finish-load', () => {
    win.setTitle("ClickUp (unofficial)");
  });

  win.webContents.on('did-fail-load', () => {
    console.error('Erro ao carregar a página do ClickUp.');
  });
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
