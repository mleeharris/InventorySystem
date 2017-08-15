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
    property alias stockHistory: stock_history.text
    property alias infoText: info_text.text
//    property alias stateUpLevel2: helpbox.stateUpLevel
//    property alias infoText: helpbox.infoText
//    property alias stockHistory: helpbox.stockHistory

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
            PropertyChanges {
                target: root
                height: 80
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
                target: stock_history;
                state: "open"
            }
            PropertyChanges {
                target: info_text;
                state: "open"
            }
            PropertyChanges {
                target: root
                height: 500
            }
        }
    ]

    color: "#00000000"
    height: global_vars.checkInItemHeight
    width: global_vars.checkInItemWidth

    Rectangle {
        color: "black"
        opacity: 0.5
        anchors.fill: parent
        radius: global_vars.display(40)
    }

    Text {
        id: item_txt
        anchors.left: root.left
        anchors.leftMargin: global_vars.display(30)
        anchors.top: root.top
        anchors.topMargin: 0
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize
        smooth: true
        color: global_vars.darkGrayColor
    }

    Text {
        id: name
        anchors.left: item_txt.right
        anchors.leftMargin: global_vars.display(50)
        anchors.verticalCenter: item_txt.verticalCenter
        anchors.verticalCenterOffset: 9
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - global_vars.display(25)
        smooth: true
        color: global_vars.darkGrayColor
    }

    Text {
        id: stock
        anchors.left: name.right
        anchors.leftMargin: global_vars.display(50)
        anchors.verticalCenter: item_txt.verticalCenter
        anchors.verticalCenterOffset: 9
        anchors.bottom: root.bottom
        font.family: "Helvetica"
        text: ""
        font.pointSize: global_vars.itemFontsize - global_vars.display(25)
        smooth: true
        color: global_vars.darkGrayColor
    }

    Rectangle {
        id: x_holder

        color: "#00000000"
        //color: "white"

        anchors.right: root.right
        anchors.top: root.top
        height: global_vars.checkInItemHeight
        width: global_vars.checkInItemHeight

        Image {
            id: x
            anchors.fill: parent
            anchors.margins: 10
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

    Rectangle {
        id: question_holder
        color: "#00000000"

        anchors.right: x_holder.left
        anchors.top: root.top
        height: global_vars.checkInItemHeight
        width: global_vars.checkInItemHeight

        Image {
            id: question
            anchors.fill: parent
            anchors.margins: 10
            source: "qrc:/Images/question_darkgray.png"
        }

        MouseArea {
            id: question_ma
            anchors.fill: parent
            onPressed: {
                //root.pressed()
            }
            onReleased: {
                //root.released()
            }
            onClicked: {
                if (root.state == "visible") {
                    root.state = "extra";
                }
                else if (root.state == "extra") {
                    root.state = "visible";
                }
            }
        }
    }

    Text {
        id: info_text

        color: global_vars.darkGrayColor

        state: "closed"
        states:[
            State {
                name: "open";
                PropertyChanges {
                    target: info_text;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "closed";
                PropertyChanges {
                    target: info_text;
                    visible: false;
                    opacity: 0
                }
            }
        ]

        anchors.top: root.top
        anchors.left: root.left
        anchors.topMargin: 100
        anchors.leftMargin: 40
        width: root.width/2-40
        height: root.height
        font.pointSize: 20
        lineHeight: 1.5
        wrapMode: Text.Wrap
        text: ''
    }

    Text {
        id: stock_history

        color: global_vars.darkGrayColor

        state: "closed"
        states:[
            State {
                name: "open";
                PropertyChanges {
                    target: stock_history;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "closed";
                PropertyChanges {
                    target: stock_history;
                    visible: false;
                    opacity: 0
                }
            }
        ]

        anchors.top: info_text.top
        anchors.left: info_text.right
        anchors.leftMargin: 50
        width: root.width - info_text.width
        height: root.height
        font.pointSize: 15
        maximumLineCount: 15
        lineHeight: 1.05
        wrapMode: Text.Wrap
        text: ''
    }


//    HelpBox {
//        state: "closed"
//        id: helpbox
//        z: 100
//        anchors.top: root.top
//        anchors.right: x_holder.left
//        anchors.rightMargin: 10
//        setHeight: root.height
//        setWidth: root.height
//        onXClicked: {
//            root.xClicked()
//        }
//        onQuestionClicked: {
//            root.questionClicked()
//        }
//    }

//    function testing() {
//        console.log("ahhhhhhh")
//    }
}
