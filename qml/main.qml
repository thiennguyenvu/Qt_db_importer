import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.0
import "controls"
import "pages"


Window {
    id: app
    // Properties #53A1DC #298AD4 #3E95D8
    property var app_version: "1.0"
    property bool dark_mode: false
    property var title_color: "#298AD4"
    property var title_light_color: "#cbe2f4"
    property var left_menu_color: "#FCF6D0"
    property var page_color: "#E5F0F9"
    property var frame_bordercolor: "#69A8DD"

    property int windowStatus: 0
    property int windowMargin: 7

    QtObject{
        id: internal

        function maximizeRestore(){
            if (windowStatus == 0){
                app.showMaximized()
                windowStatus = 1
                windowMargin = 0
                row_top_btn.anchors.topMargin = 0
                row_top_btn.anchors.rightMargin = 0
                btnMaximize.btnIconSource = "../images/svg_images/restore_icon.svg"

                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeTop.visible = false
                resizeBottom.visible = false
            } else{
                app.showNormal()
                windowStatus = 0
                windowMargin = 7
                row_top_btn.anchors.topMargin = -7
                row_top_btn.anchors.rightMargin = -7
                btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"

                // Resize visibility
                resizeLeft.visible = true
                resizeRight.visible = true
                resizeTop.visible = true
                resizeBottom.visible = true
            }
        }

        function ifMaximizeWindowRestore(){
            if (windowStatus == 1){
                app.showNormal()
                windowStatus = 1
                windowMargin = 0
                row_top_btn.anchors.topMargin = 0
                row_top_btn.anchors.rightMargin = 0
                btnMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }
    }

    width: 1260
    height: 640
    minimumWidth: 1260
    minimumHeight: 640
    visible: true
    title: qsTr("DB Importer")
    // Remove default title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: app_bg
        x: 10
        y: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: rect_left_sidebar
            width: 220
            height: app.height
            color: left_menu_color
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.leftMargin: 0

            PropertyAnimation{
                id: animationLeftMenu
                target: rect_left_sidebar
                property: "width"
                to: rect_left_sidebar.width == 75 ? 220 : 75
                duration: 250
                easing.type: Easing.InOutQuint
            }

            ToggleButton{
                id: btnLogo
                height: 82
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: -7
                onClicked: {
                    animationLeftMenu.running = true
                    if (rect_left_sidebar.width == 75){
                        btnLogo.width = 220
                        btnLogo.imgIconWidth = 210
                        btnLogo.imgIconHeight = 80
                        btnLogo.btnIconSource = "../images/logo_horizontal.png"
                    }
                    else {
                        btnLogo.width = 75
                        btnLogo.imgIconWidth = 60
                        btnLogo.imgIconHeight = 60
                        btnLogo.btnIconSource = "../images/logo.png"
                    }
                }
            }

            Column {
                id: colLeftMenu
                width: rect_left_sidebar.width
                height: parent.height - btnLogo.height
                visible: true
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 75
                anchors.leftMargin: 0
                clip: true

                LeftMenuButton{
                    id: btnHome
                    width: rect_left_sidebar.width
                    text: qsTr("Home")
                    isActiveMenu: true
                    btnColorDefault: "#F9EDA0"
                    onClicked: {
                        btnSettings.isActiveMenu = false
                        btnSettings.btnColorDefault = left_menu_color
                        btnHome.isActiveMenu = true
                        btnHome.btnColorDefault = "#F9EDA0"
                        stackViewContent.push(Qt.resolvedUrl("pages/homePage.qml"))
                    }
                }

                LeftMenuButton {
                    id: btnOpen
                    width: rect_left_sidebar.width
                    text: qsTr("Open File")
                    btnIconSource: "../images/svg_images/open_icon.svg"

                    onPressed: {
                        fileOpen.open()
                    }

                    FileDialog{
                        id: fileOpen
                        title: "Select a file"
                        folder: '../data/'
                        selectMultiple: false
                        nameFilters: ["All File (*)"]
                        onAccepted: {
                            backend.openFile(fileOpen.fileUrl)
                        }
                    }
                }

                LeftMenuButton {
                    id: btnSave
                    width: rect_left_sidebar.width
                    text: qsTr("New Window")
                    btnIconSource: "../images/svg_images/save_icon.svg"
                    onClicked: {
                        var component = Qt.createComponent("../child.qml")
                        var window = component.createObject(app)
                        window.show()
                    }
                }
            }

            LeftMenuButton {
                id: btnSettings
                width: rect_left_sidebar.width
                text: qsTr("Settings")
                anchors.bottom: parent.bottom
                clip: true
                anchors.bottomMargin: 25
                btnIconSource: "../images/svg_images/settings_icon.svg"
                onClicked: {
                    btnHome.isActiveMenu = false
                    btnHome.btnColorDefault = left_menu_color
                    btnSettings.isActiveMenu = true
                    btnSettings.btnColorDefault = "#F9EDA0"
                    stackViewContent.push(Qt.resolvedUrl("pages/settingsPage.qml"))
                }
            }
        }

        Rectangle {
            id: rect_top_bar
            height: 75
            color: title_light_color
            anchors.left: rect_left_sidebar.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.rightMargin: 0

            Rectangle{
                id: tittleBar
                height: 40
                color: title_color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: -7
                anchors.rightMargin: 0

                DragHandler{
                    onActiveChanged: if (active) { app.startSystemMove() }
                }

                Text {
                    id: app_title
                    x: 50
                    y: 7
                    width: auto
                    height: parent.height
                    color: "#ffffff"
                    text: qsTr("DB Importer " + app_version)
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Text {
                id: txt_Filter
                text: qsTr("")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 45
                anchors.leftMargin: 55
            }
        }

        Rectangle{
            id: contentPages
            color: page_color
            anchors.left: rect_left_sidebar.right
            anchors.right: parent.right
            anchors.top: rect_top_bar.bottom
            anchors.bottom: rect_bottom_bar.top
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            clip: true

            StackView {
                id: stackViewContent
                anchors.fill: parent
                anchors.bottomMargin: 32
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                initialItem: Qt.resolvedUrl("pages/homePage.qml")
            }
        }

        Row {
            id: row_top_btn
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -7
            anchors.leftMargin: 1086
            anchors.topMargin: -7

            TopBarButton {
                id: btnMinimize
                anchors.right: btnMaximize.left
                onClicked: app.showMinimized()
            }

            TopBarButton {
                id: btnMaximize
                anchors.right: btnQuit.left
                btnIconSource: "../images/svg_images/maximize_icon.svg"
                onClicked: internal.maximizeRestore()
            }

            TopBarButton {
                id: btnQuit
                anchors.right: parent.right
                anchors.rightMargin: 0
                btnIconSource: "../images/svg_images/close_icon.svg"
                btnColorMouseOver: "#FF3232"
                onClicked: app.close()
            }
        }

        Rectangle {
            id: rect_bottom_bar
            height: 32
            color: title_light_color
            anchors.left: rect_left_sidebar.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            Text {
                id: txt_bottom_bar
                text: qsTr("")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.leftMargin: 55
            }
        }
    }

    DropShadow {
        x: 1100
        y: 7
        anchors.fill: app_bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 30
        samples: 16
        color: frame_bordercolor // #b3b300, #d0e3fc
        source: app_bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { app.startSystemResize(Qt.LeftEdge)}
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { app.startSystemResize(Qt.RightEdge)}
        }
    }

    MouseArea {
        id: resizeTop
        height: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: parent.left
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { app.startSystemResize(Qt.TopEdge)}
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { app.startSystemResize(Qt.BottomEdge)}
        }
    }

    MouseArea{
        id: resizeWindow
        x: 1240
        y: 560
        width: 40
        height: 40
        z: 2
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeFDiagCursor

        DragHandler{
            target: null
            onActiveChanged: if (active){
                                 app.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                             }
        }

        Image {
            id: resizeImage
            width: resizeWindow.width
            height: resizeWindow.height
            opacity: 0.5
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            source: "../images/svg_images/resize_icon.svg"
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
