from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({'message': 'Hello, CI/CD with Jenkins and Docker!'})

@app.route('/status')
def status():
    return jsonify({'status': 'App is running smoothly!'})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
