import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle{
    id: msgbox
    width: 380
    height: 200
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.rightMargin: 20
    anchors.leftMargin: 20
    color: "#cbe2f4"

    property var msgBoxTitle: "Message"
    property var msgBoxContent: "This is custom message layout"
    property var txtBtnOK: "OK"

    QtObject{

    }

    Rectangle {
        id: msgbox_title
        height: 30
        color: "#298AD4"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: txtMsgBoxTitle
            color: "#ffffff"
            text: msgBoxTitle
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
        }
    }

    Text{
        id: txtMsgBoxContent
        text: msgBoxContent
        height: 90
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: msgbox_title.bottom
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.topMargin: 10
    }

    NormalButton{
        id: btnOK
        x: 219
        y: 116
        width: 125
        height: 35
        text: txtBtnOK
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        onClicked: {
            msgbox.visible = false
        }
    }
}
/*##^##
Designer {
    D{i:0;height:200;width:380}D{i:5}
}
##^##*/
