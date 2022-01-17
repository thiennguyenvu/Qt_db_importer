import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnNormal
    text: qsTr("Home")

    // CUSTOM PROPERTIES
    property color btnColorDefault: "#FCF6D0"
    property color btnColorMouseOver: "#F9EDA0"
    property color btnColorClicked: "#ffffff"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#298AD4"
    property color activeMenuColorRight: "#298AD4"
    property bool isActiveMenu: false

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if (btnNormal.down){
                                       btnNormal.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnNormal.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    width: 220
    height: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Rectangle{
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 5
            visible: isActiveMenu
        }

        Rectangle{
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 3
            visible: isActiveMenu
        }
    }
}
