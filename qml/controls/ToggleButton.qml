import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnToggle

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/logo_horizontal.png"
    property color btnColorDefault: "#FCF6D0"
    property color btnColorMouseOver: "#ffffff"
    property color btnColorClicked: "#F9EDA0"
    property int imgIconWidth: 210
    property int imgIconHeight: 80
    property Image img: iconBtn

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if (btnToggle.down){
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    width: 220
    height: 75

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: imgIconHeight
            width: imgIconWidth
            fillMode: Image.PreserveAspectFit 
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            antialiasing: false
        }
    }
}
