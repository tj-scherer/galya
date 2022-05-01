import logging
import requests

from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *

class MainWidget(QWidget):

	def __init__(self, top):
		super().__init__()

		self.top = top
		self.log = logging.getLogger(__name__)
		
		self.list = QListWidget()
		size = QSize(200, 300)
		self.list.setGridSize(size);
		size.scale(size, Qt.KeepAspectRatio)
		self.list.setIconSize(size)
		self.list.setFlow(QListView.LeftToRight);
		self.list.setResizeMode(QListView.Adjust);
		self.list.setViewMode(QListView.IconMode);

		self.layout = QVBoxLayout()
		self.layout.addWidget(self.list)
		self.setLayout(self.layout)
		self.log.debug('MainWidget created')

	def refresh(self):
		self.log.debug('Refreshing MainWidget')
		self.list.clear()

		cursor = self.top.db.select('DISTINCT artworks.source')
		fields = [field_md[0] for field_md in cursor.description]
		result = [dict(zip(fields,row)) for row in cursor.fetchall()]
		# self.log.debug(result)

		for row in result:
			try:
				url = row['source']
				
				image = QImage()
				image.loadFromData(requests.get(url).content)

				icon = QIcon(QPixmap(image))

				widget = QListWidgetItem(icon, '')
				self.list.addItem(widget)
			except Exception as e:
				print(e)
				self.log.warning('Failed to load \'' + row['title'] + '\'')
		
		self.log.debug('Refresh complete')

class CreateWidget(QWidget):
	
	def __init__(self, top):
		super().__init__()

		self.top = top
		self.log = logging.getLogger(__name__)

		self.artwork = QPushButton('Artwork')
		self.artist = QPushButton('Artist')
		self.gallery = QPushButton('Gallery')

		self.artwork.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
		self.artist.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
		self.gallery.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

		self.layout = QHBoxLayout()
		self.layout.addWidget(self.artwork)
		self.layout.addWidget(self.artist)
		self.layout.addWidget(self.gallery)
		self.setLayout(self.layout)
		self.log.debug('CreateWidget created')

class FilterWidget(QWidget):
	
	def __init__(self, top):
		super().__init__()

		self.top = top
		self.log = logging.getLogger(__name__)
		
		# form
		form_layout = QFormLayout()
		self.favorites = QCheckBox()
		form_layout.addRow(self.tr('&Favorite Filter'), self.favorites)
		self.date = QCheckBox()
		form_layout.addRow(self.tr('&Date Filter'), self.date)
		self.low_date = QDateEdit()
		form_layout.addRow(self.tr('&Created After'), self.low_date)
		self.high_date = QDateEdit()
		form_layout.addRow(self.tr('&Created Before'), self.high_date)

		self.artist = QComboBox()
		self.artist.addItem('')
		cursor = self.top.db.select('DISTINCT artists.name')
		fields = [field_md[0] for field_md in cursor.description]
		result = [dict(zip(fields,row)) for row in cursor.fetchall()]
		for row in result:
			self.artist.addItem(row['name'])
		form_layout.addRow(self.tr('&Artist'), self.artist)

		self.gallery = QComboBox()
		self.gallery.addItem('')
		cursor = self.top.db.select('DISTINCT galleries.title')
		fields = [field_md[0] for field_md in cursor.description]
		result = [dict(zip(fields,row)) for row in cursor.fetchall()]
		for row in result:
			self.gallery.addItem(row['title'])
		form_layout.addRow(self.tr('&Gallery'), self.gallery)
		
		self.medium = QComboBox()
		self.medium.addItem('')
		cursor = self.top.db.select('DISTINCT mediums.type')
		fields = [field_md[0] for field_md in cursor.description]
		result = [dict(zip(fields,row)) for row in cursor.fetchall()]
		for row in result:
			self.medium.addItem(row['type'])
		form_layout.addRow(self.tr('&Medium'), self.medium)

		# buttons
		button_layout = QHBoxLayout()
		clearButton = QPushButton('Clear')
		clearButton.clicked.connect(self.clear)
		button_layout.addWidget(clearButton)
		applyButton = QPushButton('Apply')
		applyButton.clicked.connect(self.apply)
		button_layout.addWidget(applyButton)

		# layout
		layout = QVBoxLayout()
		layout.addLayout(form_layout)
		layout.addStretch()
		layout.addLayout(button_layout)
		self.setLayout(layout)
		self.log.debug('FilterWidget created')

		self.clear()
		self.apply()

	def apply(self):
		self.top.db.set_filter(self.artist.currentText(), self.gallery.currentText(), self.medium.currentText())
		self.top.mainWidget.refresh()
		self.top.layout.setCurrentWidget(self.top.mainWidget)
		self.log.debug('Filter applied')

	def clear(self):
		self.log.debug('Filter cleared')

	def search(self, artwork):
		self.log.debug('Searching: ' + artwork)
		self.top.db.artwork = artwork
		self.apply()

class AccountWidget(QWidget):
	
	def __init__(self, top):
		super().__init__()

		self.top = top
		self.log = logging.getLogger(__name__)    
		self.label = QLabel('Account')

		self.layout = QVBoxLayout()
		self.layout.addWidget(self.label)
		self.setLayout(self.layout)
		self.log.debug('AccountWidget created')