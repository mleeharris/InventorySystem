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
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

//    HelpBox {
//        id: testerino
//        anchors.top: parent.top
//        anchors.right: parent.right
//        anchors.margins: 30
//        opacity: 1.0
//        z: 4
//    }

    Text {
        text: "Lookup"
        anchors.top: temp_background.top
        anchors.topMargin: global_vars.display(20)
        anchors.horizontalCenter: temp_background.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: global_vars.display(115)
        id: lookup_text
    }

    Clock2 {
        id: clock_lookup
    }

    Rectangle {
        id: line
        color: 'black'
        height: global_vars.display(2)
        width: global_vars.display(1100)
        anchors.horizontalCenter: lookup_text.horizontalCenter
        anchors.top: lookup_text.bottom
        anchors.topMargin: global_vars.display(5)
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

    Text {
        id: item_display
        text: "Item: Please Scan"
        anchors.bottom: middle_tab.top
        anchors.bottomMargin: global_vars.display(30)
        anchors.horizontalCenter: middle_tab.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: global_vars.display(64)
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
        height: global_vars.display(870)
        width: global_vars.scrollWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: global_vars.display(100)
        anchors.topMargin: global_vars.display(100)
        radius: global_vars.display(40)
        opacity: 0.2
        z: 3
    }

    Text {
        id: info_text
        anchors.top: temp_background.top
        anchors.left: temp_background.left
        anchors.topMargin: global_vars.display(180)
        anchors.leftMargin: global_vars.display(40)
        width: temp_background.width/2-global_vars.display(40)
        height: temp_background.height
        font.pointSize: global_vars.display(20)
        lineHeight: 1.5
        wrapMode: Text.Wrap
    }

    Text {
        id: info_text2
        anchors.top: info_text.top
        anchors.left: info_text.right
        anchors.leftMargin: global_vars.display(40)
        width: temp_background.width - info_text.width
        height: temp_background.height
        font.pointSize: global_vars.display(15)
        maximumLineCount: 27
        lineHeight: 1.05
        wrapMode: Text.Wrap
        text: global_vars.stockHistory
    }

    function itemScan(item) {
        console.log(item)
        item_display.text = "Item: " + item
        global_vars.lookupCheck = 0
        Connect.lookUp(item)
        Connect.getStockHistory(item)
        info_text.text = "Looking up... Please wait... "
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

    function lookupString() {
        info_text.text = global_vars.lookupString
    }
}
