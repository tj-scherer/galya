import logging
import mysql.connector as sql

class Database():

	def __init__(self, host = 'localhost', user = 'root', password = 'toor', database = 'galya'):
		self.log = logging.getLogger(__name__)

		self.db = sql.connect(
			host     = host,
			user     = user,
			password = password,
			database = database)

		self.cursor = self.db.cursor(buffered = True)

		self.artwork = ''
		self.artist = ''
		self.gallery = ''
		self.medium = ''

	def set_filter(self, artist, gallery, medium):
		self.artist = artist
		self.gallery = gallery
		self.medium = medium
		self.log.debug('Filter updated')

	def create(self):
		self.log.debug('INSERT')

	def select(self, select):
		query =  'SELECT ' + select + ' '
		query += 'FROM galleries, artworks, artists, mediums, featuredartwork, createdby, ismedium '
		query += 'WHERE '
		if self.artwork != '':
			query += 'INSTR(artworks.title, \'' + self.artwork + '\') > 0 AND '
		if self.artist != '':
			query += 'artworks.id = createdby.artworkid AND '
			query += 'artists.id = createdby.artistid AND '
			query += 'artists.name = \'' + self.artist + '\' AND '
		if self.gallery != '':
			query += 'artworks.id = featuredartwork.artworkid AND '
			query += 'galleries.id = featuredartwork.galleryid AND '
			query += 'galleries.title = \'' + self.gallery + '\' AND '
		if self.medium != '':
			query += 'artworks.id = ismedium.artworkid AND '
			query += 'mediums.type = ismedium.mediumtype AND '
			query += 'mediums.type = \'' + self.medium + '\' AND '
		query += '\'1\'=\'1\';'

		self.log.debug(query)
		self.cursor.execute(query)
		return self.cursor

	def update(self):
		self.log.debug('UPDATE')

	def delete(self):
		self.log.debug('DELETE')

if __name__ == '__main__':
	logging.basicConfig(level = logging.DEBUG)

	db = Database()

	db.log.debug('Connecting to database...')
	db.connect()

	db.log.debug('Done!')