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
    objectName: "logged_in"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Down"
        right_tab.state = "Up"

        main_window.tabOperationForLoggedIn.connect(tabOperationLoggedIn)
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

    BasicButton {
        anchors.left: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        width: global_vars.buttonWidth/2
        id: login_button
        label.text: "Login"

        location: "qrc:/Images/user.png"
        iconHeight: global_vars.login_height
        iconAnchors.verticalCenterOffset: global_vars.login_offset
        onClicked: {
            tabOperationLoggedIn("middle","Up")
            nextLayer(root.objectName, "check")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.right: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        width: global_vars.buttonWidth/2
        id: scan_button
        label.text: "Scan"

        location: "qrc:/Images/rfid_chip.png"
        iconHeight: 92
        iconAnchors.verticalCenterOffset: -5

        onClicked: {
            GlobVars.userpass = testing.readCard(04)
            splituserpass()
        }
    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 150
        width: login_button.width
        anchors.left: login_button.left
        anchors.bottom: login_button.top
        anchors.bottomMargin: 20
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
        text: "Yoooooooooooooo"
    }

    property int wrapperHeight: 800
    property int wrapperWidth: 1700

    property int wrapperSize: wrapperHeight/7
    property int vertSpacing: wrapperHeight/9
    property int horizSpacing: wrapperWidth/6
    property int boxHeight: wrapperHeight/5
    property int boxLength: wrapperWidth/2

    Rectangle {
        id: userpass_wrapper
        color: "#00000000"
        width: wrapperHeight
        height: wrapperWidth
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 165
        anchors.leftMargin: 200

        Column {
            id: labels
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: parent.left
            spacing: vertSpacing

            z: 1

            Rectangle {
                id: user_label
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: "Username: "
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }

            Rectangle {
                id: pass_label
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: "Password: "
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }
        }

        Column {
            id: info
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: labels.right
            anchors.leftMargin: horizSpacing
            spacing: vertSpacing

            z: 3

            Rectangle {
                id: user_info
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: global_vars.username
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }

            Rectangle {
                id: pass_info
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: global_vars.password
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }
        }

        Column {
            id: white_boxes
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: labels.right
            anchors.leftMargin: horizSpacing - (wrapperSize/2)
            spacing: vertSpacing

            z: 2

            Rectangle {
                id: white_box_1
                color: "white"
                height: boxHeight
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4
                radius: height/2
            }

            Rectangle {
                color: "white"
                height: boxHeight
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4
                radius: height/2
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

    function tabOperationLoggedIn(tabnum, state) {
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


