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
    objectName: "check_out"

    signal nextLayer(string nextLayer)
    signal tabOperationCheck(string tabnum, string state)
    signal tabOperationFromCheckOut(string tabnum, string state)

    Component.onCompleted: {
        root.state = "hidden"
        right_tab.state = "Up"

        items.state = "off"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        check.tabOperationCheckOut.connect(tabOperationCheckOut)
        end_page.tabOperationFromEnd.connect(tabOperationCheckOut)
        main_window.itemScan.connect(itemScan)
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

    ListModel {
        id: item_model
    }

    Component {
        id: item_delegate
        ScannedItem {
            checked: ListView.isCurrentItem
            width: 1000
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
        anchors.fill: temp_background
        anchors.margins: 30
        delegate: item_delegate
        model: item_model
        spacing: 12
        z: 4
        clip: true
    }

    Text {
        text: "Check Out"
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 87
        height: clear_button.height
        width: clear_button.width
        font.family: "TypoGraphica"
        font.pixelSize: 102
        id: check_out
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
        id: check_out_button
        label.text: "Check Out"

        onClicked: {
            tabOperationFromCheckOut("right", "Up")
            tabOperationFromCheckOut("middle","Down")

            //send list to API here
            console.log("GlobVars.itemList: ", GlobVars.itemList)
            //

            deletionAll()
            nextLayer("end_page")
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

        onClicked: {
            deletionAll()
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
        height: 870
        width: global_vars.scrollWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 100
        anchors.topMargin: 100
        radius: 40
        opacity: 0.2
    }

    function deletionAll() {
        var index = GlobVars.itemList.length
        console.log("index: ", index)
        var i = 0
        while (i < index) {
            item_model.remove(0)
            i += 1
        }
        GlobVars.itemList = []
        item_counter.text = "Items: 0"
    }

    function itemScan(item) {
        console.log(item)
        GlobVars.itemList.push(item.slice(0,-1))
        console.log("GlobVars: ", GlobVars.itemList)

        item_model.insert(item_listview.currentIndex + 1, {
                              "itemText": "ID: " + item
                          })
        item_listview.currentIndex = item_listview.currentIndex + 1
        item_counter.text = "Items: " + GlobVars.itemList.length
    }


    function deletionHandlingCheckOut() {
        item_model.remove(item_listview.currentIndex)
        console.log("item_listview.currentIndex: ", item_listview.currentIndex)
        GlobVars.itemList.splice(item_listview.currentIndex, 1)
        console.log("GLobVars.itemList: ", GlobVars.itemList)
        item_counter.text = "Items: " + GlobVars.itemList.length
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

    function tabOperationCheckOut(tabnum, state) {
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
