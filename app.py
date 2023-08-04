from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/api/bye')
def hello_geek():
    return '<h1>Hello from Flask & Docker</h2>'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
