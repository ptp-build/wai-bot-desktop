import pyautogui
import time
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import logging
logging.basicConfig(filename="/tmp/wai-rpa.log", filemode='a',
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    level=logging.INFO)

PORT = 8688

def log(message, level=logging.INFO):
    """
    Log a message to the file.

    :param message: Message to be logged
    :param level: Level of the log (default is INFO)
    """
    if level == logging.CRITICAL:
        logging.critical(message)
    elif level == logging.ERROR:
        logging.error(message)
    elif level == logging.WARNING:
        logging.warning(message)
    elif level == logging.INFO:
        logging.info(message)
    else:
        logging.debug(message)

class SimpleAPIHandler(BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, Accept")
        self.send_header("Access-Control-Allow-Credentials", "true")
        self.end_headers()
        self.wfile.write("")
    def setHeaders(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.end_headers()
    def send_json(self,response):
        self.setHeaders()
        self.wfile.write(json.dumps(response).encode())
    def do_GET(self):
        self.send_json({"status": 200})
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        raw_post_data = self.rfile.read(content_length)
        json_payload = json.loads(raw_post_data.decode())
        steps = json_payload["steps"]
        for step in steps:
            cmd = step['cmd']
            if cmd == 'moveTo':
                x = step['x']
                y = step['y']
                pyautogui.moveTo(x, y)
            elif cmd == 'click':
                pyautogui.click()
            elif cmd == 'typewrite':
                text = step['text']
                pyautogui.typewrite(text)
            elif cmd == 'hotkey':
                keys = step['keys']
                pyautogui.hotkey(*keys)
            elif cmd == 'press':
                pyautogui.press(step['key'])
            elif cmd == 'sleep':
                sec = step['sec']
                time.sleep(sec)

        self.send_json({"status": 200})

if len(sys.argv) > 2:
    try:
        PORT = int(sys.argv[2])
    except ValueError:
        log("Invalid port number. Using default port "+ str(PORT))

with HTTPServer(("", PORT), SimpleAPIHandler) as httpd:
    log(f"Serving API at http://localhost:{PORT}")
    print(f"Serving API at http://localhost:{PORT}")
    httpd.serve_forever()


