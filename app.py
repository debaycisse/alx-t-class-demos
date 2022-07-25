from flask import Flask
# Let's instantiate our app by creating an instance of the Flask class
app = Flask(__name__) #This is a standard way of creating a flask app.

# Then we declared a python decorator, from where we can tell the app of 'which endpoint' to listen to. And we will want it to listen to the homepage route. 
@app.route('/')

# So, whenever a user connect to the homepage, we want the user's connection to be handled by a method, which we are going to create right here below.
def index():
    return "Hello World!, this is DebayCisse."


# Below should always be included at the bottom of other codes
if __name__ == '__main__':
    app.run(host="0.0.0.0")