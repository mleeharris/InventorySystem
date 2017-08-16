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
                height: global_vars.display(80)
            }
            PropertyChanges {
                target: stock_history;
                state: "closed"
            }
            PropertyChanges {
                target: info_text;
                state: "closed"
            }
            PropertyChanges {
                target: image
                state: "closed"
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
                target: image
                state: "open"
            }
            PropertyChanges {
                target: root
                height: global_vars.display(530)
            }
        }
    ]

    transitions:[
        Transition {
            from: "visible"; to: "extra";
            NumberAnimation {
                target: root
                property: "height"
                duration: 200
            }
        },
        Transition {
            from: "extra"; to: "visible";
            NumberAnimation {
                target: root
                property: "height"
                duration: 200
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
        anchors.topMargin: global_vars.display(0)
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
        anchors.verticalCenterOffset: global_vars.display(9)
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
        anchors.verticalCenterOffset: global_vars.display(9)
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
            anchors.margins: global_vars.display(10)
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
            anchors.margins: global_vars.display(10)
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

        state: "closed"
        states:[
            State {
                name: "open";
                PropertyChanges {
                    target: info_text;
                    visible: true;
                    opacity: 1
                }
                PropertyChanges {
                    target: info_text
                    color: global_vars.darkGrayColor
                }
            },
            State {
                name: "closed";
                PropertyChanges {
                    target: info_text;
                    visible: false;
                    opacity: 0
                }
                PropertyChanges {
                    target: info_text
                    color: "#CCCCCC"
                }
            }
        ]

        transitions:[
            Transition {
                from: "open"; to: "closed";
                PropertyAnimation {
                    target: info_text
                    property: color
                    duration: 200
                }
            },
            Transition {
                from: "closed"; to: "open";
                PropertyAnimation {
                    target: info_text
                    property: color
                    duration: 200
                }
            }
        ]

        anchors.top: root.top
        anchors.left: root.left
        anchors.topMargin: global_vars.display(100)
        anchors.leftMargin: global_vars.display(40)
        width: root.width/2-global_vars.display(40)
        height: root.height
        font.pointSize: global_vars.display(20)
        lineHeight: global_vars.display(1.5)
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

        transitions:[
            Transition {
                from: "open"; to: "closed";
                PropertyAnimation {
                    target: stock_history
                    property: visible
                    duration: 500
                }
            },
            Transition {
                from: "closed"; to: "open";
                PropertyAnimation {
                    target: stock_history
                    property: visible
                    duration: 500
                }
            }
        ]

        anchors.top: info_text.top
        anchors.left: info_text.right
        anchors.leftMargin: global_vars.display(50)
        width: root.width - info_text.width
        height: root.height
        font.pointSize: global_vars.display(15)
        maximumLineCount: global_vars.display(15)
        lineHeight: global_vars.display(1.05)
        wrapMode: Text.Wrap
        text: ''
    }

    Image {
        id: image
        anchors.top: info_text.top
        anchors.right: info_text.right
        width: 150
        height: 100
        //source: "http://www.pngmart.com/?p=11285"
        source: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"

        state: "closed"
        states:[
            State {
                name: "open";
                PropertyChanges {
                    target: image;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "closed";
                PropertyChanges {
                    target: image;
                    visible: false;
                    opacity: 0
                }
            }
        ]
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
