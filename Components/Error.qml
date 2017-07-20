import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "error"
    property color buttonColor
    property alias errorHeight: root.height
    property alias errorWidth: root.width
    property alias errorText: info_text.text

    color: "#00000000"

    Rectangle {
        color: "black"
        id: temp_background
        anchors.fill: parent
        radius: 40
        opacity: 0.2
        z: 3
    }

    Text {
        id: info_text
        anchors.top: temp_background.top
        anchors.left: temp_background.left
        anchors.topMargin: 40
        anchors.leftMargin: 40
        width: temp_background.width-(40*2)
        height: temp_background.height-(40*2)
        font.pointSize: 20
        wrapMode: Text.Wrap
    }
}
