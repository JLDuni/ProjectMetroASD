from http.server import BaseHTTPRequestHandler, HTTPServer
import json


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"status": "ok"}).encode())
        else:
            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()
            self.wfile.write(b"<div>Hello from MetroIsJustABus mock</div>")

    def log_message(self, fmt, *args):
        # keep the container logs clean
        pass


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 5000), Handler).serve_forever()