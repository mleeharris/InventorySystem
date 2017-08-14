import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle  {
    id: root
    objectName: "scanneditem"
    property alias item_id: item_txt
    property alias item_name: name
    property alias item_stock: stock
    property alias forQ: root.height
    property bool checked: false
    property alias stateUpLevel2: helpbox.stateUpLevel
    property alias infoText: helpbox.infoText
    property alias stockHistory: helpbox.stockHistory

    signal pressed()
    signal released()
    signal clicked()

    signal questionClicked()
    signal xClicked()

    state: "visible"
    states:[
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
        },
        State {
            name: "extra";
            PropertyChanges {
                target: root;
                visible: false;
            }
        }
    ]

    color: "#00000000"
    height: global_vars.itemHeight
    width: global_vars.itemWidth

    Rectangle {
        color: "black"
        opacity: 0.5
        anchors.fill: parent
        radius: global_vars.itemWidth/8
    }

    Text {
        id: item_txt
        anchors.left: root.left
        anchors.leftMargin: global_vars.display(30)
        anchors.top: root.top
//        anchors.right: root.horizontalCenter
//        anchors.rightMargin: global_vars.display(160)
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: name
        anchors.left: item_txt.right
        anchors.leftMargin: global_vars.display(50)
        anchors.top: root.top
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - global_vars.display(25)
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: stock
        anchors.left: name.right
        anchors.leftMargin: global_vars.display(50)
        anchors.top: root.top
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - global_vars.display(25)
        smooth: true
        color: global_vars.darkGrayColor
        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: x_holder

        color: "#00000000"
        //color: "white"

        anchors.right: root.right
        anchors.top: root.top
        height: root.height
        width: root.height

        Image {
            id: x
            height: root.height - (root.height/4)
            width: root.height - (root.height/4)
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/Images/x_gray.png"
        }

        MouseArea {
            id: x_ma
            anchors.fill: parent
            onPressed: {
                root.pressed()
            }
            onReleased: {
                root.released()
            }
            onClicked: {
                root.clicked()
            }
        }
    }

    HelpBox {
        state: "closed"
        id: helpbox
        z: 100
        anchors.top: root.top
        anchors.right: x_holder.left
        anchors.rightMargin: 10
        setHeight: root.height
        setWidth: root.height
        onXClicked: {
            root.xClicked()
        }
        onQuestionClicked: {
            root.questionClicked()
        }
    }

    function testing() {
        console.log("ahhhhhhh")
    }
}
