import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "scan_page"

    signal nextLayer(string currentLayer, string nextLayer)



    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Down"
        right_tab.state = "Up"

        main_window.tabOperationForScanPage.connect(tabOperationScanPage)
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
        text: "Place  RFID"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 200
    }

    BasicButton {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 275
        anchors.horizontalCenter: parent.horizontalCenter
        height: global_vars.buttonHeight
        width: global_vars.buttonWidth
        id: check_in_button
        label.text: "Scan"

        location: "qrc:/Images/rfid_chip.png"
        iconHeight: 92
        iconAnchors.verticalCenterOffset: -5

        onClicked: {
            nextLayer(root.objectName, "logged_in")
            GlobVars.userpass = testing.readCard(04)
            splituserpass()
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
            nextLayer(root.objectName, "main")
            root.state = "hidden"
        }
    }

    function tabOperationScanPage(tabnum, state) {
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

    function userpass(userpass) {
        console.log('userpass: ', userpass)
        userpass = userpass.split(':')
        global_vars.username = userpass[0]
        global_vars.password = userpass[1]
        console.log("username: ", global_vars.username)
        console.log("password: ", global_vars.password)
        root.state = "hidden"
        nextLayer(root.Objectname, "logged_in")
    }

    function splituserpass() {
        GlobVars.userpass = GlobVars.userpass.split('=')
        global_vars.username = GlobVars.userpass[0]

        var increment_length = GlobVars.userpass[1].length
        var i = 0
        global_vars.password = ''
        while (i < increment_length) {
            global_vars.password += GlobVars.star
            i += 1
        }

        global_vars.realpass = GlobVars.userpass[1]
    }
}


