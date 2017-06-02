import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/Components"

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "logged_in"

    signal nextLayer(string nextLayer)
    signal tabOperationCheckOut(string tabnum, string state)

    Component.onCompleted: {
        //root.state = "hidden"
        root.state = "visible"

        check_out.tabOperationCheck.connect(tabOperationCheck)
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
        id: title_text
        anchors.top: parent.top
        anchors.topMargin: 180
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Select An Option"
        font.family: "Bebas Neue"
        color: "Black"
        font.pointSize: 200
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: check_out_button.top
        anchors.bottomMargin: 30
        id: check_in_button
        label.text: "Check In"

        onClicked: {
            //slot_switchLayer("check_in")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 200
        id: check_out_button
        label.text: "Check Out"

        onClicked: {
            tabOperationCheckOut("right", "Down")
            slot_switchLayer("check_out")
            root.state = "hidden"
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        label.text: "Power"
        onClicked: {
            Qt.quit()
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

    function tabOperationCheck(tabnum, state) {
        if (tabnum === "right") {
            if (state === "Up") {
                right_tab.state = "Up"
            }
            if (state === "Down") {
                right_tab.state = "Down"
            }
        }
    }
}


