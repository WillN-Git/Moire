from PySide6.QtWidgets import *
from PySide6 import QtCore
from PySide6.QtGui import *
import sys
import random


class Window(QWidget):
    def __init__(self):
        super().__init__()

        # Main Layout
        self.grid = QGridLayout(self)

        # Widgets
        widgets = {
            "logo": [],
            "button": []
        }

        # Logo
        img = QPixmap('./assets/cover.png')
        self.logo = QLabel()
        self.logo.setPixmap(img)
        self.logo.setAlignment(QtCore.Qt.AlignCenter)
        self.logo.setStyleSheet('margin: 50px 0px;')
        widgets['logo'].append(self.logo)

        # Button
        self.btn = QPushButton('Play')
        self.btn.setCursor(QCursor(QtCore.Qt.PointingHandCursor))
        self.btn.setStyleSheet(
            '* {' +
            '   border: 3px solid #bc006c;' +
            '   text-transform: uppercase;' +
            '   border-radius: 15px;' +
            '   font-size: 20px;' +
            '   color: #bc006c;' +
            '   padding: 8px 0;' +
            '   margin: 0 300px' +
            '}' +
            '*:hover {' +
            '   background-color: #bc006c;' +
            '   border: none;' +
            '   color: #fff;' +
            '}'
        )
        widgets['button'].append(self.btn)

        self.settingBtn = QPushButton('Settings')
        self.settingBtn.setCursor(QCursor(QtCore.Qt.PointingHandCursor))
        self.settingBtn.setStyleSheet(
            '* {' +
            '   border: 3px solid #bc006c;' +
            '   text-transform: uppercase;' +
            '   border-radius: 15px;' +
            '   font-size: 20px;' +
            '   color: #bc006c;' +
            '   padding: 8px 0;' +
            '   margin: 0 300px' +
            '}' +
            '*:hover {' +
            '   background-color: #bc006c;' +
            '   border: none;' +
            '   color: #fff;' +
            '}'
        )
        widgets['button'].append(self.settingsBtn)

        self.grid.addWidget(self.logo, 0, 0)
        self.grid.addWidget(self.btn, 1, 0)
        self.grid.addWidget(self.settingBtn, 2, 0)


if __name__ == "__main__":
    app = QApplication(sys.argv)

    # Window setting
    window = Window()
    window.setWindowTitle('Moire')
    window.resize(800, 600)
    window.setStyleSheet('background-color: #fff')


    window.show()

    sys.exit(app.exec())