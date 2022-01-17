import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.0
import "qml/controls"
import "qml/pages"


Window {
    id: child_window
    // Properties #53A1DC #298AD4 #3E95D8
    property string window_title: "Window"
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
                child_window.showMaximized()
                windowStatus = 1
                windowMargin = 0
                row_top_btn.anchors.topMargin = 0
                row_top_btn.anchors.rightMargin = 0
                btnMaximize.btnIconSource = "images/svg_images/restore_icon.svg"

                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeTop.visible = false
                resizeBottom.visible = false
            } else{
                child_window.showNormal()
                windowStatus = 0
                windowMargin = 7
                row_top_btn.anchors.topMargin = -7
                row_top_btn.anchors.rightMargin = -7
                btnMaximize.btnIconSource = "images/svg_images/maximize_icon.svg"

                // Resize visibility
                resizeLeft.visible = true
                resizeRight.visible = true
                resizeTop.visible = true
                resizeBottom.visible = true
            }
        }

        function ifMaximizeWindowRestore(){
            if (windowStatus == 1){
                child_window.showNormal()
                windowStatus = 1
                windowMargin = 0
                row_top_btn.anchors.topMargin = 0
                row_top_btn.anchors.rightMargin = 0
                btnMaximize.btnIconSource = "images/svg_images/maximize_icon.svg"
            }
        }
    }

    width: 600
    height: 200
    minimumWidth: 400
    minimumHeight: 200
    visible: true
    title: qsTr("Child Window")
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
            id: rect_top_bar
            height: 75
            color: title_light_color
            anchors.left: parent.left
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
                    onActiveChanged: if (active) { child_window.startSystemMove() }
                }

                Text {
                    id: app_title
                    width: child_window.width
                    anchors.left: parent.width
                    anchors.right: parent.width
                    anchors.fill: parent
                    color: "#ffffff"
                    text: window_title
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
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
            y: rect_top_bar.height
            color: page_color
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rect_top_bar.bottom
            anchors.bottom: rect_bottom_bar.top
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            clip: true
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
                anchors.right: btnQuit.left
                onClicked: child_window.showMinimized()
            }

            TopBarButton {
                id: btnQuit
                anchors.right: parent.right
                anchors.rightMargin: 0
                btnIconSource: "images/svg_images/close_icon.svg"
                btnColorMouseOver: "#FF3232"

                onClicked: child_window.close()
            }
        }

        Rectangle {
            id: rect_bottom_bar
            height: 32
            color: title_light_color
            anchors.left: parent.left
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
            onActiveChanged: if (active) { child_window.startSystemResize(Qt.LeftEdge)}
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
            onActiveChanged: if (active) { child_window.startSystemResize(Qt.RightEdge)}
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
            onActiveChanged: if (active) { child_window.startSystemResize(Qt.TopEdge)}
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
            onActiveChanged: if (active) { child_window.startSystemResize(Qt.BottomEdge)}
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
                                 child_window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
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
            source: "images/svg_images/resize_icon.svg"
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:6}
}
##^##*/
