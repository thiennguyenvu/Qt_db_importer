import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnLeftMenu
    text: qsTr("Home")
    display: AbstractButton.IconOnly

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
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
        property var dynamicColor: if (btnLeftMenu.down){
                                       btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
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

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            antialiasing: false
            color: "#000000"
        }

        Text {
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
