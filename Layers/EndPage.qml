import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/JavaScript"
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars
import "qrc:/JavaScript/connect.js" as Connect

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

    Clock2 {
        id: clock_endpage
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
            global_vars.endpage_error = "Logging Out..."
            Connect.logout(global_vars.username, global_vars.realpass)
            if (clock_endpage.connected === false) {
                clock_endpage.connect( function() {
                    root.state = "hidden"
                    nextLayer(root.objectName, "main")
                })
            }
            clock_endpage.delay(1000)
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
            global_vars.endpage_error = "Logging Out..."
            Connect.logout(global_vars.username, global_vars.realpass)
            clock_endpage.connect( function() {
                Qt.quit()
            })
            clock_endpage.delay(1000)
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

    Error {
        id: endpage_error
        errorHeight: 450
        errorWidth: 500
        errorText: global_vars.endpage_error
        z: 1

        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
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
