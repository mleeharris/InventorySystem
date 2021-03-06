//Shane O'Brien
//Summer 2017
//Inventory GUI

//All icons make by Freepik from www.flaticon.com

import QtQuick 2.7
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/Layers"
import "qrc:/Function"
import "qrc:/Images"
import "qrc:/JavaScript/globalVars.js" as GlobVars
import "qrc:/JavaScript/connect.js" as Connect

Window {
    id: main_window
    visible: true

    /*
    width: 1920
    height: 1080
    */

    property int tempWidth: Screen.desktopAvailableWidth
    property int tempHeight: Screen.desktopAvailableHeight

    width: global_vars.tempWidth
    height: global_vars.tempHeight

    /*
    width: 1000
    height: 1000
    */

    objectName: "MainWindow"

    /***********************************************************************/
    // Delcaring signals to be sent out to control the bottom tabs and
    // item scanning on all the layers
    /***********************************************************************/
    signal tabOperationForScanPage(string tabnum, string state)
    signal tabOperationForLoggedIn(string tabnum, string state)
    signal tabOperationForLoginPage(string tabnum, string state)
    signal tabOperationForCheck(string tabnum, string state)
    signal tabOperationForCheckIn(string tabnum, string state)
    signal tabOperationForCheckOut(string tabnum, string state)
    signal tabOperationForEndPage(string tabnum, string state)
    signal tabOperationForLookup(string tabnum, string state)
    signal tabOperationForAdminAPI(string tabnum, string state)
    signal tabOperationForAdminSelection(string tabnum, string state)
    signal tabOperationForAdminAPI2(string tabnum, string state)

    signal itemScan(string item)
    signal itemScanIn(string item)
    signal itemLookup(string item)

    signal deleteList()

    FontLoader {
        id: opening_font
        name: "Instruction"
        source: "qrc:/Typefaces/Instruction.otf"
    }

    FontLoader {
        id: typo_graphica
        name: "TypoGraphica"
        source: "qrc:/Typefaces/TypoGraphica.otf"
    }

    Image {
        id: background_image
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

    /***********************************************************************/
    // Establishes how the UI will initially appear
    /***********************************************************************/
    Component.onCompleted: {
        right_tab.state = "Up"
        middle_tab.state = "Down"

        //barcode.state = "off"
        barcode.state = "on"
        items.state = "off"
        items_in.state = "off"

        //object_holder.state = "hidden"
        object_holder.state = "visible"

        check.nextLayer.connect(slot_switchLayer)
        check_out.nextLayer.connect(slot_switchLayer)
        scan_page.nextLayer.connect(slot_switchLayer)
        login_page.nextLayer.connect(slot_switchLayer)
        logged_in.nextLayer.connect(slot_switchLayer)
        end_page.nextLayer.connect(slot_switchLayer)
        check_in.nextLayer.connect(slot_switchLayer)
        lookup.nextLayer.connect(slot_switchLayer)
        admin_api.nextLayer.connect(slot_switchLayer)
        admin_selection.nextLayer.connect(slot_switchLayer)
        admin_api2.nextLayer.connect(slot_switchLayer)
    }

    /***********************************************************************/
    // Declaring all the layers
    /***********************************************************************/
    Check{id: check; x:0; y:0}
    ScanPage{id: scan_page; x:0; y:0}
    LoginPage{id: login_page; x:0; y:0}
    LoggedIn{id: logged_in; x:0; y:0}
    CheckOut{id: check_out; x:0; y: 0}
    EndPage{id: end_page; x:0; y: 0}
    CheckIn{id: check_in; x:0; y: 0}
    Lookup{id: lookup; x:0; y: 0}
    AdminAPI{id: admin_api; x:0; y:0}
    AdminSelection{id: admin_selection; x:0; y:0}
    AdminAPI2{id: admin_api2; x:0; y:0}

    /***********************************************************************/
    // Declaring the components
    /***********************************************************************/
    GlobalVars{id: global_vars}
    GlobalFuncs{id: global_funcs}

    /***********************************************************************/
    // All things seen on the opening page are within here.
    /***********************************************************************/
    Rectangle {
        anchors.fill: parent
        color: "#00000000"
        id: object_holder

        states:[
            State {
                name: "visible";
                PropertyChanges {
                    target: object_holder;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "hidden";
                PropertyChanges {
                    target: object_holder;
                    visible: false;
                    opacity: 0
                }
            }
        ]

        /***********************************************************************/
        // The 'behind the scenes' scanners. They are turned on or off
        // depending on what layer we are on
        /***********************************************************************/
        Scanner {
            id: barcode
//            onTemp: {
//                global_vars.currentItem = global_vars.currentItem + global_vars.event
//            }
//            onScanned: {
//                userpass(global_vars.userpass_creation)
//                global_vars.currentItem = ''
//            }
        }

        Scanner {
            id: items
            onTemp: {
                global_vars.currentItem = global_vars.currentItem + global_vars.event
            }
            onScanned: {
                itemScan(global_vars.currentItem)
                global_vars.currentItem = ''
            }

        }

        Scanner {
            id: items_in
            onTemp: {
                global_vars.currentItem = global_vars.currentItem + global_vars.event
            }
            onScanned: {
                itemScanIn(global_vars.currentItem)
                global_vars.currentItem = ''
            }
        }

        Scanner {
            id: item_lookup
            onTemp: {
                global_vars.currentItem = global_vars.currentItem + global_vars.event
            }
            onScanned: {
                itemLookup(global_vars.currentItem)
                global_vars.currentItem = ''
            }
        }

        Text {
            id: title_text
            anchors.top: parent.top
            anchors.topMargin: global_vars.display(100)
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Inventory"
            font.family: "Typo Graphica"
            color: "Black"
            font.pointSize: global_vars.display(250)
        }

        BottomTab {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: global_vars.tabRightMargin
            id: right_tab
            //label.text: "Power"
            location: "qrc:/Images/power.png"
            onPressed: {
                Connect.test()
                location = "qrc:/Images/power_dark.png"
            }
            onReleased: {
                location = "qrc:/Images/power.png"
            }
            onClicked: {
                global_vars.main_error = "Exiting..."
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
            z: 2
            onPressed: {
                location = "qrc:/Images/back_dark.png"
            }
            onReleased: {
                location = "qrc:/Images/back.png"
            }
            onClicked: {
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: login_button.top
            anchors.bottomMargin: global_vars.display(30)
            id: scan_button
            label.text: "Scan"

            location: "qrc:/Images/rfid_chip.png"
            iconHeight: global_vars.display(92)
            iconAnchors.verticalCenterOffset: global_vars.display(-5)

            onClicked: {
                slot_switchLayer("main", "logged_in")
                //GlobVars.userpass = testing.readCard()
                console.log("ay", global_vars.tempHeight)
                scanned()
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: global_vars.display(200)
            id: login_button
            label.text: "How To"

            location: "qrc:/Images/question.png"
            iconHeight: global_vars.display(95)
            iconAnchors.verticalCenterOffset: global_vars.display(-5)

            onClicked: {
                slot_switchLayer("main", "login_page")
                object_holder.state = "hidden"
            }
        }

        Error {
            id: main_error
            errorHeight: global_vars.display(400)
            errorWidth: global_vars.display(440)
            errorText: global_vars.main_error
            z: 1

            anchors.left: parent.left
            anchors.leftMargin: global_vars.display(120)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: global_vars.display(130)
        }

//        Image {
//            id: test
//            x: 10
//            y: 10
//            width: 100
//            height: 100
//            source: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"
//        }
    }

    /***********************************************************************/
    // Unused function, but is able to read in username and pass from a
    // barcode. Currently is not called
    /***********************************************************************/
    function userpass(userpass) {
        userpass = userpass.split(':')
        global_vars.username = userpass[0]
        global_vars.realpass = userpass[1]

        var star = '*'
        global_vars.password = ''
        var lengtherino = global_vars.realpass.length
        var i = 0
        while (i < lengtherino - 1) {
            global_vars.password = global_vars.password + star
            i += 1
        }

        console.log("username: ", global_vars.username)
        console.log("password: ", global_vars.password)

        object_holder.state = "hidden"
        check_out.state = "hidden"
        scan_page.state = "hidden"
        login_page.state = "hidden"
        slot_switchLayer("main", "logged_in")
    }

    /***********************************************************************/
    // Very important function. Called from every layer whenever there is a
    // layer change. Takes in the currentLayer and the destination layer as input
    // and determines what needs to be changed to go to the next layer
    /***********************************************************************/
    function slot_switchLayer(currentLayer, nextLayer) {
        //console.log("currentLayer: ", currentLayer)
        console.log("nextLayer: ", nextLayer)

        if (currentLayer === "main") {
            if (nextLayer === "login_page") {
                login_page.state = "visible"
                tabOperationForLoggedIn("middle","Up")
                tabOperationForLoginPage("middle","Up")
                tabOperationForScanPage("middle","Up")
                tabOperationMain("middle","Up")
            }
            if (nextLayer === "logged_in") {
                logged_in.state = "visible"
                tabOperationForLoggedIn("middle","Up")
                tabOperationForScanPage("middle","Up")
                tabOperationMain("middle","Up")
            }
        }
        if (currentLayer === "scan_page") {
            if (nextLayer === "admin_selection") {
                admin_selection.state = "visible"
            }
        }
        if (currentLayer === "login_page") {
            if (nextLayer === "main") {
                object_holder.state = "visible"
                tabOperationForLoggedIn("middle","Down")
                tabOperationMain("middle", "Down")
            }
            if (nextLayer === "logged_in") {
                logged_in.state = "visible"
            }
        }
        if (currentLayer === "logged_in") {
            if (nextLayer === "main") {
                object_holder.state = "visible"
                tabOperationMain("middle", "Down")
                tabOperationForScanPage("middle","Down")
                tabOperationForLoggedIn("middle","Down")
            }
            if (nextLayer === "check") {
                barcode.state = "off"
                check.state = "visible"
            }
            if (nextLayer === "admin_selection") {
                admin_selection.state = "visible"
                global_vars.admin_error = ''
                //tabOperationForScanPage("middle","Up")
            }
        }
        if (currentLayer === "check") {
            if (nextLayer === "lookup") {
                item_lookup.state = "on"
                lookup.state = "visible"
                tabOperationForLookup("right","Down")
                tabOperationForCheck("right","Down")
            }

            if (nextLayer === "check_in") {
                items_in.state = "on"
                check_in.state = "visible"
                tabOperationForCheckIn("right","Down")
                tabOperationForCheck("right", "Down")
                tabOperationForCheckOut("right","Down")
            }
            if (nextLayer === "check_out") {
                items.state = "on"
                check_out.state = "visible"
                tabOperationForCheckOut("right","Down")
                tabOperationForCheck("right", "Down")
                tabOperationForCheckIn("right","Down")
            }
            if (nextLayer === "logged_in") {
                barcode.state = "on"
                logged_in.state = "visible"
            }
            if (nextLayer === "admin_selection") {
                admin_api.state = "visible"
            }
        }
        if (currentLayer === "check_in") {
            if (nextLayer === "check") {
                check.state = "visible"
                items_in.state = "off"
                tabOperationForCheckIn("right","Up")
                tabOperationForCheck("right", "Up")
                tabOperationForCheckIn("middle","Up")
                tabOperationForCheckOut("middle","Up")
            }
            if (nextLayer === "end_page") {
                items_in.state = "off"
                end_page.state = "visible"
                tabOperationMain("middle","Down")
                tabOperationForCheckIn("right","Up")
                tabOperationForEndPage("right","Up")
                tabOperationForCheckIn("middle","Down")
                tabOperationForEndPage("middle","Down")
                tabOperationForCheckOut("right","Up")
                tabOperationForCheckOut("middle","Down")
            }
        }
        if (currentLayer === "check_out") {
            if (nextLayer === "check") {
                check.state = "visible"
                items.state = "off"
                tabOperationForCheckOut("right","Up")
                tabOperationForCheck("right", "Up")
                tabOperationForCheckIn("middle","Up")
                tabOperationForCheckOut("middle","Up")
            }
            if (nextLayer === "end_page") {
                items.state = "off"
                end_page.state = "visible"
                tabOperationMain("middle","Down")
                tabOperationForCheckOut("right","Up")
                tabOperationForEndPage("right","Up")
                tabOperationForCheckOut("middle","Down")
                tabOperationForEndPage("middle","Down")
                tabOperationForCheckIn("right","Up")
                tabOperationForCheckIn("middle","Down")
            }
        }
        if (currentLayer === "end_page") {
            if (nextLayer === "check_in") {
                check_in.state = "visible"
                items_in.state = "on"
                tabOperationForCheckIn("right","Down")
                tabOperationForEndPage("right","Down")
                tabOperationForCheckIn("middle","Up")
                tabOperationForEndPage("middle","Up")
            }
            if (nextLayer === "check_out") {
                check_out.state = "visible"
                items.state = "on"
                tabOperationForCheckOut("right","Down")
                tabOperationForEndPage("right","Down")
                tabOperationForCheckOut("middle","Up")
                tabOperationForEndPage("middle","Up")
            }
            if (nextLayer === "main") {
                barcode.state = "on"
                tabOperationForScanPage("middle","Down")
                tabOperationForScanPage("right","Up")
                tabOperationForLoginPage("middle","Down")
                tabOperationForLoginPage("right","Up")
                tabOperationForLoggedIn("middle","Down")
                tabOperationForLoggedIn("right","Up")
                tabOperationForCheck("middle","Up")
                tabOperationForCheck("right","Up")
                tabOperationForCheckIn("middle","Up")
                tabOperationForCheckIn("right","Up")
                tabOperationForCheckOut("middle","Up")
                tabOperationForCheckOut("right","Up")
                tabOperationForEndPage("middle","Up")
                tabOperationForEndPage("right","Down")
                object_holder.state = "visible"
            }
        }
        if (currentLayer === "lookup") {
            if (nextLayer === "check") {
                item_lookup.state = "Off"
                check.state = "visible"
                tabOperationForLookup("right","Up")
                tabOperationForCheck("right","Up")
            }
        }
        if (currentLayer === "admin_selection") {
            if (nextLayer === "admin_api") {
                admin_api.state = "visible"
            }
            if (nextLayer === "scan_page") {
                scan_page.state = "visible"
            }
            if (nextLayer === "logged_in") {
                logged_in.state = "visible"
            }
        }
        if (currentLayer === "admin_api") {
            if (nextLayer === "admin_selection") {
                admin_selection.state = "visible"
            }
            if (nextLayer === "admin_api2") {
                admin_api2.state = "visible"
            }
        }
        if (currentLayer === "admin_api2") {
            if (nextLayer === "admin_api") {
                admin_api.state = "visible"
            }
        }
    }

    /***********************************************************************/
    // Controls tab operation on main.qml
    /***********************************************************************/
    function tabOperationMain(tabnum, state) {
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
    // Test function, unused
    /***********************************************************************/
    function returntwo() {
        console.log("ayyy")
    }

    /***********************************************************************/
    // The slot for the signal from main.cpp. Whenever a new username and pass
    // is read in from the NFC reader, the signal is sent to this function.
    /***********************************************************************/
    function scanned() {
        //GlobVars.userpass = thread.userpassGet()
        //GlobVars.userpass = GlobVars.userpass.split('=')

        if (global_vars.username != '' && global_vars.realpass != '') {
            global_vars.login_error = "Logged out of previous scan"
            Connect.logout(global_vars.username, global_vars.realpass)
        }

        GlobVars.username = thread.userGet();
        GlobVars.realpass = thread.passGet();

        //console.log("GlobVars.username: ", GlobVars.username)

        //PASSWORD ERROR FIX PROBABLY HERE
        if (GlobVars.username == "Error" || GlobVars.username == '' || GlobVars.realpass == "Error") {
            global_vars.username = ''
            global_vars.realpass = ''
            global_vars.password = ''
            global_vars.login_error = 'Error: No card currently read. Try removing card and placing until results show'
        }

        else {
            global_vars.username = GlobVars.username

            var increment_length = GlobVars.realpass.length
            var i = 0
            global_vars.password = ''
            while (i < increment_length) {
                global_vars.password += GlobVars.star
                i += 1
            }
        global_vars.realpass = GlobVars.realpass
        global_vars.login_error = ''
        }

        /***********************************************************************/
        // Ensures that when a new card is read in, the UI returns
        // to the log in page
        /***********************************************************************/
        if (object_holder.state == "visible") {
            slot_switchLayer("main","logged_in")
            object_holder.state = "hidden"
        }
        if (lookup.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            lookup.state = "hidden"
        }
        if (check.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            check.state = "hidden"
        }
        if (check_in.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            deleteList()
            check_in.state = "hidden"
        }
        if (check_out.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            deleteList()
            check_out.state = "hidden"
        }
        if (end_page.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            end_page.state = "hidden"
        }
        if (login_page.state == "visible") {
            slot_switchLayer("end_page","main")
            object_holder.state = "hidden"
            slot_switchLayer("main","logged_in")
            login_page.state = "hidden"
        }
    }

    function logoutQuit() {
        Qt.quit()
    }

    /***********************************************************************/
    // Unfinished function that is triggered when the .png image is loaded in
    /***********************************************************************/
    function loadImage() {
        console.log("wut is going on")
        //console.log("yo", image.d)
    }
}
