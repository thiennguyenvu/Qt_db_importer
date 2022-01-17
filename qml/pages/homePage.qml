import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.0

import "../controls"

Item {
    id: homePage

    Rectangle {
        id: home_bg
        color: "#e5f0f9"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: home_title
            height: 40
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 100
            anchors.topMargin: 0
            anchors.leftMargin: 100

            Label {
                id: lblHome
                text: qsTr("HOME")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                font.pointSize: 15
            }
        }

        GroupBox {
            id: grBoxDBConnection
            width: 400
            anchors.left: parent.left
            anchors.top: home_title.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 20
            title: qsTr("Database Connection")

            Label {
                id: lblDatabase
                width: 125
                height: 40
                text: qsTr("Database")
                anchors.left: parent.left
                anchors.top: lblServerName.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                anchors.leftMargin: 20
                anchors.topMargin: 15
            }

            ComboBox {
                id: cboxDatabase
                height: 40
                anchors.left: lblDatabase.right
                anchors.right: parent.right
                anchors.top: txtServerName.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 15
                anchors.rightMargin: 25

                model: ['Microsoft SQL Server', 'MySQL/MariaDB', 'Oracle', 'PostgreSQL']
            }

            Label {
                id: lblServerName
                width: 125
                height: 40
                text: qsTr("Server Name")
                anchors.left: parent.left
                anchors.top: lblConnectionName.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 15
                anchors.leftMargin: 20
                font.bold: true
            }

            TextField {
                id: txtServerName
                anchors.left: lblServerName.right
                anchors.right: parent.right
                anchors.top: txtConnectionName.bottom
                anchors.rightMargin: 25
                anchors.topMargin: 15
                placeholderText: qsTr("Your Server Name")
            }

            Label {
                id: lblDatabaseName
                width: 125
                height: 40
                text: qsTr("Database Name")
                anchors.left: parent.left
                anchors.top: lblDatabase.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 15
                anchors.leftMargin: 20
                font.bold: true
            }

            TextField {
                id: txtDatabaseName
                x: 130
                anchors.left: lblDatabaseName.right
                anchors.right: parent.right
                anchors.top: cboxDatabase.bottom
                anchors.rightMargin: 25
                anchors.leftMargin: 0
                placeholderText: qsTr("Your Database Name")
                anchors.topMargin: 15
            }

            Label {
                id: lblUserName
                width: 125
                height: 40
                text: qsTr("Username")
                anchors.left: parent.left
                anchors.top: lblDatabaseName.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 15
                anchors.leftMargin: 20
                font.bold: true
            }


            TextField {
                id: txtUserName
                anchors.left: lblUserName.right
                anchors.right: parent.right
                anchors.top: txtDatabaseName.bottom
                anchors.rightMargin: 25
                placeholderText: qsTr("Your Username")
                anchors.topMargin: 15
                anchors.leftMargin: 0
            }

            Label {
                id: lblPassword
                width: 125
                height: 40
                text: qsTr("Password")
                anchors.left: parent.left
                anchors.top: lblUserName.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 15
                anchors.leftMargin: 20
                font.bold: true
            }

            TextField {
                id: txtPassword
                x: 130
                anchors.left: lblPassword.right
                anchors.right: parent.right
                anchors.top: txtUserName.bottom
                anchors.rightMargin: 25
                placeholderText: qsTr("Your Password")
                anchors.topMargin: 15
                anchors.leftMargin: 0
                echoMode: "Password"
            }

            MessageBox{
                id: msgboxConnectDB
                visible: false
                anchors.verticalCenterOffset: -43
                anchors.rightMargin: 15
                anchors.leftMargin: 25
                height: 160
            }

            NormalButton {
                id: btnSaveConfigDB
                x: 217
                width: 135
                height: 40
                text: qsTr("Save and Connect")
                anchors.right: parent.right
                anchors.top: txtPassword.bottom
                anchors.topMargin: 15
                anchors.rightMargin: 25
                onClicked: {
                    backend.saveDatabaseInfo(txtConnectionName.text, cboxDatabase.currentText, txtServerName.text, txtDatabaseName.text, txtUserName.text, txtPassword.text)
                }
            }

            NormalButton {
                id: btnLoadConfigDB
                x: 54
                width: 135
                height: 40
                text: qsTr("Load Setting File")
                anchors.right: btnSaveConfigDB.left
                anchors.top: txtPassword.bottom
                anchors.topMargin: 15
                anchors.rightMargin: 25
                onClicked: {
                    btnSaveConfigDB.text = qsTr("Connect")
                    backend.loadDatabaseInfo()
                }
            }

            Label {
                id: lblConnectionName
                width: 125
                height: 40
                text: qsTr("Connection Name")
                anchors.left: parent.left
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }

            TextField {
                id: txtConnectionName
                x: 151
                y: 401
                anchors.left: lblConnectionName.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.rightMargin: 25
                placeholderText: qsTr("Input Connection Name")
                anchors.topMargin: 10
            }
        }

        GroupBox {
            id: grBoxDBReview
            anchors.left: grBoxDBConnection.right
            anchors.right: parent.right
            anchors.top: home_title.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 0
            anchors.rightMargin: 20
            anchors.topMargin: 20
            title: qsTr("Import Reviews")

            TableView{
                id: tblDatabase
                y: 0
                width: 100
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: cbboxTables.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                // boundsBehavior: Flickable.StopAtBounds
                clip: true
                anchors.topMargin: 5
                z: 3
                visible: false

                columnWidthProvider: function (column) { return 100; }
                rowHeightProvider: function (column) { return 50; }
                leftMargin: dbRowsHeader.implicitWidth
                topMargin: dbColumnsHeader.implicitHeight
                model: data_table
                delegate: Rectangle {
                    Text {
                        id: txtDBData
                        text: display
                        anchors.fill: parent
                        anchors.margins: 10
                        color: '#000000'
                        font.pixelSize: 15
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle { // mask the headers
                    z: 3
                    color: "#d3d3d3"
                    y: tblDatabase.contentY
                    x: tblDatabase.contentX
                    width: tblDatabase.leftMargin
                    height: tblDatabase.topMargin
                }

                Row {
                    id: dbColumnsHeader
                    y: tblDatabase.contentY
                    z: 2
                    Repeater {
                        model: tblDatabase.columns > 0 ? tblDatabase.columns : 1
                        Label {
                            width: tblDatabase.columnWidthProvider(modelData)
                            height: 45
                            text: data_table.headerData(modelData, Qt.Horizontal)
                            color: '#ffffff'
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            background: Rectangle { color: "#298AD4" }
                        }
                    }
                }

                Row{
                    id: dbRowsData
                    y: tblDatabase.contentY + dbColumnsHeader.height
                    z: 2
                    Repeater{
                        model: tblDatabase
                        Label {
                            width: 45
                            height: 45
                            text: data_table.data(modelData)
                            color: '#aaaaaa'
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Column {
                    id: dbRowsHeader
                    x: tblDatabase.contentX
                    z: 2
                    Repeater {
                        model: tblDatabase.rows > 0 ? tblDatabase.rows : 1
                        Label {
                            width: 45
                            height: tblDatabase.rowHeightProvider(modelData)
                            text: data_table.headerData(modelData, Qt.Vertical)
                            color: '#000000'
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            background: Rectangle { color: "#FCF6D0" }
                        }
                    }
                }
                ScrollIndicator.horizontal: ScrollIndicator { }
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            ComboBox {
                id: cbboxTables
                width: 400
                height: 40
                anchors.left: lblChooseTable.right
                anchors.top: parent.top
                clip: true
                anchors.leftMargin: 0
                anchors.topMargin: 0
                model: db_tables
                onActivated: {
                    backend.getTableSelected(currentText)
                }
            }

            Label {
                id: lblChooseTable
                width: 115
                height: 40
                text: qsTr("Choose table:")
                anchors.left: parent.left
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }

            TabBar {
                id: tabBar
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: tblDatabase.bottom
                anchors.topMargin: 5
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                background: Rectangle{
                    color: "#eeeeee"
                }

                TabButton {
                    id: tabExcel
                    width: 140
                    text: qsTr("Excel")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 5
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    background: Rectangle {
                        color: "#d2e8d2"
                    }
                    state: {
                        tabExcel.checked ? pageExcel.visible = true : pageExcel.visible = false
                    }
                }

                TabButton {
                    id: tabCSV
                    width: 140
                    text: qsTr("CSV")
                    anchors.left: tabExcel.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 5
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    background: Rectangle{
                        color: "#E7E2FF"
                    }
                    state: {
                        tabCSV.checked ? pageCSV.visible = true : pageCSV.visible = false
                    }
                }
            }

            Page {
                id: pageExcel
                height: 200
                visible: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: tabBar.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                background: Rectangle{
                    color: "#d2e8d2" // "#cbe2f4"
                }

                TableView {
                    id: tblExcelView
                    y: 0
                    height: 100
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: tabBar.bottom
                    anchors.topMargin: 5
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    clip: true
                    // boundsBehavior: Flickable.StopAtBounds
                    visible: false
                    z: 3
                    columnWidthProvider: function (column) { return 100; }
                    rowHeightProvider: function (column) { return 50; }
                    leftMargin: rowsHeader.implicitWidth
                    topMargin: columnsHeader.implicitHeight
                    model: excel_model
                    delegate: Rectangle {
                        Text {
                            id: txtData
                            text: display
                            anchors.fill: parent
                            anchors.margins: 10
                            color: '#000000'
                            font.pixelSize: 15
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle { // mask the headers
                        z: 3
                        color: "#d3d3d3"
                        y: tblExcelView.contentY
                        x: tblExcelView.contentX
                        width: tblExcelView.leftMargin
                        height: tblExcelView.topMargin
                    }

                    Row {
                        id: columnsHeader
                        y: tblExcelView.contentY
                        z: 2
                        Repeater {
                            model: tblExcelView.columns > 0 ? tblExcelView.columns : 1
                            Label {
                                width: tblExcelView.columnWidthProvider(modelData)
                                height: 45
                                text: excel_model.headerData(modelData, Qt.Horizontal)
                                color: '#ffffff'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                background: Rectangle { color: "#298AD4" }
                            }
                        }
                    }

                    Row{
                        id: rowsData
                        y: tblExcelView.contentY + columnsHeader.height
                        z: 2
                        Repeater{
                            model: tblExcelView
                            Label {
                                width: 45
                                height: 45
                                text: excel_model.data(modelData)
                                color: '#aaaaaa'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    Column {
                        id: rowsHeader
                        x: tblExcelView.contentX
                        z: 2
                        Repeater {
                            model: tblExcelView.rows > 0 ? tblExcelView.rows : 1
                            Label {
                                width: 45
                                height: tblExcelView.rowHeightProvider(modelData)
                                text: excel_model.headerData(modelData, Qt.Vertical)
                                color: '#000000'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                background: Rectangle { color: "#FCF6D0" }
                            }
                        }
                    }
                    ScrollIndicator.horizontal: ScrollIndicator { }
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                ComboBox {
                    id: cbboxExcelSheet
                    width: 231
                    height: 40
                    anchors.left: lblExcelSheet.right
                    anchors.top: tblExcelView.bottom
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    onActivated: {
                        backend.openExcelFile(fileExcelDialog.fileUrl, currentIndex)
                    }
                }

                Label {
                    id: lblExcelSheet
                    width: 41
                    height: 39
                    text: qsTr("Sheet: ")
                    anchors.left: parent.left
                    anchors.top: tblExcelView.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 10
                    anchors.leftMargin: 20
                }

                NormalButton {
                    id: btnOpenExcelFile
                    y: 114
                    width: 140
                    height: 31
                    z: 5
                    text: "Open File"
                    anchors.left: cbboxExcelSheet.right
                    anchors.leftMargin: 20
                    onClicked: {
                        fileExcelDialog.open()
                    }

                    FileDialog{
                        id: fileExcelDialog
                        title: "Select a file"
                        folder: shortcuts.desktop
                        selectMultiple: false
                        nameFilters: ["Excel Files (*.xlsx)"]
                        onAccepted: {
                            tblExcelView.visible = true
                            backend.openExcelFile(fileExcelDialog.fileUrl, 0)
                        }
                    }
                }

                NormalButton{
                    id: btnExcelImport
                    x: 638
                    y: 160
                    width: 110
                    height: 31
                    z: 5
                    text: "Import Excel"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 20
                    onClicked: {

                        if (txtExcelTimer.length != 0){
                            backend.autoImport('xlsx', txtExcelTimer.text) // Auto import
                        }
                        else {
                            backend.importExcelData() // Import one times only
                        }
                    }
                }

                TextField {
                    id: txtExcelTimer
                    x: 396
                    width: 70
                    height: 31
                    anchors.right: textAuto2.left
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignRight
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 0
                    placeholderText: qsTr("")
                    validator: IntValidator {bottom: 1; top: 99999999}
                }

                Text {
                    id: textAuto
                    x: 265
                    width: 130
                    height: 31
                    text: qsTr("Auto import again after ")
                    anchors.right: txtExcelTimer.left
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 0
                }

                Text {
                    id: textAuto2
                    x: 538
                    width: 65
                    height: 31
                    text: qsTr(" second(s).")
                    anchors.right: btnExcelImport.left
                    anchors.top: cbboxExcelSheet.bottom
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 10
                    anchors.rightMargin: 20
                }
            }

            Page {
                id: pageCSV
                height: 200
                visible: false
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: tabBar.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                background: Rectangle{
                    color: "#E7E2FF"
                }

                TableView {
                    id: tblCSVView
                    y: 0
                    height: 100
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: tabBar.bottom
                    anchors.topMargin: 5
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    clip: true
                    // boundsBehavior: Flickable.StopAtBounds
                    visible: false
                    z: 3
                    columnWidthProvider: function (column) { return 100; }
                    rowHeightProvider: function (column) { return 50; }
                    leftMargin: rowsCSVHeader.implicitWidth
                    topMargin: columnsCSVHeader.implicitHeight
                    model: csv_model
                    delegate: Rectangle {
                        Text {
                            id: txtCSVData
                            text: display
                            anchors.fill: parent
                            anchors.margins: 10
                            color: '#000000'
                            font.pixelSize: 15
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle { // mask the headers
                        z: 3
                        color: "#d3d3d3"
                        y: tblCSVView.contentY
                        x: tblCSVView.contentX
                        width: tblCSVView.leftMargin
                        height: tblCSVView.topMargin
                    }

                    Row {
                        id: columnsCSVHeader
                        y: tblCSVView.contentY
                        z: 2
                        Repeater {
                            model: tblCSVView.columns > 0 ? tblCSVView.columns : 1
                            Label {
                                width: tblCSVView.columnWidthProvider(modelData)
                                height: 45
                                text: csv_model.headerData(modelData, Qt.Horizontal)
                                color: '#ffffff'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                background: Rectangle { color: "#298AD4" }
                            }
                        }
                    }

                    Row{
                        id: rowsCSVData
                        y: tblCSVView.contentY + columnsCSVHeader.height
                        z: 2
                        Repeater{
                            model: tblCSVView
                            Label {
                                width: 45
                                height: 45
                                text: csv_model.data(modelData)
                                color: '#aaaaaa'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    Column {
                        id: rowsCSVHeader
                        x: tblCSVView.contentX
                        z: 2
                        Repeater {
                            model: tblCSVView.rows > 0 ? tblCSVView.rows : 1
                            Label {
                                width: 45
                                height: tblCSVView.rowHeightProvider(modelData)
                                text: csv_model.headerData(modelData, Qt.Vertical)
                                color: '#000000'
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                background: Rectangle { color: "#FCF6D0" }
                            }
                        }
                    }
                    ScrollIndicator.horizontal: ScrollIndicator { }
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                NormalButton {
                    id: btnOpenCSVFile
                    y: 114
                    width: 140
                    height: 31
                    z: 5
                    text: "Open File"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    onClicked: {
                        fileCSVDialog.open()
                    }

                    FileDialog{
                        id: fileCSVDialog
                        title: "Select a file"
                        folder: shortcuts.desktop
                        selectMultiple: false
                        nameFilters: ["CSV Files (*.csv)"]
                        onAccepted: {
                            tblCSVView.visible = true
                            backend.openCSVFile(fileCSVDialog.fileUrl)
                        }
                    }
                }

                NormalButton{
                    id: btnCSVImport
                    x: 638
                    y: 160
                    width: 110
                    height: 31
                    z: 5
                    text: "Import CSV"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 20
                    anchors.bottomMargin: 10
                    onClicked: {

                        if (txtCSVTimer.length != 0){
                            backend.autoImport('csv', txtCSVTimer.text) // Auto import
                        }
                        else {
                            backend.importCSVData() // Import one times only
                        }
                    }
                }

                TextField {
                    id: txtCSVTimer
                    x: 396
                    width: 70
                    height: 31
                    anchors.right: textAuto4.left
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignRight
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 10
                    placeholderText: qsTr("")
                    validator: IntValidator {bottom: 1; top: 99999999}
                }

                Text {
                    id: textAuto3
                    x: 265
                    width: 130
                    height: 31
                    text: qsTr("Auto import again after ")
                    anchors.right: txtCSVTimer.left
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 0
                }

                Text {
                    id: textAuto4
                    x: 538
                    width: 65
                    height: 31
                    text: qsTr(" second(s).")
                    anchors.right: btnCSVImport.left
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 20
                }
            }
        }
    }

    Connections{
        target: backend

        function onSignalConnStatus(connection){
            if (connection === false){
                msgboxConnectDB.visible = true
                msgboxConnectDB.msgBoxContent = "Connection failed. Please check your network and try again."
            }
            else{
                msgboxConnectDB.visible = true
                msgboxConnectDB.msgBoxContent = "Connected successfully. Database configuration was saved."
                backend.displayTables() // Display all tables name in database to combobox
                backend.getTableSelected(cbboxTables.currentText) // Get data of first table
            }
        }

        function onSignalSettingList(settings){
            txtServerName.text = settings[1]
            txtDatabaseName.text = settings[2]
            txtUserName.text = settings[3]
            txtPassword.text = settings[4]
        }

        function onSignalTableSelected(status){
            if (status){
                tblDatabase.visible = true // Show data when user choose table
            }
        }

        function onSignalOpenFile(sheet_names){
            cbboxExcelSheet.model = sheet_names
        }  
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:1260}D{i:6}D{i:18}D{i:19}
}
##^##*/
