from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

app= Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:abc@localhost:5432/todo_app_db'

db= SQLAlchemy(app)

# Our model
class Todo(db.Model):
    __tablename__ = 'todos'
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.String(), nullable=False)

    # our debug method
    def __repr__(self) -> str:
        return f'<TODO ID:- {self.id}, DESCRIPTION:- {self.description}'

# Let's create our modelled table
db.create_all()


@app.route('/')
def index():
    return render_template('index.html', data=Todo.query.all())

if __name__ == '__main__':
    app.run(host='0.0.0.0')