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

    Timer {
        id: timer
    }

//    Rectangle {
//        color: 'red'
//        height: 100
//        width: 100
//        x: 10
//        y: 10
//        id: admin_button

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                root.state = "hidden"
//                nextLayer(root.objectName, "scan_page")
//            }
//        }
//    }

//    Rectangle {
//        color: 'blue'
//        height: 100
//        width: 100
//        anchors.top: parent.top
//        anchors.right: parent.right
//        anchors.margins: 10
//        id: admin_button

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                console.log('bum')
//                Connect.test()
//            }
//        }
//    }

    BasicButton {
        anchors.horizontalCenter: temp_background.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        width: temp_background.width
        id: login_button
        label.text: "Login"

        location: "qrc:/Images/user.png"
        iconHeight: global_vars.login_height
        iconAnchors.verticalCenterOffset: global_vars.login_offset
        onClicked: {
            //Connect.test()
            Connect.login(global_vars.username, global_vars.realpass)
            console.log("global_vars.loggedIn: ", global_vars.loggedIn)
            global_vars.login_error = "Logging in"
            delay(1000, function() {
                global_vars.login_error = ''

                if (global_vars.username === "admin" && global_vars.realpass === "abc123pass") {
                    nextLayer(root.objectName, "admin_selection")
                    root.state = "hidden"
                }
                else if (global_vars.loggedIn == 1) {
                    nextLayer(root.objectName, "check")
                    root.state = "hidden"
                }
                else {
                    global_vars.login_error = "Error: Username or password not correct. Try removing card and placing again"
                }
            })
        }
    }

//    BasicButton {
//        anchors.right: parent.horizontalCenter
//        anchors.rightMargin: 15
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 120
//        width: global_vars.buttonWidth/2
//        id: scan_button
//        label.text: "Scan"

//        location: "qrc:/Images/rfid_chip.png"
//        iconHeight: 92
//        iconAnchors.verticalCenterOffset: -5

//        onClicked: {
//            //console.log("thread.updateGet(): " + thread.updateGet())
//            if (thread.updateGet() === "Error") {
//                GlobVars.userpass = testing.readCard()
//                splituserpass()
//            }
//        }
//    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 150
        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: login_button.top
        anchors.bottomMargin: 15
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
        text: global_vars.login_error
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
        anchors.topMargin: 140
        anchors.leftMargin: 180

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
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4 + 80
                radius: height/2
            }

            Rectangle {
                color: "white"
                height: boxHeight
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4 + 80
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

        if (GlobVars.userpass[0] == "Error") {
            global_vars.username = ''
            global_vars.realpass = ''
            global_vars.password = ''
            global_vars.login_error = 'Error: Try removing card and placing again'
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

    function loginInfo() {
        GlobVars.userpass = thread.userpassGet()
        splituserpass()
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }
}


