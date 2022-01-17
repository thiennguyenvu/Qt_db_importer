# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, Property, QUrl, QTimer
from PySide2.QtSql import QSqlDatabase, QSqlQuery, QSqlQueryModel
from PySide2.QtWidgets import *
import ctypes
import pandas as pd
from shutil import copyfile
from lib.DataFrameModel import DataFrameModel


app_id = "TNV.Importer.DBImporter.1.0"
dbDriver = 'QODBC'


def saveSettings(DRIVER, SERVER_NAME, DB_NAME, USERNAME, PASSWORD):
    with open("settings.ini", 'w+', encoding='utf-8') as f:
        f.write(f"{DRIVER}# {SERVER_NAME}# {DB_NAME}# {USERNAME}# {PASSWORD}")


def loadSettings():
    settings = []
    try:
        with open("settings.ini", 'r', encoding='utf-8') as f:
            settings = f.read().split('# ')
    except Exception:
        print('File not found.')
    return settings


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.connString = None
        self.conn = None
        self.status = False
        self.driver = None
        self.server = None
        self.db = None
        self.username = None
        self.password = None
        self.settings = loadSettings()
        if self.settings:
            self.driver = self.settings[0]
            self.server = self.settings[1]
            self.db = self.settings[2]
            self.username = self.settings[3]
            self.password = self.settings[4]

        self.db_tables = None  # Table model of database (instance model)
        self.data_table = None  # Table data which user selected
        self.head_table = None  # Save header row of table
        self.identity = False  # Detect have identity column named 'id'

        self.sqlTablesName = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES"
        self.sqlDataTable = "SELECT TOP(5) * FROM "

        self.urlExcelSelected = None
        self.urlCSVSelected = None
        self.sheetSelected = None
        self.excelDataFrame = None
        self.csvDataFrame = None
        self.currentTable = None
        self.sqlNumberCols = 0
        self.sqlNumberRows = 0
        self.rootCount = 0  # Save value of counter when user input

    def createConnection(self, connectionName, DRIVER, SERVER_NAME,
                         DB_NAME, USERNAME, PASSWORD):
        if DRIVER == "Microsoft SQL Server":
            dbDriver = 'QODBC'
            DRIVER = 'SQL Server'
        if DRIVER == 'MySQL/MariaDB':
            dbDriver = 'QMYSQL/MARIADB'
            DRIVER = 'QMYSQL'
        if DRIVER == 'Oracle':
            dbDriver == 'QOCI'
        if DRIVER == 'PostgreSQL':
            dbDriver = 'QPSQL'
        connString = f'Driver={DRIVER};' \
                     f'Server={SERVER_NAME};' \
                     f'Database={DB_NAME};' \
                     f'UID={USERNAME};' \
                     f'PWD={PASSWORD}'
        print(connString)
        self.connString = connString  # Storage the connection string
        self.conn = connectionName  # Storage the connection name
        global db
        db = QSqlDatabase.addDatabase(dbDriver, connectionName)
        db.setDatabaseName(connString)
        if db.open():
            print('Connected to SQL Server successfully')
            return True
        else:
            print(f'ERROR: {db.lastError().text()}')
            return False

    def executeQuery(self, sqlQuery):
        qry = QSqlQuery(QSqlDatabase.database(self.conn))
        qry.prepare(sqlQuery)
        qry.exec_()

    def getModel(self, sqlTablesName):
        qry = QSqlQuery(QSqlDatabase.database(self.conn))
        qry.prepare(sqlTablesName)
        qry.exec_()

        self.sqlNumberCols = qry.record().count()
        self.sqlNumberRows = qry.size()

        model = QSqlQueryModel()
        model.setQuery(qry)
        return model

    # Passing all tables name to qml combobox
    signalBtnShow = Signal(QSqlQueryModel)

    @Slot()
    def displayTables(self):
        self.db_tables = self.getModel(self.sqlTablesName)
        engine.rootContext().setContextProperty("db_tables",
                                                self.db_tables)

    # Get data from table which user input
    signalTableSelected = Signal(bool)

    @Slot(str)
    def getTableSelected(self, tblName):
        self.currentTable = tblName
        self.sqlDataTable = f'SELECT TOP(5) * FROM {tblName}'
        self.data_table = self.getModel(self.sqlDataTable)
        # Get header column of table
        self.head_table = ''
        for i in range(0, self.sqlNumberCols):
            if self.data_table.record(0).fieldName(i) != 'id':
                self.head_table += f'{self.data_table.record(0).fieldName(i)}, '
            else:
                self.identity = True
        self.head_table = self.head_table[:-2]
        if self.data_table:
            self.signalTableSelected.emit(True)
            engine.rootContext().setContextProperty("data_table",
                                                    self.data_table)
        else:
            self.signalTableSelected.emit(False)

    # Open any file
    @Slot(QUrl)
    def openFile(self, url):
        os.startfile(url.toLocalFile())

    # Open file csv & passing data to qml tableview
    @Slot(QUrl)
    def openCSVFile(self, url):
        src_path = url.toLocalFile()
        filename = (src_path.split('/'))[-1]
        dst_path = f'data/csv/{filename}'
        self.urlCSVSelected = url  # Save url

        copyfile(src_path, dst_path)  # shutil.copyfile before process
        df = pd.read_csv(dst_path)
        self.csvDataFrame = df
        df = df.head(5)

        model = DataFrameModel(df)
        engine.rootContext().setContextProperty("csv_model", model)

    # Import csv data to database
    @Slot()
    def importCSVData(self):
        df = self.csvDataFrame
        sqlInsert = ''
        if self.identity:  # if exists 'id' column
            for row in df.iterrows():
                row_data = []
                count = 1
                for col in df.columns:
                    if count > self.sqlNumberCols - 1:  # exclude 'id' column
                        break  # Break if csv columns > sql table columns
                    row_data.append(row[1][col])
                    count += 1
                sqlInsert = f'INSERT INTO {self.currentTable}\
                               ({self.head_table}) VALUES({row_data})'\
                               .replace('[', '').replace(']', '')
                self.executeQuery(sqlInsert)
        else:
            for row in df.iterrows():
                row_data = []
                count = 1
                for col in df.columns:
                    if count > self.sqlNumberCols:
                        break  # Break if csv columns > sql table columns
                    row_data.append(row[1][col])
                    count += 1
                sqlInsert = f'INSERT INTO {self.currentTable}\
                               ({self.head_table}) VALUES({row_data})'\
                               .replace('[', '').replace(']', '')
                self.executeQuery(sqlInsert)

    # Open file excel & passing data to qml tableview
    signalOpenFile = Signal(list)

    def dateparser(self, date):
        print('date', date)

    @Slot(QUrl, int)
    def openExcelFile(self, url, sheet_index):
        src_path = url.toLocalFile()
        filename = (src_path.split('/'))[-1]
        dst_path = f'data/excel/{filename}'
        self.urlExcelSelected = url  # Save url
        self.sheetSelected = sheet_index  # Save index

        copyfile(src_path, dst_path)  # shutil.copyfile before process
        xlsx = pd.ExcelFile(dst_path)
        df = xlsx.parse(xlsx.sheet_names[sheet_index], na_values=['NA'])
        self.excelDataFrame = df  # Storage current dataframe
        df = df.head(5)  # Get top 5 rows

        model = DataFrameModel(df)
        engine.rootContext().setContextProperty("excel_model", model)
        self.signalOpenFile.emit(xlsx.sheet_names)

    # Import excel data to database
    @Slot()
    def importExcelData(self):
        df = self.excelDataFrame
        sqlInsert = ''
        if self.identity:
            for row in df.iterrows():
                row_data = []
                count = 1
                for col in df.columns:
                    if count > self.sqlNumberCols - 1:  # exclude 'id' column
                        break  # Break if csv columns > sql table columns
                    row_data.append(row[1][col])
                    count += 1
                sqlInsert = f'INSERT INTO {self.currentTable}\
                               ({self.head_table}) VALUES({row_data})'\
                               .replace('[', '').replace(']', '')
                self.executeQuery(sqlInsert)
        else:
            for row in df.iterrows():
                row_data = []
                count = 1
                for col in df.columns:
                    if count > self.sqlNumberCols:
                        break  # Break if csv columns > sql table columns
                    row_data.append(row[1][col])
                    count += 1
                sqlInsert = f'INSERT INTO {self.currentTable}\
                               ({self.head_table}) VALUES({row_data})'\
                               .replace('[', '').replace(']', '')
                self.executeQuery(sqlInsert)
        print(sqlInsert)

    # Counter for auto import
    def callbackCSVCounter(self):
        self.count -= 1
        if self.count == 0:
            self.count = self.rootCount
            # Open csv file and import after {self.count} seconds
            self.openCSVFile(self.urlCSVSelected)
            self.importCSVData()

    def callbackExcelCounter(self):
        self.count -= 1
        if self.count == 0:
            self.count = self.rootCount
            # Open excel file and import after {self.count} seconds
            self.openExcelFile(self.urlExcelSelected, self.sheetSelected)
            self.importExcelData()

    # Auto import
    @Slot(str, int)
    def autoImport(self, filetype, second):
        if second <= 0:
            second = 1
        self.rootCount = second
        self.count = second
        timer = QTimer(self)
        if filetype == 'xlsx':
            timer.timeout.connect(self.callbackExcelCounter)
        if filetype == 'csv':
            timer.timeout.connect(self.callbackCSVCounter)
        timer.start(1000)

    # Passing database info list to qml text input
    signalSettingList = Signal(list)

    @Property(list)
    def loadDatabaseInfo(self):
        self.signalSettingList.emit(self.settings)

    # Passing bool value (connection status) to qml
    signalConnStatus = Signal(bool)

    @Slot(str, str, str, str, str, str)
    def saveDatabaseInfo(self, connectionName, driver,
                         server, db, username, password):
        self.status = self.createConnection(connectionName, driver, server,
                                            db, username, password)
        self.signalConnStatus.emit(self.status)
        if self.status:
            self.driver = driver
            self.server = server
            self.db = db
            self.username = username
            self.password = password
            saveSettings(driver, server, db, username, password)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # App icon
    ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID(app_id)
    app.setWindowIcon(QIcon("images/logo.png"))

    # Load QML file
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    # Passing Qobject to qml
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
