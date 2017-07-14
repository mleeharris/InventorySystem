//Shane O'Brien
//Summer 2017
//Inventory GUI

//All icons were downloaded from www.flaticon.com

import QtQuick 2.6
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

Window {
    id: main_window
    visible: true

    /*
    width: 1920
    height: 1080
    */

    width: 1000
    height: 1000


    objectName: "MainWindow"

    signal tabOperationForScanPage(string tabnum, string state)
    signal tabOperationForLoggedIn(string tabnum, string state)
    signal tabOperationForLoginPage(string tabnum, string state)
    signal tabOperationForCheck(string tabnum, string state)
    signal tabOperationForCheckIn(string tabnum, string state)
    signal tabOperationForCheckOut(string tabnum, string state)
    signal tabOperationForEndPage(string tabnum, string state)
    signal tabOperationForLookup(string tabnum, string state)
    signal itemScan(string item)
    signal itemScanIn(string item)
    signal itemLookup(string item)

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
        source: "qrc:/Images/background_opening_3.jpg"
    }

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
    }

    /*LAYER DECL*/
    Check{id: check; x:0; y:0}
    ScanPage{id: scan_page; x:0; y:0}
    LoginPage{id: login_page; x:0; y:0}
    LoggedIn{id: logged_in; x:0; y:0}
    CheckOut{id: check_out; x:0; y: 0}
    EndPage{id: end_page; x:0; y: 0}
    CheckIn{id: check_in; x:0; y: 0}
    Lookup{id: lookup; x:0; y: 0}

    /*COMPONENT DECL*/
    GlobalVars{id: global_vars}

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

        Item {
            id: barcode
            focus: true
            Keys.onPressed: {
                //console.log("event.key: ", event.key)
                //console.log("event.text: ", event.text)
                if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
                    //console.log('added')
                    global_vars.userpass_creation = global_vars.userpass_creation + event.text
                }
                if (String(event.key) == '16777220') {
                    //console.log('reset')
                    userpass(global_vars.userpass_creation)
                    global_vars.userpass_creation = ''
                }
            }

            states:[
                State {
                    name: "on";
                    PropertyChanges {
                        target: barcode
                        enabled: true
                        focus: true
                    }
                },
                State {
                    name: "off";
                    PropertyChanges {
                        target: barcode
                        enabled: false
                        focus: false
                    }
                }
            ]
        }

        Item {
            id: items
            Keys.onPressed: {
                //console.log("event.key: ", event.key)
                //console.log("event.text: ", event.text)
                if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
                    global_vars.currentItem = global_vars.currentItem + event.text
                }
                if (String(event.key) == '16777220') {
                    itemScan(global_vars.currentItem)
                    global_vars.currentItem = ''
                }
            }

            states:[
                State {
                    name: "on";
                    PropertyChanges {
                        target: items
                        enabled: true
                        focus: true;
                    }
                },
                State {
                    name: "off";
                    PropertyChanges {
                        target: items
                        enabled: false
                        focus: false;
                    }
                }
            ]
        }

        Item {
            id: items_in
            Keys.onPressed: {
                //console.log("event.key: ", event.key)
                //console.log("event.text: ", event.text)
                if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
                    global_vars.currentItem = global_vars.currentItem + event.text
                }
                if (String(event.key) == '16777220') {
                    itemScanIn(global_vars.currentItem)
                    global_vars.currentItem = ''
                }
            }

            states:[
                State {
                    name: "on";
                    PropertyChanges {
                        target: items_in
                        enabled: true
                        focus: true;
                    }
                },
                State {
                    name: "off";
                    PropertyChanges {
                        target: items_in
                        enabled: false
                        focus: false;
                    }
                }
            ]
        }

        Item {
            id: item_lookup
            Keys.onPressed: {
                //console.log("event.key: ", event.key)
                //console.log("event.text: ", event.text)
                if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
                    global_vars.currentItem = global_vars.currentItem + event.text
                }
                if (String(event.key) == '16777220') {
                    console.log("global_vars.currentItem: ", global_vars.currentItem)
                    itemLookup(global_vars.currentItem)
                    global_vars.currentItem = ''
                }
            }

            states:[
                State {
                    name: "on";
                    PropertyChanges {
                        target: item_lookup
                        enabled: true
                        focus: true;
                    }
                },
                State {
                    name: "off";
                    PropertyChanges {
                        target: item_lookup
                        enabled: false
                        focus: false;
                    }
                }
            ]
        }

        Text {
            id: title_text
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Inventory"
            font.family: "Typo Graphica"
            color: "Black"
            font.pointSize: 250
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
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: login_button.top
            anchors.bottomMargin: 30
            id: scan_button
            label.text: "Scan"

            location: "qrc:/Images/rfid_chip.png"
            iconHeight: 92
            iconAnchors.verticalCenterOffset: -5

            onClicked: {
                slot_switchLayer("main", "logged_in")
                GlobVars.userpass = testing.readCard()
                splituserpass()
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 200
            id: login_button
            label.text: "How To"

            location: "qrc:/Images/question.png"
            iconHeight: 95
            iconAnchors.verticalCenterOffset: -5

            onClicked: {
                slot_switchLayer("main", "login_page")
                object_holder.state = "hidden"
            }
        }
    }

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
            if (nextLayer === "logged_in") {
                logged_in.state = "visible"
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
            if (nextLayer === "scan_page") {
                scan_page.state = "visible"
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
    }

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

    function returntwo() {
        console.log("ayyy")
    }

    function scanned() {
        if (object_holder.state == "visible") {
            slot_switchLayer("main","logged_in")
            object_holder.state = "hidden"
        }
    }
}
