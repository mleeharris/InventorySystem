import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "scan_page"

    signal nextLayer(string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"
    }

    states: [
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

    Image {
        id: background_image
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: please_scan
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        text: "ID  Card"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 200
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        label.text: "Power"
        onClicked: {
            slot_switchLayer("first_main")
            root.state = "hidden"
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: right_tab.left
        anchors.rightMargin: global_vars.tabSpace
        id: middle_tab
        label.text: "Back"
        onClicked: {
            slot_switchLayer("main")
            root.state = "hidden"
        }
    }
}


