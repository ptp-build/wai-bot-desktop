const os = require('os');
const shell = require('shelljs');

let arch = os.arch() === 'x64' ? 'x86_64' : os.arch();
let platform = '';
//  path matching bin/python/wai-bot-rpa-aarch64-apple-darwin not found.
if (os.platform() === 'win32') {
  console.log('Running build win...');
  platform = 'pc-windows-msvc';
} else if (os.platform() === 'darwin') {
  console.log('Running build apple...');
  platform = 'apple-darwin';
  const cmd = `pyinstaller -F py-wai-bot-rpa/wai-bot-rpa.py --distpath src-tauri/bin/python --clean -n wai-bot-rpa-aarch64-${platform}`;
  console.log(`Executing command: ${cmd}`);
  console.log(`process.arch ====>>>>`,process.arch);
  shell.exec(cmd);
} else {
  console.log('Running build linux...');
  platform = 'unknown-linux-gnu';
}
const cmd = `pyinstaller -F py-wai-bot-rpa/wai-bot-rpa.py --distpath src-tauri/bin/python --clean -n wai-bot-rpa-${arch}-${platform}`;
console.log(`Executing command: ${cmd}`);
shell.exec(cmd);
