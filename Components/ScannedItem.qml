import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "button"
    property alias item_id: item_txt
    signal pressed()
    signal released()
    signal clicked()

    property bool created: false

    onCreatedChanged: {
        console.log("created")
        if (created) {
            global_vars.numItems++
        }
    }

    color: "#00000000"
    height: global_vars.itemHeight
    width: global_vars.itemWidth

    Rectangle {
        color: "black"
        opacity: 0.5
        anchors.fill: parent
        radius: global_vars.itemWidth/8
    }

    Text {
        id: item_txt
        anchors.left: root.left
        anchors.top: root.top
        anchors.right: root.right
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize
        smooth: true
        color: global_vars.darkGrayColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: x_holder
        color: "#00000000"
        anchors.right: root.right
        anchors.top: root.top
        height: root.height
        width: root.height

        Image {
            id: x
            height: root.height - (root.height/4)
            width: root.height - (root.height/4)
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/Images/x_gray.png"
        }

        MouseArea {
            id: x_ma
            anchors.fill: parent
            onPressed: {
                root.pressed()
            }
            onReleased: {
                root.released()
            }
            onClicked: {
                root.clicked()
            }
        }
    }
}
