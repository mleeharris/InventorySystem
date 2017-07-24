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
    objectName: "scan_page"

    signal nextLayer(string currentLayer, string nextLayer)

    property string err_msg

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
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

    Clock {
        id: clock_scanpage
    }

    Image {
        id: background_image
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: admin_console
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Admin  RFID"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 100
    }


    Error {
        id: scanpage_error
        height: 250
        width: 700
        errorText: global_vars.admin_error
        z: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }

    Text {
        id: active_check
        anchors.horizontalCenter: scanpage_error.horizontalCenter
        anchors.bottom: scanpage_error.top
        anchors.bottomMargin: 20
        text: "No card actively placed"
        font.family: "Helvetica"
        font.pixelSize: 36
    }

    ButtonInput {
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.top: admin_console.bottom
        anchors.topMargin: 20
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        id: addkey_button
        label.text: "Add  Key"

        helpText: "12 HEX values needed (FFFFFFFFFFFF is key)"
        maxLength: 12

        onClicked: {
            if (thread.activeGet() === 0) {
                testing.addKey(inputText, "00")
                global_vars.admin_error = testing.getMsg()
            }
            if (thread.activeGet() === 1) {
                if (inputText.length == 0) {
                    global_vars.admin_error = "Error: No key entered"
                }
                if (inputText.length > 0) {
                    //testing.addKey("FFFFFFFFFFFF", "00")
                    testing.addKey(inputText, "00")
                    global_vars.admin_error = testing.getMsg()
                }
            }
        }
    }

    ButtonInput {
        anchors.left: addkey_button.left
        anchors.leftMargin: addkey_button.leftMargin
        anchors.top: addkey_button.bottom
        anchors.topMargin: 20
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        id: auth_button
        label.text: "Authorize"

        helpText: "Enter 04 for user/pass"
        maxLength: 2

        onClicked: {
            if (thread.activeGet() === 0) {
                global_vars.admin_error = ""
            }
            if (thread.activeGet() === 1) {
                if (inputText.length == 0) {
                    global_vars.admin_error = "Error: No authorization block entered"
                }
                if (inputText.length > 0) {
                    testing.auth(inputText)
                    global_vars.admin_error = testing.getMsg()
                }
            }
        }
    }

    ButtonInput {
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 30
        anchors.top: admin_console.bottom
        anchors.topMargin: 20
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        id: username
        label.text: "Set  User"

        helpText: "Type Username Above"
        maxLength: 15

        onClicked: {
            if (thread.activeGet() === 0) {
                global_vars.admin_error = ""
            }
            if (thread.activeGet() === 1) {
                if (inputText.length == 0) {
                    global_vars.admin_error = "Error: No username entered"
                }
                if (inputText.length > 0) {
                    thread.userChange(inputText)
                    testing.updateBlock("04", inputText)
                    global_vars.admin_error = testing.getMsg()
                    GlobVars.userpass = testing.readCard()
                    splituserpass()
                }
            }
        }
    }

    ButtonInput {
        anchors.left: username.left
        anchors.leftMargin: username.leftMargin
        anchors.top: username.bottom
        anchors.topMargin: 20
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        id: password
        label.text: "Set  Pass"

        helpText: "Type Password Above"
        maxLength: 15

        onClicked: {
            if (thread.activeGet() === 0) {
                global_vars.admin_error = ""
            }
            if (thread.activeGet() === 1) {
                if (inputText.length == 0) {
                    global_vars.admin_error = "Error: No password entered"
                }
                if (inputText.length > 0) {
                    thread.passChange(inputText)
                    testing.updateBlock("05", inputText)
                    global_vars.admin_error = testing.getMsg()
                    GlobVars.userpass = testing.readCard()
                    splituserpass()
                }
            }
        }
    }

    BasicButton {
        id: readall
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 140
        anchors.topMargin: 100
        height: 100
        width: 250
        label.text: "Print"

        onClicked: {
            if (thread.activeGet() === 0) {
                global_vars.admin_error = "Error: No card connected"
            }
            if (thread.activeGet() === 1) {
                global_vars.admin_error = '';
                testing.readBlock("04")
                global_vars.admin_error += testing.getMsg()
                global_vars.admin_error += '\n'
                testing.readBlock("05")
                global_vars.admin_error += testing.getMsg()
                global_vars.admin_error += '\n'
                testing.readBlock("07")
                global_vars.admin_error += testing.getMsg()
            }
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
            global_vars.admin_error = "Logging Out..."
            Connect.logout(global_vars.username, global_vars.realpass)
            clock_scanpage.delay(1000, function() {
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
            nextLayer(root.objectName, "admin_selection")
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

    function updateActive() {
        if (thread.activeGet() === 0) {
            if (global_vars.admin_error != "Logging Out...")
            global_vars.admin_error = '';
            active_check.text = 'No card actively connected'
        }
        if (thread.activeGet() === 1) {
            active_check.text = 'Card is ready for updates'
        }
    }
}


