import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "qrc:/JavaScript"
import "qrc:/Components"
import "qrc:/JavaScript/globalVars.js" as GlobVars
import "qrc:/JavaScript/connect.js" as Connect

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "check_in"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        main_window.itemScanIn.connect(itemScan)
        main_window.tabOperationForCheckIn.connect(tabOperationCheckIn)
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

    Clock {
        id: clock_checkin
    }

    ListModel {
        id: item_model
    }

    Component {
        id: item_delegate
        ScannedItem {
            checked: ListView.isCurrentItem
            width: 1100
            height: 80
            item_id.text: itemText
            MouseArea {
                id: item_ma
                anchors.top: parent.top
                anchors.right: parent.right
                height: 80
                width: 80
                onPressed: {
                    item_listview.currentIndex = index
                }
                onReleased: {
                    deletionHandlingCheckOut()
                }
            }
        }
    }

    ListView {
        id: item_listview
        height: 500
        anchors.fill: temp_background
        anchors.leftMargin: 30
        anchors.topMargin: 190
        anchors.bottomMargin: 30
        delegate: item_delegate
        model: item_model
        spacing: 12
        z: 4
        clip: true

//        ScrollBar.vertical: ScrollBar {
//            parent: item_listview
//            anchors.top: parent.top
//            anchors.left: parent.right
//        }
    }

    Text {
        text: "Check In"
        anchors.top: temp_background.top
        anchors.topMargin: 20
        anchors.horizontalCenter: temp_background.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: 115
        id: check_in
    }

    Rectangle {
        id: line
        color: 'black'
        height: 2
        width: 1100
        anchors.horizontalCenter: check_in.horizontalCenter
        anchors.top: check_in.bottom
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
        text: "Items: 0"
        anchors.bottom: clear_button.top
        anchors.bottomMargin: 0
        anchors.horizontalCenter: clear_button.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: 74
        id: item_counter
    }

    BasicButton {
        anchors.top: clear_button.bottom
        anchors.topMargin: 20
        anchors.left: clear_button.left
        height: clear_button.height
        width: clear_button.width
        id: check_in_button
        label.text: "Done"

        location: "qrc:/Images/check_in_button.png"
        iconHeight: global_vars.check_in_height-30
        iconAnchors.verticalCenterOffset: global_vars.check_in_offset

        onClicked: {
            //send list to API here
            Connect.checkIn(GlobVars.itemListIn)
            global_vars.endpage_error = "Checking in... Please wait... "
            console.log("GlobVars.itemListIn: ", GlobVars.itemListIn)
            //

            callTimer()
            deletionAll()
            nextLayer(root.objectName, "end_page")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: parent.top
        anchors.topMargin: 400
        anchors.left: middle_tab.left
        height: 100
        width: global_vars.buttonHeight*2+60
        id: clear_button
        label.text: "Clear"

        location: "qrc:/Images/recycling_bin.png"
        iconHeight: global_vars.clear_height-30
        iconAnchors.verticalCenterOffset: global_vars.clear_offset

        onClicked: {
            deletionAll()
        }
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
            deletionAll()
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

//        ScrollBar {
//            id: vbar
//            hoverEnabled: true
//            active: hovered || pressed
//            orientation: Qt.Vertical
//            size: 1000
//            anchors.top: temp_background.top
//            anchors.right: temp_background.right
//            anchors.bottom: temp_background.bottom
//        }
    }

    function deletionAll() {
        var index = GlobVars.itemListIn.length
        var i = 0
        while (i < index) {
            item_model.remove(0)
            i += 1
        }
        GlobVars.itemListIn = []
        item_counter.text = "Items: 0"
    }

    function itemScan(item) {
        GlobVars.itemListIn.push(item.slice(0,-1))
        console.log("GlobVars: ", GlobVars.itemListIn)

        item_model.insert(item_listview.currentIndex + 1, {"itemText": "ID: " + item})
        item_listview.currentIndex = item_listview.currentIndex + 1
        item_counter.text = "Items: " + GlobVars.itemListIn.length
    }


    function deletionHandlingCheckOut() {
        item_model.remove(item_listview.currentIndex)
        GlobVars.itemListIn.splice(item_listview.currentIndex, 1)
        item_counter.text = "Items: " + GlobVars.itemListIn.length

//        console.log("itemID: ", itemID)
//        console.log("GlobVars.itemList: ", GlobVars.itemList)
//        var i = 0
//        while (i < GlobVars.itemList.length) {
//            console.log("itemID: ", itemID)
//            console.log(GlobVars.itemList[i])
//            if (itemID == "ID: " + GlobVars.itemList[i]) {
//                global_vars.numItems--
//                if (GlobVars.itemList.length == 1) {
//                    GlobVars.itemList = []
//                    GlobVars.objectList = []
//                }
//                else {
//                    item_model.remove(item_listview.currentIndex)
//                    GlobVars.itemList.splice(i, 1)
//                    GlobVars.objectList.splice(i, 1)
//                    //console.log("GlobVars.itemList.splice(i, i): ", GlobVars.itemList.splice(i, i))
//                }
//                //shiftUp(i)
//                console.log("GlobVars.itemList: ", GlobVars.itemList)
//                break;
//            }
//            i += 1
//        }
    }

//    function shiftUp(increment) {
//        var i = increment
//        var ObjectFocus
//        while (i < GlobVars.objectList.length) {
//            ObjectFocus = GlobVars.objectList[i]
//            ObjectFocus.y -= global_vars.itemDownShift
//            i += 1
//        }
//    }

    function tabOperationCheckIn(tabnum, state) {
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

    function callTimer() {
        clock_checkin.delay(2000, function() {
            if (global_vars.checkInError == 0) {
                global_vars.endpage_error = "All items checked in successfully"
            }
        });
    }
}
