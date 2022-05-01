import logging
import qtawesome as qta

from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *

from .database import *
from .widget import *

class MainWindow(QMainWindow):
	
	def __init__(self):
		super().__init__()

		self.log = logging.getLogger(__name__)

		self.layout = QStackedLayout()

		# connect to database
		self.db = Database()
		# create Actions
		self.createActions()
		# create Widgets
		self.createWidgets()
		# create ToolBar
		self.createToolBar()

		self.setCentralWidget(self.widget)

		# configure window
		self.setWindowTitle("Galya")
		self.setWindowIcon(qta.icon('mdi6.palette'))
		self.resize(800, 600)
		self.setFocusPolicy(Qt.StrongFocus)
		self.show()

	def createActions(self):
		self.homeAction = QAction(qta.icon('mdi6.home-city', color = '#F8F8F2'), '&Home', self)
		self.homeAction.setShortcut('Home')
		self.homeAction.triggered.connect(lambda: self.layout.setCurrentWidget(self.mainWidget))

		self.createAction = QAction(qta.icon('mdi6.plus', color = '#F8F8F2'), '&Create', self)
		self.createAction.setShortcut('Ctrl+N')
		self.createAction.triggered.connect(lambda: self.layout.setCurrentWidget(self.createWidget))

		self.filterAction = QAction(qta.icon('mdi6.filter-variant', color = '#F8F8F2'), '&Filter', self)
		self.filterAction.triggered.connect(lambda: self.layout.setCurrentWidget(self.filterWidget))

		self.accountAction = QAction(qta.icon('mdi6.account', color = '#F8F8F2'), '&Account', self)
		self.accountAction.triggered.connect(lambda: self.layout.setCurrentWidget(self.accountWidget))

	def createWidgets(self):
		self.mainWidget = MainWidget(self)
		self.layout.addWidget(self.mainWidget)
		self.layout.setCurrentWidget(self.mainWidget)
		
		self.createWidget = CreateWidget(self)
		self.layout.addWidget(self.createWidget)
		
		self.filterWidget = FilterWidget(self)
		self.layout.addWidget(self.filterWidget)

		self.accountWidget = AccountWidget(self)
		self.layout.addWidget(self.accountWidget)

		self.widget = QWidget()
		self.widget.setLayout(self.layout)

		self.searchWidget  = QLineEdit()
		self.searchWidget.returnPressed.connect(lambda: self.filterWidget.search(self.searchWidget.displayText()))

	def createToolBar(self):
		# file toolbar
		toolBar = QToolBar()
		toolBar.setMovable(False)
		self.addToolBar(toolBar)

		toolBar.addAction(self.homeAction)
		toolBar.addAction(self.createAction)
		toolBar.addWidget(self.searchWidget)
		toolBar.addAction(self.filterAction)
		toolBar.addAction(self.accountAction)