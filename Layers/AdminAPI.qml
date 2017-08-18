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
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: admin_api_text
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(60)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Admin  API"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: global_vars.display(90)
    }

    Error {
        id: api_error
        errorHeight: global_vars.display(250)
        errorWidth: global_vars.display(700)
        errorText: global_vars.admin_api_error
        z: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: global_vars.display(100)
    }

    BasicButton {
        id: other_options
        anchors.right: parent.right
        anchors.top: admin_api_text.top
        anchors.rightMargin: global_vars.display(140)
        anchors.topMargin: global_vars.display(15)
        height: global_vars.display(100)
        width: global_vars.display(250)
        label.text: "More"

        onClicked: {
            nextLayer(root.objectName, "admin_api_2")
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
        anchors.leftMargin: global_vars.display(105)
        anchors.top: admin_api_text.bottom
        anchors.topMargin: global_vars.display(-10)
        height: global_vars.buttonHeightAdmin
        width: global_vars.buttonWidthAdmin
        label.text: "Add  User"

        helpText1: "Username"
        maxLength1: 19
        helpText2: "Password"
        maxLength2: 19
        helpText3: "Admin?"
        boxWidth: global_vars.buttonWidthAdmin + global_vars.display(165)

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
            }
        }
    }

    DoubleInput {
        id: add_part
        anchors.left: parent.left
        anchors.leftMargin: global_vars.display(105)
        anchors.top: add_user.bottom
        anchors.topMargin: global_vars.display(15)
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
            }
        }

    }

    DoubleInput {
        id: set_stock
        anchors.left: parent.left
        anchors.leftMargin: global_vars.display(105)
        anchors.top: add_part.bottom
        anchors.topMargin: global_vars.display(15)
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
            else if (isNaN(inputText2)) {
                global_vars.admin_api_error = "Error: Please make sure your input is a number for stock number"
            }
            else {
                Connect.setStock(inputText1, inputText2)
            }

//            else if (!isNaN(inputText2)) {
//                global_vars.admin_api_error = "Setting stock... Please wait... "
//                Connect.setStock(inputText1, inputText2)
//                if (clock_adminapi_setstock.connected == false) {
//                    clock_adminapi_setstock.connect(function() {
//                        if (global_vars.setStock === true) {
//                            global_vars.admin_api_error = "Set stock of item " + inputText1 + " as quantity " + inputText2
//                            textChange1 = ''
//                            textChange2 = ''
//                        }
//                        if (global_vars.setStock === false) {
//                            global_vars.admin_api_error = "Error: Couldn't set stock of item " + inputText1
//                        }
//                    })
//                }
//                clock_adminapi_setstock.delay(1000);
//            }
//            else {
//                global_vars.admin_api_error = "Error: Please make sure your input is a number for stock number"
//            }
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
            global_vars.admin_api_error = ''
            nextLayer(root.objectName, "admin_selection")
            root.state = "hidden"
        }
    }

    /***********************************************************************/
    // Controls tab operation on Admin API Page
    /***********************************************************************/
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

    /***********************************************************************/
    // Called from connect.js after addUser is completed
    /***********************************************************************/
    function addUser() {
        if (global_vars.addUser === true) {
            add_user.textChange1 = ''
            add_user.textChange2 = ''
            add_user.adminState = "unchecked"
        }
    }

    /***********************************************************************/
    // Called from connect.js after addPart is completed
    /***********************************************************************/
    function addPart() {
        if (global_vars.addPart === true) {
            global_vars.admin_api_error = "Added new part " + add_part.inputText1
            add_part.textChange1 = ''
            add_part.textChange2 = ''
        }
        if (global_vars.addPart === false) {
            global_vars.admin_api_error = "Error: Couldn't add new part " + add_part.inputText1
        }
    }

    /***********************************************************************/
    // Called from connect.js after setSock is completed
    /***********************************************************************/
    function setStock() {
        if (global_vars.setStock === true) {
            global_vars.admin_api_error = "Set stock of item " + set_stock.inputText1 + " as quantity " + set_stock.inputText2
            set_stock.textChange1 = ''
            set_stock.textChange2 = ''
        }
        if (global_vars.setStock === false) {
            global_vars.admin_api_error = "Error: Couldn't set stock of item " + set_stock.inputText1
        }
    }
}


