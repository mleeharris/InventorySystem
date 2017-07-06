import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "check"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"
        //root.state = "visible"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        main_window.tabOperationForCheck.connect(tabOperationCheck)
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

    Text {
        id: username
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 70
        text: global_vars.username
        font.family: "Helvetica"
        color: "Black"
        font.pointSize: 40
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: check_out_button.top
        anchors.bottomMargin: 25
        height: check_out_button.height
        id: check_in_button
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 135
        height: global_vars.buttonHeight-20
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: check_in_button.top
        anchors.bottomMargin: 25
        height: check_out_button.height
        id: lookup_button
        label.text: "Lookup"

        location: "qrc:/Images/magnifier.png"
        iconHeight: global_vars.check_out_height-30
        iconAnchors.verticalCenterOffset: global_vars.check_out_offset

        onClicked: {
            nextLayer(root.objectName, "lookup")
            root.state = "hidden"
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
            root.state = "hidden"
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: right_tab.left
        anchors.rightMargin: global_vars.tabSpace
        id: middle_tab
        //label.text: "Back"
        location: "qrc:/Images/back.png"
        onPressed: {
            location = "qrc:/Images/back_dark.png"
        }
        onReleased: {
            location = "qrc:/Images/back.png"
        }
        onClicked: {
            nextLayer(root.objectName, "logged_in")
            root.state = "hidden"
        }
    }

    function tabOperationCheck(tabnum, state) {
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

//    function deletionAllIn() {
//        var index = GlobVars.itemListIn.length
//        console.log("index: ", index)
//        var i = 0
//        while (i < index) {
//            item_model.remove(0)
//            i += 1
//        }
//        GlobVars.itemListIn = []
//    }

//    function deletionAllOut() {
//        var index = GlobVars.itemList.length
//        console.log("index: ", index)
//        var i = 0
//        while (i < index) {
//            item_model.remove(0)
//            i += 1
//        }
//        GlobVars.itemList = []
//    }
}


