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
    width: global_vars.tempWidth
    height: global_vars.tempHeight
    objectName: "check_in"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"
//        root.state = "visible"
//        items_in.state = "on"
//        barcode.state = "off"

        middle_tab.state = "Up"
        right_tab.state = "Up"

        //object deletion handling
        //scanned_item.deletionHandling.connect(deletionHandlingCheckOut)

        //tab operation
        main_window.itemScanIn.connect(itemScan)
        main_window.tabOperationForCheckIn.connect(tabOperationCheckIn)
        main_window.deleteList.connect(deleteList)
    }

    //ScannedItem{id: scanned_item}

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

    Clock {
        id: clock_checkin
    }

    Clock2 {
        id: clock_checkin2
    }

    ListModel {
        id: item_model
    }

    Component {
        id: item_delegate
        ScannedItem {
            id: scanitem
            checked: ListView.isCurrentItem
            width: global_vars.display(1100)
            height: global_vars.display(80)
            item_id.text: itemText
            item_name.text: itemName
            item_stock.text: itemStock
            stockHistory: stockHistoryFinal
            infoText: infoTextFinal
            property bool isCurrentItem: ListView.isCurrentItem
            onPressed: {
                item_listview.currentIndex = index
            }
            onReleased: {
                global_vars.checkinpage_error = itemName + ' deleted from list'
                deletionHandlingCheckOut()
                scanitem.stateUpLevel2 = "hidden"
            }
            onQuestionClicked: {
                scanitem.forQ = 400
                //console.log("yoo", ListElement.objectName)
            }
            onXClicked: {
                scanitem.forQ = 80
            }

//            MouseArea {
//                id: item_ma
//                anchors.top: parent.top
//                anchors.right: parent.right
//                height: global_vars.display(80)
//                width: global_vars.display(80)
//                onPressed: {

//                }
//                onReleased: {

//                }
//            }
            onIsCurrentItemChanged: {
                //PLAY AROUND HERE
//                item_listview.currentItemCount += 3
//                console.log('listview:', item_listview.currentItemCount)
                console.log("scanitem.stateUpLevel2: ", scanitem.stateUpLevel2)
                //console.log("fruitModel.get(0).cost: ", item_model.get(0).testing)
                scanitem.stateUpLevel2 = "hidden"
                //item_model.set(0, {"item_id.text": "bbb"})
                //item_model.setProperty(0, "item_id.text", "bbb")
                //item_model.clear()
                console.log("scanitem.state: ", scanitem.state)
                if(isCurrentItem) {
                    //console.log("wtf")
                }
            }
        }
    }

    ListView {
        id: item_listview
        height: global_vars.display(650)
        anchors.fill: temp_background
        anchors.leftMargin: global_vars.display(50)
        anchors.topMargin: global_vars.display(190)
        anchors.bottomMargin: global_vars.display(30)
        delegate: item_delegate
        model: item_model
        spacing: global_vars.display(12)
        z: 4
        clip: true

        property int currentItemCount: 0

        ScrollBar.vertical: ScrollBar {
            active: true
            interactive: true
            orientation: Qt.Vertical
            policy: ScrollBar.AsNeeded
            parent: item_listview.parent
            anchors.top: item_listview.top
            anchors.left: item_listview.right
            anchors.leftMargin: global_vars.display(-65)
        }
    }

    Text {
        text: "Check In"
        anchors.top: temp_background.top
        anchors.topMargin: global_vars.display(20)
        anchors.horizontalCenter: temp_background.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: global_vars.display(115)
        id: check_in_text
    }

    Rectangle {
        id: line
        color: 'black'
        height: global_vars.display(2)
        width: global_vars.display(1100)
        anchors.horizontalCenter: check_in_text.horizontalCenter
        anchors.top: check_in_text.bottom
        anchors.topMargin: 5
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
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 15
        height: 100
        width: 100
        id: test
        label.text: "test"

        onClicked: {
            closeAll();
        }
    }

    Text {
        text: "Items: 0"
        anchors.bottom: checkin_error.top
        anchors.bottomMargin: 0
        anchors.horizontalCenter: checkin_error.horizontalCenter
        font.family: "Bebas Neue"
        font.pixelSize: global_vars.display(74)
        id: item_counter
    }

    Error {
        id: checkin_error
        errorHeight: global_vars.display(110)
        errorWidth: clear_button.width
        errorText: global_vars.checkinpage_error
        z: 1

        topMargin.topMargin: global_vars.display(20)

        anchors.bottom: clear_button.top
        anchors.bottomMargin: global_vars.display(10)
        anchors.horizontalCenter: clear_button.horizontalCenter
    }

    BasicButton {
        anchors.top: clear_button.bottom
        anchors.topMargin: global_vars.display(20)
        anchors.left: clear_button.left
        height: clear_button.height
        width: clear_button.width
        id: check_in_button
        label.text: "Done"

        location: "qrc:/Images/check_in_button.png"
        iconHeight: global_vars.check_in_height-global_vars.display(30)
        iconAnchors.verticalCenterOffset: global_vars.check_in_offset

        onClicked: {
            global_vars.checkinpage_error = ''
            global_vars.checkoutpage_error = ''
            global_vars.checkInError = 0;
            GlobVars.checkBadIn = [];
            GlobVars.checkGoodIn = [];

            //send list to API here
            Connect.checkIn(GlobVars.itemListIn)
            global_vars.endpage_error = "Checking in... Please wait... "
            //console.log("GlobVars.itemListIn: ", GlobVars.itemListIn)

            global_funcs.checkInMsg()

            deletionAll()
            nextLayer(root.objectName, "end_page")
            root.state = "hidden"
        }
    }

    BasicButton {
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(400)
        anchors.left: middle_tab.left
        height: global_vars.display(100)
        width: global_vars.buttonHeight*2+global_vars.display(60)
        id: clear_button
        label.text: "Clear"

        location: "qrc:/Images/recycling_bin.png"
        iconHeight: global_vars.clear_height-global_vars.display(30)
        iconAnchors.verticalCenterOffset: global_vars.clear_offset

        onClicked: {
            global_vars.checkinpage_error = ''
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
        height: global_vars.display(870)
        width: global_vars.scrollWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: global_vars.display(100)
        anchors.topMargin: global_vars.display(100)
        radius: global_vars.display(40)
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

    function closeAll() {
        console.log("item_listview.currentIndex: ", item_listview.currentIndex)
        console.log("count: ", item_listview.count)
        var i = 0;
        var loopnum = item_listview.count
        while (i < loopnum) {
            console.log("umm", item_model.get(i).outside)
//            console.log("umm2", item_model.get(i).item_id)

            i += 1
        }

//        item_model.remove(item_listview.currentIndex)
//        GlobVars.itemListIn.splice(item_listview.currentIndex, 1)
//        item_counter.text = "Items: " + GlobVars.itemListIn.length
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

    function addScan() {
        GlobVars.itemListIn.push(global_vars.scannedItem)
        item_model.insert(item_listview.currentIndex + 1, {"itemText": "ID: " + global_vars.scannedItem, "itemName": "Name: " + global_vars.lookupName, "itemStock": "Stock: " + global_vars.lookupStock, "stockHistoryFinal": global_vars.stockHistory, "infoTextFinal": global_vars.lookupString})
        item_listview.currentIndex = item_listview.currentIndex + 1
        item_counter.text = "Items: " + GlobVars.itemListIn.length
        startCheckIn()
    }

    function startCheckIn() {
        var item = ''
        console.log("checkinQueue: ", GlobVars.checkInQueue)
        if (GlobVars.checkInQueue.length > 0) {
            item = GlobVars.checkInQueue.shift();
            Connect.checkInLookup(item)
        }

        //Connect.checkInLookup(item)
    }

    function itemScan(item) {
        //GlobVars.itemListIn.push(item.slice(0,-1))
        //console.log("GlobVars: ", GlobVars.itemListIn)

        GlobVars.checkInQueue.push(item.slice(0,-1))
        startCheckIn()

//        Connect.lookUp(item)
//        Connect.getStockHistory(item)
//        if (clock_checkin2.connected == false) {
//            clock_checkin2.connect( function() {
//                item_model.insert(item_listview.currentIndex + 1, {"itemText": "ID: " + global_vars.scannedItem, "itemName": "Name: " + global_vars.lookupName, "itemStock": "Stock: " + global_vars.lookupString, "stockHistoryFinal": global_vars.stockHistory, "infoTextFinal": global_vars.lookupStock})
//                item_listview.currentIndex = item_listview.currentIndex + 1
//                item_counter.text = "Items: " + GlobVars.itemListIn.length
//            })
//        }
//        clock_checkin2.delay(750)
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

    function deleteList() {
        deletionAll()
    }
}
