import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/JavaScript"
import "qrc:/Components"
import "qrc:/JavaScript/componentCreation.js" as Creation

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "logged_in"

    signal nextLayer(string nextLayer)
    signal tabOperationCheck(string tabnum, string state)

    Component.onCompleted: {
        root.state = "hidden"
        right_tab.state = "Up"

        items.state = "off"
        //items.state = "on"

        check.tabOperationCheckOut.connect(tabOperationCheckOut)
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

    BasicButton {
        anchors.top: parent.top
        anchors.topMargin: 380
        anchors.left: middle_tab.left
        height: clear_button.height
        width: clear_button.width
        id: undo_button
        label.text: "Undo"

        onClicked: {
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: undo_button.bottom
        anchors.topMargin: 20
        anchors.left: undo_button.left
        height: 100
        width: global_vars.buttonHeight*2
        id: clear_button
        label.text: "Clear"

        onClicked: {
            root.state = "hidden"
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        label.text: "Power"
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
        label.text: "Back"
        onClicked: {
            slot_switchLayer("check")
            tabOperationCheckOut("right", "Up")
            root.state = "hidden"
        }
    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 850
        width: global_vars.scrollWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 100
        anchors.topMargin: 100
        radius: 40
        opacity: 0.2
    }

    ScannedItem {
        id: item1
        anchors.top: temp_background.top
        anchors.topMargin: 20
        anchors.left: temp_background.left
        anchors.leftMargin: 20
        item_id.text: "Hammer"
        onClicked: {
            itemHandling("item1")
        }
    }

    function itemScan(item) {
        console.log(item)

        Creation.createScannedItemObjects()
        //var NewObject = Qt.createComponent("qrc:/Components/ScannedItem.qml")
        //console.log("NewObject.errorString(): ", NewObject.errorString())
        //if (NewObject.status === Component.Ready) {
//            console.log("NewObject.created: ", NewObject.created)
//            console.log("NewObject.color: ", NewObject.color4)
//            NewObject.created = true
//            NewObject.x = 0
//            NewObject.y = 0
//        }

        //Creation.createScannedItemObjects();
    }

    function itemHandling(item) {
        item1.visible = false
    }

    function tabOperationCheckOut(tabnum, state) {
        items.state = "on"
        if (tabnum === "right") {
            if (state === "Up") {
                tabOperationCheck("right", "Up")
                right_tab.state = "Up"
            }
            if (state === "Down") {
                tabOperationCheck("right", "Down")
                right_tab.state = "Down"
            }
        }
    }
}
