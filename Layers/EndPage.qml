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
    width: global_vars.tempWidth
    height: global_vars.tempHeight
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
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: title_text
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(160)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Action Completed"
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
        id: check_in_button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: global_vars.display(475)
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
        anchors.topMargin: global_vars.display(20)
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
        anchors.topMargin: global_vars.display(20)
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
            Connect.logoutQuit(global_vars.username, global_vars.realpass)
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
        errorHeight: global_vars.display(450)
        errorWidth: global_vars.display(500)
        errorText: global_vars.endpage_error
        z: 1

        anchors.left: parent.left
        anchors.leftMargin: global_vars.display(100)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: global_vars.display(130)
    }

    /***********************************************************************/
    // Controls tab operation on End Page. Called from main.qml
    /***********************************************************************/
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

    /***********************************************************************/
    // These 'add' functions control the end page messages
    /***********************************************************************/
    function addGoodOut(item) {
        GlobVars.checkGoodOut.push(item)
    }

    /***********************************************************************/
    // These 'add' functions control the end page messages
    /***********************************************************************/
    function addBadOut(item) {
        GlobVars.checkBadOut.push(item)
    }

    /***********************************************************************/
    // The actual function that uses the 'add' functions to display the correct
    // error message on end page
    /***********************************************************************/
    function checkOutMsg() {
        var i = 0;
        if (global_vars.checkOutError == 0) {
            if (GlobVars.checkGoodOut.length > 0) {
                global_vars.endpage_error = "All items checked out. These are: "
                i = 0;
                while (i < GlobVars.checkGoodOut.length) {
                    global_vars.endpage_error += GlobVars.checkGoodOut[i] + ' '
                    i += 1
                }
            }
            else {
                global_vars.endpage_error = "No items entered, so none were checked out"
            }
        }
        if (global_vars.checkOutError == 1) {
            global_vars.endpage_error = "Error checking out these items: "
            i = 0;
            while (i < GlobVars.checkBadOut.length) {
                global_vars.endpage_error += GlobVars.checkBadOut[i] + '  '
                i += 1
            }
            global_vars.endpage_error += "\n\n"
            if (GlobVars.checkGoodOut.length > 0) {
                global_vars.endpage_error += "But successfully checked out these items: "
                i = 0;
                while (i < GlobVars.checkGoodOut.length) {
                    global_vars.endpage_error += GlobVars.checkGoodOut[i] + ' '
                    i += 1
                }
            }
        }
        GlobVars.checkBadOut.splice(0,GlobVars.checkBadOut.length)
        GlobVars.checkGoodOut.splice(0,GlobVars.checkGoodOut.length)
    }

    /***********************************************************************/
    // These 'add' functions control the end page messages
    /***********************************************************************/
    function addGoodIn(item) {
        GlobVars.checkGoodIn.push(item)
    }

    /***********************************************************************/
    // These 'add' functions control the end page messages
    /***********************************************************************/
    function addBadIn(item) {
        GlobVars.checkBadIn.push(item)
    }

    /***********************************************************************/
    // The actual function that uses the 'add' functions to display the correct
    // error message on end page
    /***********************************************************************/
    function checkInMsg() {
        var i = 0;
        if (global_vars.checkInError == 0) {
            if (GlobVars.checkGoodIn.length > 0) {
                global_vars.endpage_error = "All items checked in successfully. These are: "
                i = 0;
                while (i < GlobVars.checkGoodIn.length) {
                    global_vars.endpage_error += GlobVars.checkGoodIn[i] + ' '
                    i += 1
                }
            }
            else {
                global_vars.endpage_error = "No items entered, so none were checked in"
            }
        }
        if (global_vars.checkInError == 1) {
            global_vars.endpage_error = "Error checking in these items:"
            i = 0;
            while (i < GlobVars.checkBadIn.length) {
                global_vars.endpage_error += GlobVars.checkBadIn[i] + '  '
                i += 1
            }
            global_vars.endpage_error += "\n\n"
            if (GlobVars.checkGoodIn.length > 0) {
                global_vars.endpage_error += "But successfully checked in these items: "
                i = 0;
                while (i < GlobVars.checkGoodIn.length) {
                    global_vars.endpage_error += GlobVars.checkGoodIn[i] + ' '
                    i += 1
                }
            }
        }

        GlobVars.checkBadIn.splice(0,GlobVars.checkBadIn.length)
        GlobVars.checkGoodIn.splice(0,GlobVars.checkGoodIn.length)
    }
}
