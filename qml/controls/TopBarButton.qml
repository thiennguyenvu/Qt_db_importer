import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnTopBar

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#FCF6D0"
    property color btnColorMouseOver: "#F9EDA0"
    property color btnColorClicked: "#ffffff"


    QtObject {
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if (btnTopBar.down){
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 60
    implicitHeight: 30

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            antialiasing: false
            color: "black"
        }
    }
}
