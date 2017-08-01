import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle  {
    id: root
    objectName: "scanneditem"
    property alias item_id: item_txt
    property alias item_name: name
    property alias item_stock: stock
    property bool checked: false
    signal pressed()
    signal released()
    signal clicked()

    state: "visible"
    states:[
        State {
            name: "visible";
            PropertyChanges {
                target: root;
                visible: true;
                opacity: 1
            }
        },
        State {
            name: "hidden";
            PropertyChanges {
                target: root;
                visible: false;
                opacity: 0
            }
        }
    ]

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
        anchors.leftMargin: 30
        anchors.top: root.top
        anchors.right: root.horizontalCenter
        anchors.rightMargin: 160
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: name
        anchors.left: item_txt.right
        anchors.top: root.top
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - 25
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: stock
        anchors.left: name.right
        anchors.leftMargin: 80
        anchors.top: root.top
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - 25
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: x_holder

        color: "#00000000"
        //color: "white"

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
