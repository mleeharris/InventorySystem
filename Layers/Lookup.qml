import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/JavaScript"
import "qrc:/Components"
import "qrc:/JavaScript/componentCreation.js" as Creation
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "lookup"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        main_window.tabOperationForLookup.connect(tabOperationLookup)
        main_window.itemLookup.connect(itemScan)
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
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        text: "Lookup"
        anchors.top: temp_background.top
        anchors.topMargin: 20
        anchors.horizontalCenter: temp_background.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: 115
        id: lookup_text
    }

    Rectangle {
        id: line
        color: 'black'
        height: 2
        width: 1100
        anchors.horizontalCenter: lookup_text.horizontalCenter
        anchors.top: lookup_text.bottom
        anchors.topMargin: 5
    }

    Text {
        id: username
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 70
        text: global_vars.username
        font.family: "Helvetica"
        color: "Black"
        font.pointSize: 40
    }

    Text {
        id: item_display
        text: "Item: Please Scan"
        anchors.bottom: middle_tab.top
        anchors.bottomMargin: 30
        anchors.horizontalCenter: middle_tab.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: 64
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        //label.text: "Power"
        z: 4
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
            nextLayer(root.objectName, "check")
            root.state = "hidden"
        }
    }

    Rectangle {
        color: "black"
        id: temp_background
        height: 870
        width: global_vars.scrollWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 100
        anchors.topMargin: 100
        radius: 40
        opacity: 0.2
        z: 3
    }

    Text {
        id: info_text
        anchors.top: temp_background.top
        anchors.left: temp_background.left
        anchors.topMargin: 180
        anchors.leftMargin: 40
        width: temp_background.width-(40*2)
        height: temp_background.height-(40*2)
        font.pointSize: 20
        wrapMode: Text.Wrap
    }

    function itemScan(item) {
        console.log(item)
        item_display.text = "Item: " + item
        info_text.text = item + item + item + item + item + item + item + item + item + item + item
    }

    function tabOperationLookup(tabnum, state) {
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
