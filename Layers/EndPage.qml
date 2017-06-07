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

    signal nextLayer(string currentLayer, string nextLayer)
    signal itemFromEnd()

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
        right_tab.state = "Down"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        main_window.tabOperationForEndPage.connect(tabOperationEndPage)
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
        anchors.topMargin: 160
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Action Completed"
        font.family: "Bebas Neue"
        color: "Black"
        font.pointSize: 200
    }

    BasicButton {
        id: check_in_button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 475
        height: global_vars.buttonHeight
        width: global_vars.buttonHeight*4

        label.text: "Check In"

        location: "qrc:/Images/check_in_button.png"
        iconHeight: global_vars.check_in_height
        iconAnchors.verticalCenterOffset: global_vars.check_in_offset

        onClicked: {
            nextLayer(root.objectName, "check_in")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: check_in_button.bottom
        anchors.topMargin: 20
        anchors.left: check_in_button.left
        height: check_in_button.height
        width: check_in_button.width
        id: check_out_button
        label.text: "Check Out"

        location: "qrc:/Images/logout_sign_flipped.png"
        iconHeight: global_vars.check_out_height
        iconAnchors.verticalCenterOffset: global_vars.check_out_offset

        onClicked: {
            nextLayer(root.objectName, "check_out")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: check_out_button.bottom
        anchors.topMargin: 20
        anchors.left: check_out_button.left
        height: check_out_button.height
        width: check_out_button.width
        id: start_over_button
        label.text: "Start Over"

        location: "qrc:/Images/update_arrow.png"
        iconHeight: global_vars.startover_height
        iconAnchors.verticalCenterOffset: global_vars.startover_offset

        onClicked: {
            itemFromEnd()
            root.state = "hidden"
            nextLayer(root.objectName, "main")
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        //label.text: "Power"
        location: "qrc:/Images/power.png"
        onPressed: {
            location = "qrc:/Images/power_dark.png"
        }
        onReleased: {
            location = "qrc:/Images/power.png"
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
        z: 4
        //label.text: "Back"
        location: "qrc:/Images/back.png"
        onPressed: {
            location = "qrc:/Images/back_dark.png"
        }
        onReleased: {
            location = "qrc:/Images/back.png"
        }
        onClicked: {
            nextLayer(root.objectName, "check_out")
            root.state = "hidden"
        }
    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 450
        width: 500
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
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
        text: "boiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboiboi"
    }

    function tabOperationEndPage(tabnum, state) {
        if (tabnum === "middle") {
            if (state === "Up") {
                middle_tab.state = "Up"
            }
            if (state === "Down") {
                middle_tab.state = "Down"
            }
        }
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
