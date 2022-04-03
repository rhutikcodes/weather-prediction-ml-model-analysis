import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True

@app.route('/hello', methods=['GET'])
def hello_world():
    return "Hello World"

@app.errorhandler(Exception)
def all_exception_handler(error):
    return 'Internal Error', 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)