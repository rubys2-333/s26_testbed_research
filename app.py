from flask import Flask
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(host='192.168.56.20', 
username='flask', password = 'sudo')
db.database = 'users'
cursor = db.cursor()


@app.route('/')
def hello_world():
    cursor.execute('SELECT * FROM users')
    result = cursor.fetchall()
    return f'<p>{result}</p>'