from flask import Flask,jsonify
app = Flask(__name__)

# Import required libraries
import pyodbc

# Replace these with your database connection details
server = 'portfoliorecomendation.database.windows.net'
database = 'Portfolio'
username = 'PortRecom'
password = 'Portfolio@007'

# Create the database connection
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
connection = pyodbc.connect(connection_string)

@app.route('/api/bye')
def hello_geek():
    return '<h1>Hello from Flask & Docker</h2>'

@app.route('/api/hello')
def hello():
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM dbo.Clients')
    data = cursor.fetchall()
    cursor.close()
    result = [{'id': row[0], 'name': row[1]} for row in data]
    return jsonify(result)
    #return '<h1>Hello from Flask & Docker</h2>'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
