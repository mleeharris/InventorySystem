import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars
import "qrc:/JavaScript/connect.js" as Connect

Rectangle {
    id: root
    visible: true
    width: global_vars.tempWidth
    height: global_vars.tempHeight
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
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: title_text
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(180)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Select An Option"
        font.family: "Bebas Neue"
        color: "Black"
        font.pointSize: global_vars.display(200)
    }

    Text {
        id: username
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(60)
        anchors.left: parent.left
        anchors.leftMargin: global_vars.display(70)
        text: global_vars.username
        font.family: "Helvetica"
        color: "Black"
        font.pointSize: global_vars.display(40)
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: check_out_button.top
        anchors.bottomMargin: global_vars.display(25)
        height: check_out_button.height
        id: check_in_button
        label.text: "Check In"

        location: "qrc:/Images/check_in_button.png"
        iconHeight: global_vars.check_in_height
        iconAnchors.verticalCenterOffset: global_vars.check_in_offset

        onClicked: {
            global_vars.checkoutpage_error = ''
            global_vars.checkinpage_error = ''
            nextLayer(root.objectName, "check_in")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: global_vars.display(135)
        height: global_vars.buttonHeight-global_vars.display(20)
        id: check_out_button
        label.text: "Check Out"

        location: "qrc:/Images/logout_sign_flipped.png"
        iconHeight: global_vars.check_out_height
        iconAnchors.verticalCenterOffset: global_vars.check_out_offset

        onClicked: {
            global_vars.checkoutpage_error = ''
            global_vars.checkinpage_error = ''
            nextLayer(root.objectName, "check_out")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: check_in_button.top
        anchors.bottomMargin: global_vars.display(25)
        height: check_out_button.height
        id: lookup_button
        label.text: "Lookup"

        location: "qrc:/Images/magnifier.png"
        iconHeight: global_vars.check_out_height-global_vars.display(30)
        iconAnchors.verticalCenterOffset: global_vars.check_out_offset

        onClicked: {
            nextLayer(root.objectName, "lookup")
            root.state = "hidden"
        }
    }

    Clock {
        id: clock_check
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
            global_vars.checkpage_error = 'Logging Out...'
            Connect.logoutQuit(global_vars.username, global_vars.realpass)
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

    Error {
        id: check_error
        errorHeight: global_vars.display(150)
        errorWidth: middle_tab.width
        errorText: global_vars.checkpage_error
        z: 1

        anchors.left: middle_tab.left
        anchors.bottom: middle_tab.top
        anchors.bottomMargin: global_vars.display(40)
    }

    /***********************************************************************/
    // Controls tab operation from check page. Called from main.qml
    /***********************************************************************/
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
}


