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

    Text {
        id: admin_api
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Admin  API"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 90
    }

    Error {
        id: api_error
        errorHeight: 250
        errorWidth: 700
        errorText: global_vars.admin_api_error
        z: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
    }

    BasicButton {
        id: other_options
        anchors.right: parent.right
        anchors.top: admin_api.top
        anchors.rightMargin: 140
        anchors.topMargin: 15
        height: 100
        width: 250
        label.text: "More"

        onClicked: {
            nextLayer(root.objectName, "admin_api2")
            root.state = "hidden"
        }
    }

    Clock2 {
        id: clock_adminapi_adduser
    }

    Clock2 {
        id: clock_adminapi_addpart
    }

    Clock2 {
        id: clock_adminapi_setstock
    }

    DoubleInput {
        id: add_user
        anchors.left: parent.left
        anchors.leftMargin: 105
        anchors.top: admin_api.bottom
        anchors.topMargin: -10
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        label.text: "Add  User"

        helpText1: "Username"
        maxLength1: 19
        helpText2: "Password"
        maxLength2: 19
        helpText3: "Admin?"
        boxWidth: global_vars.buttonWidthAdmin + 165

        onClicked: {
            if (inputText1 === '' || inputText2 === '') {
                global_vars.admin_api_error = "Error: Please enter both a username and a password"
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
                clock_adminapi_adduser.connect(function() {
                    if (global_vars.addUser === true) {
                        global_vars.admin_api_error = "Added new user"
                        textChange1 = ''
                        textChange2 = ''
                        adminState = "unchecked"
                    }
                    if (global_vars.addUser === false) {
                        global_vars.admin_api_error = "Error: Couldn't add new user " + inputText1
                    }
                })
                clock_adminapi_adduser.delay(1000)
            }
        }
    }

    DoubleInput {
        id: add_part
        anchors.left: parent.left
        anchors.leftMargin: 105
        anchors.top: add_user.bottom
        anchors.topMargin: 15
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        label.text: "Add  Part"

        helpText1: "Part Name"
        maxLength1: 17
        helpText2: "Location"
        maxLength2: 17
        helpText3: ''
        adminState: "invisible"

        onClicked: {
            if (inputText1 === '' || inputText2 === '') {
                global_vars.admin_api_error = "Error: Please enter both a name and a location"
            }
            else {
                global_vars.admin_api_error = "Entering new part... Please wait... "
                Connect.addPart(inputText1, inputText2)
                if (clock_adminapi_addpart.connected == false) {
                    clock_adminapi_addpart.connect(function() {
                        console.log("global_vars.addPart: ", global_vars.addPart)
                        if (global_vars.addPart === true) {
                            global_vars.admin_api_error = "Added new part " + inputText1
                            textChange1 = ''
                            textChange2 = ''
                        }
                        if (global_vars.addPart === false) {
                            global_vars.admin_api_error = "Error: Couldn't add new part " + inputText1
                        }
                    })
                }
                clock_adminapi_addpart.delay(1000);
            }
        }

    }

    DoubleInput {
        id: set_stock
        anchors.left: parent.left
        anchors.leftMargin: 105
        anchors.top: add_part.bottom
        anchors.topMargin: 15
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        label.text: "Set  Stock"

        helpText1: "Part ID"
        maxLength1: 17
        helpText2: "Quantity"
        maxLength2: 17
        helpText3: ''
        adminState: "invisible"

        onClicked: {
            if (inputText1 === '' || inputText2 === '') {
                global_vars.admin_api_error = "Error: Please enter both an item and a quantity"
            }
            else if (!isNaN(inputText2)) {
                global_vars.admin_api_error = "Setting stock... Please wait... "
                Connect.setStock(inputText1, inputText2)
                if (clock_adminapi_setstock.connected == false) {
                    clock_adminapi_setstock.connect(function() {
                        if (global_vars.setStock === true) {
                            global_vars.admin_api_error = "Set stock of item " + inputText1 + " as quantity " + inputText2
                            textChange1 = ''
                            textChange2 = ''
                        }
                        if (global_vars.setStock === false) {
                            global_vars.admin_api_error = "Error: Couldn't set stock of item " + inputText1
                        }
                    })
                }
                clock_adminapi_setstock.delay(1000);
            }
            else {
                global_vars.admin_api_error = "Error: Please make sure your input is a number for stock number"
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
            global_vars.admin_api_error = "Logging Out..."
            Connect.logout(global_vars.username, global_vars.realpass)
            clock_adminapi_adduser.connect(function() {
                Qt.quit()
            })
            clock_adminapi_adduser.delay(1000)
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
            global_vars.admin_api_error = ''
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
}


