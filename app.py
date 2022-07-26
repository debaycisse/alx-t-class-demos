from flask import Flask
from flask_sqlalchemy import SQLAlchemy
# Let's instantiate our app by creating an instance of the Flask class
app = Flask(__name__) #This is a standard way of creating a flask app.
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:abc@localhost:5432/example'


db = SQLAlchemy(app)

# Table creation in python env. via the help of SQLAlchemy
class Person(db.Model):
    __tablename__='persons'
    id=db.Column(db.Integer, primary_key=True)
    name=db.Column(db.String(), nullable=False)
    def __repr__(self):
        return f'<Person ID: {self.id}, Name: {self.name}>'

db.create_all()

# Then we declared a python decorator, from where we can tell the app of 'which endpoint' to listen to. And we will want it to listen to the homepage route. 
@app.route('/')
# So, whenever a user connect to the homepage, we want the user's connection to be handled by a method, which we are going to create right here below.
def index():
    person = Person.query.first()
    return "Hello World! {}".format(person.name)


# Below should always be included at the bottom of other codes
if __name__ == '__main__':
    app.run(host="0.0.0.0")