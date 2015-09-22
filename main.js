var app = require('app');  // Module to control application life.
var shell = require('shell');
var Tray = require('tray');
var Menu = require('menu');
var MenuItem = require('menu-item');
var list = null;

var BrowserWindow = require('browser-window');  // Module to create native browser window.

// Report crashes to our server.
require('crash-reporter').start();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  // On OS X it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform != 'darwin') {
    app.quit();
  }
});


var menu = new Menu();
menu.append(new MenuItem({ label: 'MenuItem1', click: function() { console.log('item 1 clicked'); } }));
menu.append(new MenuItem({ type: 'separator' }));
menu.append(new MenuItem({ label: 'MenuItem2', type: 'checkbox', checked: true }));

var appIcon = null;
// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
app.on('ready', function() {
  // Create the browser window.
  mainWindow = new BrowserWindow({width: 800, height: 600});

  // and load the index.html of the app.
  mainWindow.loadUrl('file://' + __dirname + '/index.html');

  // Open the devtools.
  //mainWindow.openDevTools();

  appIcon = new Tray(__dirname + '/icons/app.png');
  var contextMenu = Menu.buildFromTemplate([
     { label: 'Say hello', type: 'normal',
         click: function() {
             shell.beep();
         }
     },
     { label: 'Item2', type: 'radio' },
     { label: 'Item3', type: 'radio', checked: true },
     { label: 'Item4', type: 'radio' }
   ]);
   appIcon.setToolTip('This is my application.');
   appIcon.setContextMenu(contextMenu);

  // Emitted when the window is closed.
  mainWindow.on('closed', function() {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null;
  });

  //var UserList = require('./user-list');
  //list = new UserList(mainWindow);
});


