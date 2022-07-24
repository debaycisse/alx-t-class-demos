import psycopg2

# This file showcases the demonstration of another way to create INSERT sql statement and data to insert.
# This is shown on line 26.
# This method uses string composition with named placeholders and used variables 
# for both the data & sql statment to pass in the statement and data in python.

# Connecting to the db
connection = psycopg2.connect("dbname='example' user='postgres' host='localhost' password='abc'")
# Getting a cursor to the db, which allows us to create as many transactions as we want
cursor = connection.cursor()

cursor.execute('''
    DROP TABLE IF EXISTS table2;
''')

# Creating a unit of work to execute
cursor.execute('''
    CREATE TABLE table2(
        id INTEGER PRIMARY KEY,
        completed BOOLEAN NOT NULL DEFAULT False
    );
''')

data = {
    'id':2,
    'completed': False
}

sql_statement = '''
    INSERT INTO table2(id, completed)
    VALUES(%(id)s, %(completed)s);
'''

# Another way to create insertion data
cursor.execute(
    #insertion-placeholder position, passed-in-data position 
    sql_statement, data
)
# Apply the executed unit of work to the db.
connection.commit()
# Close the established connection
connection.close()
# Close the cursor as well
cursor.close()