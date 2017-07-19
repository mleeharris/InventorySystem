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
    objectName: "admin_api"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        main_window.tabOperationForAdminAPI.connect(tabOperationAdminAPIPage)
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

    Text {
        id: admin_api
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Admin  API"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 100
    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 250
        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
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
        text: global_vars.admin_api_error
    }

    DoubleInput {
        id: add_user
        anchors.left: parent.left
        anchors.leftMargin: 105
        anchors.top: admin_api.bottom
        anchors.topMargin: 0
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        label.text: "Add  User"

        helpText1: "Username"
        maxLength1: 19
        helpText2: "Password"
        maxLength2: 19
        helpText3: "Admin?"

        onClicked: {
            if (inputText1 === '' || inputText2 === '') {
                global_vars.admin_api_error = "Please enter both a username and a password"
            }
            else {
                global_vars.admin_api_error = "Entering new user... Please wait... "
                if (adminClicked === true) {
                    Connect.addUserAdmin(inputText1, inputText2)
                }
                if (adminClicked === false) {
                    Connect.addUser(inputText1, inputText2)
                }
                //console.log("admin?: ", adminClicked)
                delay(1000, function() {
                    if (global_vars.addUser === true) {
                        textChange1 = ''
                        textChange2 = ''
                        adminClicked = false
                    }
                })
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
            nextLayer(root.objectName, "admin_selection")
            root.state = "hidden"
        }
    }

    function tabOperationAdminAPIPage(tabnum, state) {
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

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }
}


