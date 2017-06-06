import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/Layers"
import "qrc:/Function"
import "qrc:/Images"

Window {
    id: main_window
    visible: true
    width: 1920
    height: 1080
    objectName: "MainWindow"

    signal tabOperationScanPage(string tabnum, string state)
    signal tabOperationLoggedIn(string tabnum, string state)
    signal tabOperationLoginPage(string tabnum, string state)
    signal itemScan(string item)
    signal itemScanIn(string item)
    property string active_layer: ""

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

        //object_holder.state = "hidden"
        object_holder.state = "visible"

        check.nextLayer.connect(slot_switchLayer)
        check_out.nextLayer.connect(slot_switchLayer)
        scan_page.nextLayer.connect(slot_switchLayer)
        login_page.nextLayer.connect(slot_switchLayer)
        logged_in.nextLayer.connect(slot_switchLayer)
        end_page.nextLayer.connect(slot_switchLayer)
        check_in.nextLayer.connect(slot_switchLayer)

        scan_page.tabOperationMain.connect(tabOperationMain)
        logged_in.tabOperationMain.connect(tabOperationMain)
        login_page.tabOperationMain.connect(tabOperationMain)
        check.tabOperationFromCheck.connect(tabOperationMain)
        end_page.tabOperationFromEnd.connect(tabOperationMain)
    }

    /*LAYER DECL*/
    Check{id: check; x:0; y:0}
    ScanPage{id: scan_page; x:0; y:0}
    LoginPage{id: login_page; x:0; y:0}
    LoggedIn{id: logged_in; x:0; y:0}
    CheckOut{id: check_out; x:0; y: 0}
    EndPage{id: end_page; x:0; y: 0}
    CheckIn{id: check_in; x:0; y: 0}

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
            location: "qrc:/Images/power_gray.png"
            onPressed: {
                location = "qrc:/Images/power_darkgray.png"
            }
            onReleased: {
                location = "qrc:/Images/power_gray.png"
            }
            onClicked: {
                Qt.quit()
                object_holder.state = "hidden"
            }
        }

        BottomTab {
            anchors.bottom: parent.bottom
            anchors.right: right_tab.left
            anchors.rightMargin: global_vars.tabSpace
            id: middle_tab
            label.text: "Back"
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
            onClicked: {
                tabOperationScanPage("middle", "Up")
                tabOperationLoggedIn("middle", "Up")
                slot_switchLayer("scan_page")
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 200
            id: login_button
            label.text: "Login"
            onClicked: {
                tabOperationLoginPage("middle", "Up")
                tabOperationLoggedIn("middle", "Up")
                slot_switchLayer("login_page")
                object_holder.state = "hidden"
            }
        }
    }

    function userpass(userpass) {
        userpass = userpass.split(':')
        global_vars.username = userpass[0]
        global_vars.password = userpass[1]

        console.log("username: ", global_vars.username)
        console.log("password: ", global_vars.password)

        tabOperationLoggedIn("middle", "Up")
        object_holder.state = "hidden"
        check_out.state = "hidden"
        scan_page.state = "hidden"
        login_page.state = "hidden"
        slot_switchLayer("logged_in")
    }

    function slot_switchLayer(nextLayer) {
        console.log(nextLayer)
        active_layer = nextLayer
        switch(nextLayer) {
            case "main": {
                object_holder.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                console.log("barcode.state: ", barcode.state)
                break;
            }
            case "check": {
                check.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                break;
            }
            case "check_out": {
                check_out.state = "visible"
                barcode.state = "off"
                items.state = "on"
                items_in.state = "off"
                break;
            }
            case "scan_page": {
                scan_page.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                break;
            }
            case "login_page": {
                login_page.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                break;
            }
            case "logged_in": {
                logged_in.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                break;
            }
            case "end_page": {
                end_page.state = "visible"
                barcode.state = "on"
                items.state = "off"
                items_in.state = "off"
                break;
            }
            case "check_in": {
                check_in.state = "visible"
                barcode.state = "off"
                items.state = "off"
                items_in.state = "on"
                break;
            }
        }
    }

    function tabOperationMain(tabnum, state) {
        if (tabnum === "middle") {
            if (state === "Up") {
                console.log('middle up')
                middle_tab.state = "Up"
            }
            if (state === "Down") {
                console.log('middle down')
                middle_tab.state = "Down"
            }
        }
    }
}
