import logging
import sys

from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *

from .window import *

if __name__ == '__main__':
	logging.basicConfig(level = logging.DEBUG)

	QApplication.setAttribute(Qt.AA_EnableHighDpiScaling)

	app = QApplication(sys.argv)
	app.setStyle('Fusion')
	app.setStyleSheet(open('src/styles.css').read())
	app.setAttribute(Qt.AA_UseHighDpiPixmaps)

	window = MainWindow()
	app.exec()