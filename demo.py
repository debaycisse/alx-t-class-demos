import psycopg2

# Connecting to the db
connection = psycopg2.connect("dbname='example' user='postgres' host='localhost' password='abc'")
# Getting a cursor to the db, which allows us to create as many transactions as we want
cursor = connection.cursor()
# Creating a unit of work to execute
cursor.execute('''
    CREATE TABLE table2(
        id INTEGER PRIMARY KEY,
        completed BOOLEAN NOT NULL DEFAULT False
    );
''')
# Another unit of work to execute or carry out
cursor.execute('''
    INSERT INTO table2(id, completed)
    VALUES(1, True),
        (2, False),
        (3, True);
''')
# Apply the executed unit of work to the db.
connection.commit()
# Close the established connection
connection.close()
# Close the cursor as well
cursor.close()