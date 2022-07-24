import psycopg2

connection = psycopg2.connect("dbname='example' user='postgres' password='abc' host='localhost'")
cursor = connection.cursor()

cursor.execute('insert into table2(id, completed) values(%s, %s);', (5,False))
cursor.execute('insert into table2(id, completed) values(%s, %s);', (6,True))
cursor.execute('insert into table2(id, completed) values(%s, %s);', (7,False))

# To fetch data from db & display it in python
cursor.execute('select * from table2;')
result = cursor.fetchall()
print(result)

connection.commit()
cursor.close()
connection.close()