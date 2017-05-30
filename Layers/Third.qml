import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"

Rectangle {
    id: root
    visible: true
    width: 834
    height: 460
    objectName: "third"

    signal nextLayer(string nextLayer)

    Rectangle {
        id: object_holder
        anchors.fill: parent
        color: "#3eb489"
    }

    Component.onCompleted: {
        root.state = "hidden"
    }

    /*LAYER DECL*/

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

    BasicButton {
        height: 80
        width: 160
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        label.text: "Back"
        buttonColor: object_holder.color
        onClicked: {
            slot_switchLayer("main")
            root.state = "hidden"
        }
    }
}
