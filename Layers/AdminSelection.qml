import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars
import "qrc:/JavaScript/connect.js" as Connect

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "admin_selection"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        main_window.tabOperationForAdminSelection.connect(tabOperationAdminSelectionPage)
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
        id: admin_selection
        anchors.top: parent.top
        anchors.topMargin: 130
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Admin  Selection"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 150
    }

    Clock {
        id: clock_adminselection
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
            global_vars.admin_selection_error = "Logging Out..."
            Connect.logout(global_vars.username, global_vars.realpass)
            clock_adminselection.delay(1000, function() {
                Qt.quit()
            })
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

    BasicButton {
        id: rfid
        anchors.right: parent.right
        anchors.top: admin_selection.bottom
        anchors.rightMargin: 250
        anchors.topMargin: 20
        height: 150
        width: 650
        label.text: "RFID"

        onClicked: {
            nextLayer(root.objectName, "scan_page")
            root.state = "hidden"
        }
    }

    BasicButton {
        id: api
        anchors.left: parent.left
        anchors.top: admin_selection.bottom
        anchors.leftMargin: 250
        anchors.topMargin: rfid.anchors.topMargin
        height: rfid.height
        width: rfid.width
        label.text: "API"

        onClicked: {
            nextLayer(root.objectName, "admin_api")
            root.state = "hidden"
        }
    }

    Error {
        id: admin_selection_error
        errorHeight: 250
        errorWidth: 700
        errorText: global_vars.admin_selection_error
        z: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }

    function tabOperationAdminSelectionPage(tabnum, state) {
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

    function splituserpass() {
        GlobVars.userpass = GlobVars.userpass.split('=')

        if (GlobVars.userpass[0] == "Error") {
            global_vars.username = ''
            global_vars.realpass = ''
            global_vars.password = ''
            global_vars.login_error = 'Error: Try placing card and scanning again'
        }

        else {
            global_vars.username = GlobVars.userpass[0]

            var increment_length = GlobVars.userpass[1].length
            var i = 0
            global_vars.password = ''
            while (i < increment_length) {
                global_vars.password += GlobVars.star
                i += 1
            }
        global_vars.realpass = GlobVars.userpass[1]
        global_vars.login_error = ''
        }
    }
}


