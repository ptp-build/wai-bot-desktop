const os = require('os');
const shell = require('shelljs');

let arch = os.arch() === 'x64' ? 'x86_64' : os.arch();
let platform = '';

if (os.platform() === 'win32') {
  console.log('Running build win...');
  platform = 'pc-windows-msvc';
} else if (os.platform() === 'darwin') {
  console.log('Running build apple...');
  platform = 'apple-darwin';
} else {
  console.log('Running build linux...');
  platform = 'unknown-linux-gnu';
}
const cmd = `pyinstaller -F py-wai-bot-rpa/wai-bot-rpa.py --distpath src-tauri/bin/python --clean -n wai-bot-rpa-${arch}-${platform}`;
console.log(`Executing command: ${cmd}`);
shell.exec(cmd);
