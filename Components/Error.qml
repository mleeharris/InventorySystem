import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

/***********************************************************************/
// The object that is the 'error' msgs on each screen.
/***********************************************************************/

Rectangle  {
    id: root
    objectName: "error"
    property color buttonColor
    property alias errorHeight: root.height
    property alias errorWidth: root.width
    property alias errorText: info_text.text
    property alias topMargin: info_text.anchors

    color: "#00000000"

    Rectangle {
        color: "black"
        id: temp_background
        anchors.fill: parent
        radius: global_vars.display(40)
        opacity: 0.2
        z: 3
    }

    Text {
        id: info_text
        anchors.top: temp_background.top
        anchors.left: temp_background.left
        anchors.topMargin: global_vars.display(40)
        anchors.leftMargin: global_vars.display(40)
        width: temp_background.width-(global_vars.display(40)*2)
        height: temp_background.height-(global_vars.display(40)*2)
        font.pointSize: global_vars.display(20)
        wrapMode: Text.Wrap
    }
}
