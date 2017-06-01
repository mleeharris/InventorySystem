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

        first_main.nextLayer.connect(slot_switchLayer)
        second_main.nextLayer.connect(slot_switchLayer)
        scan_page.nextLayer.connect(slot_switchLayer)
        login_page.nextLayer.connect(slot_switchLayer)
        logged_in.nextLayer.connect(slot_switchLayer)

        scan_page.tabOperationMain.connect(tabOperationMain)
        logged_in.tabOperationMain.connect(tabOperationMain)
        login_page.tabOperationMain.connect(tabOperationMain)
    }

    /*LAYER DECL*/
    First{id: first_main; x:10; y:10}
    Second{id: second_main; x:10; y:10}
    ScanPage{id: scan_page; x:0; y:0}
    LoginPage{id: login_page; x:0; y:0}
    LoggedIn{id: logged_in; x:0; y:0}

    /*COMPONENT DECL*/
    GlobalVars{id: global_vars}

//    Rectangle {
//        x: 0
//        y: 0
//        width: 100
//        height: 100
//        color: "red"

//        MouseArea {
//            anchors.fill: parent
//            onPressed: {
//                right_tab.state = "Down"
//            }
//            onReleased: {
//                right_tab.state = "Up"
//            }
//        }
//    }

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
            label.text: "Power"
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
                slot_switchLayer("second_main")
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            id: scan_button
            label.text: "Scan"
            onPressed: {
                button_shadow_1.state = "hidden"
                scan_button.state = "pressed"
            }
            onReleased: {
                button_shadow_1.state = "visible"
                scan_button.state = "unpressed"
            }
            onClicked: {
                tabOperationScanPage("middle", "Up")
                tabOperationLoggedIn("middle", "Up")
                slot_switchLayer("scan_page")
                object_holder.state = "hidden"
            }

            state: "unpressed"
            states:[
                State {
                    name: "unpressed";
                    PropertyChanges {
                        target: scan_button;
                        anchors.topMargin: global_vars.buttonTopMargin
                        anchors.leftMargin: global_vars.buttonLeftMargin
                    }
                },
                State {
                    name: "pressed";
                    PropertyChanges {
                        target: scan_button;
                        anchors.topMargin: global_vars.buttonTopMargin + global_vars.dropShadowVertOffset
                        anchors.leftMargin: global_vars.buttonLeftMargin + global_vars.dropShadowHorizOffset
                    }
                }
            ]
        }

        DropShadow {
            id: button_shadow_1
            anchors.fill: scan_button
            horizontalOffset: global_vars.dropShadowHorizOffset
            verticalOffset: global_vars.dropShadowVertOffset
            radius: 8
            samples: radius*2+1
            color: "#80000000"
            source: scan_button
            transparentBorder: true
            cached: true

            state: "visible"
            states:[
                State {
                    name: "visible";
                    PropertyChanges {
                        target: button_shadow_1;
                        visible: true;
                        opacity: 1
                    }
                },
                State {
                    name: "hidden";
                    PropertyChanges {
                        target: button_shadow_1;
                        visible: false;
                        opacity: 0
                    }
                }
            ]
        }

        BasicButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            id: login_button
            label.text: "Login"
            onPressed: {
                button_shadow_2.state = "hidden"
                login_button.state = "pressed"
            }
            onReleased: {
                button_shadow_2.state = "visible"
                login_button.state = "unpressed"
            }
            onClicked: {
                tabOperationLoginPage("middle", "Up")
                tabOperationLoggedIn("middle", "Up")
                slot_switchLayer("login_page")
                object_holder.state = "hidden"
            }

            state: "unpressed"
            states:[
                State {
                    name: "unpressed";
                    PropertyChanges {
                        target: login_button;
                        anchors.topMargin: global_vars.buttonTopMargin + 200
                        anchors.leftMargin: global_vars.buttonLeftMargin
                    }
                },
                State {
                    name: "pressed";
                    PropertyChanges {
                        target: login_button;
                        anchors.topMargin: global_vars.buttonTopMargin + global_vars.dropShadowVertOffset + 200
                        anchors.leftMargin: global_vars.buttonLeftMargin + global_vars.dropShadowHorizOffset
                    }
                }
            ]
        }

        DropShadow {
            id: button_shadow_2
            anchors.fill: login_button
            horizontalOffset: global_vars.dropShadowHorizOffset
            verticalOffset: global_vars.dropShadowVertOffset
            radius: 8
            samples: radius*2+1
            color: "#80000000"
            source: login_button
            transparentBorder: true
            cached: true

            state: "visible"
            states:[
                State {
                    name: "visible";
                    PropertyChanges {
                        target: button_shadow_2;
                        visible: true;
                        opacity: 1
                    }
                },
                State {
                    name: "hidden";
                    PropertyChanges {
                        target: button_shadow_2;
                        visible: false;
                        opacity: 0
                    }
                }
            ]
        }
    }

    function userpass(userpass) {
        userpass = userpass.split(':')
        global_vars.username = userpass[0]
        global_vars.password = userpass[1]

        console.log("username: ", global_vars.username)
        console.log("password: ", global_vars.password)

        console.log("MAINNNNN")
        tabOperationLoggedIn("middle", "Up")
        object_holder.state = "hidden"
        first_main.state = "hidden"
        second_main.state = "hidden"
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
                break;
            }
            case "first_main": {
                first_main.state = "visible"
                break;
            }
            case "second_main": {
                second_main.state = "visible"
                break;
            }
            case "scan_page": {
                scan_page.state = "visible"
                break;
            }
            case "login_page": {
                login_page.state = "visible"
                break;
            }
            case "logged_in": {
                logged_in.state = "visible"
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
