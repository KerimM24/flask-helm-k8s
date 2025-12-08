from flask import Flask
import os

app = Flask(__name__)

@app.route("/secret")
def secret():
    secret = os.getenv("APP_SECRET")
    if secret:
        return {"secret_present": True}, 200
    else:
        return {"secret_present": False}, 200

@app.route("/hello")
def index():
    return "Nothing here is there?", 200

@app.route("/health")
def health():
    return "OK", 200

@app.route("/config")
def config():
    return {
        "env": os.getenv("APP_ENV", "dev"),
        "port": os.getenv("APP_PORT", "5000"),
    }

if __name__ == "__main__":
    port = int(os.getenv("APP_PORT", "5000"))
    app.run(host="0.0.0.0", port=port)