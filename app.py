from flask import Flask


app = Flask(__name__)

@app.route("/")
def film_quote():
    return "<strong>My mama always said life was like a box of chocolates. You never know what you're gonna get. - </strong> <i>Forrest Gump</i>"

if __name__ in "__main__":
    app.run(host='0.0.0.0', port=5000)