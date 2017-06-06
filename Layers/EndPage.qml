import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/JavaScript"
import "qrc:/Components"
import "qrc:/JavaScript/componentCreation.js" as Creation
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "end_page"

    signal nextLayer(string nextLayer)
    signal tabOperationFromEnd(string tabnum, string state)
    signal itemFromEnd()

    Component.onCompleted: {
        root.state = "hidden"
        middle_tab.state = "Up"
        right_tab.state = "Down"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        check_in.tabOperationFromCheckIn.connect(tabOperationEndPage)
        check_out.tabOperationFromCheckOut.connect(tabOperationEndPage)
    }

    ScannedItem{id: scanned_item}

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
        text: "Action Completed"
        font.family: "Bebas Neue"
        color: "Black"
        font.pointSize: 200
    }

    BasicButton {
        anchors.top: check_out_button.bottom
        anchors.topMargin: 20
        anchors.left: check_out_button.left
        height: check_out_button.height
        width: check_out_button.width
        id: check_in_button
        label.text: "Check In"

        onClicked: {
            tabOperationFromEnd("right", "Down")
            tabOperationFromEnd("middle","Up")
            tabOperationEndPage("right", "Down")
            tabOperationEndPage("middle","Up")
            nextLayer("check_in")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 400
        height: 100
        width: global_vars.buttonHeight*3
        id: check_out_button
        label.text: "Check Out"

        onClicked: {
            tabOperationFromEnd("right", "Down")
            tabOperationFromEnd("middle","Up")
            tabOperationEndPage("right", "Down")
            tabOperationEndPage("middle", "Up")
            nextLayer("check_out")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: check_in_button.bottom
        anchors.topMargin: 20
        anchors.left: check_out_button.left
        height: check_out_button.height
        width: check_out_button.width
        id: start_over_button
        label.text: "Start Over"

        onClicked: {
            itemFromEnd()
            tabOperationFromEnd("middle","Down")
            root.state = "hidden"
            nextLayer("main")
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        //label.text: "Power"
        location: "qrc:/Images/power_gray.png"
        onPressed: {
            location = "qrc:/Images/power_darkgray.png"
        }
        onReleased: {
            location = "qrc:/Images/power_gray.png"
        }
        onClicked: {
            Qt.quit()
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: right_tab.left
        anchors.rightMargin: global_vars.tabSpace
        id: middle_tab
        label.text: "Back"
        onClicked: {
            slot_switchLayer("check_out")
            tabOperationFromEnd("right", "Down")
            root.state = "hidden"
        }
    }

    function tabOperationEndPage(tabnum, state) {
        if (tabnum === "right") {
            if (state === "Up") {
                tabOperationFromEnd("right", "Up")
                right_tab.state = "Up"
            }
            if (state === "Down") {
                tabOperationFromEnd("right", "Down")
                right_tab.state = "Down"
            }
        }
        if (tabnum === "middle") {
            if (state === "Up") {
                tabOperationFromEnd("middle", "Up")
                middle_tab.state = "Up"
            }
            if (state === "Down") {
                tabOperationFromEnd("middle", "Down")
                middle_tab.state = "Down"
            }
        }
    }
}
