import mysql.connector as sql

def print_query(query):
	for info in query:
		print('\t' + str(info))

def test_schema():
	cursor.execute('SHOW TABLES')
	
	tables = []
	for table in cursor:
		tables.append(table[0])

	for t in tables:
		query = "SELECT * FROM " + str(t)
		print(query)
		cursor.execute(query)
		query = cursor.fetchall()
		print_query(query)
		print()

if __name__ == '__main__':
	db = sql.connect(
	host = 'localhost',
	user = 'root',
	password = 'toor',
	database = 'galya')

	cursor = db.cursor(buffered = True)
	test_schema()