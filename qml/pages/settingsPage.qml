import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.0

Item {
    id: settingsPage

    Rectangle {
        id: settings_bg
        color: "#e5f0f9"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: settings_title
            height: 40
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 100
            anchors.topMargin: 0
            anchors.leftMargin: 100

            Label {
                id: lblSettings
                text: qsTr("SETTINGS")
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
    }
}
