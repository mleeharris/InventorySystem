import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "button"
    property alias label: button_txt
    property color buttonColor
    clip:false
    signal pressed()
    signal released()
    signal clicked()

    height: global_vars.buttonHeight
    width: global_vars.buttonWidth
    radius: height/2
    border.width: 4
    border.color: "black"

    color: buttonColor

    FontLoader{
        id: default_font
        name: "BebasNeue"
        source: "qrc:/Typefaces/BebasNeue.otf"
    }

    Text {
        id: button_txt
        anchors.left: root.left
        anchors.top: root.top
        anchors.right: root.right
        anchors.bottom: root.bottom
        font.family: "BebasNeue"
        text: ""
        font.pointSize: global_vars.buttonSize
        smooth: true
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: btn_ma
        anchors.fill: root
        onPressed: {
            root.pressed()
            root.color = "black"
            button_txt.color = buttonColor
        }

        onReleased: {
            root.released()
            root.color = buttonColor
            button_txt.color = "black"
        }

        onClicked: {
            root.clicked()
        }
    }
}
