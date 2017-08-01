import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle  {
    id: root
    objectName: "helpbox"
    signal pressed()
    signal released()
    signal clicked()

    color: "#00000000"
    height: 1000
    width: 1000

    state: "closed"
    states:[
        State {
            name: "open";
            PropertyChanges {
                target: main_box;
                height: 1000;
                width: 1000;
            }
            PropertyChanges {
                target: x_holder;
                state: "open"
            }
            PropertyChanges {
                target: question_holder;
                state: "open"
            }
            PropertyChanges {
                target: info_text;
                visible: true;
                opacity: 1
            }
            PropertyChanges {
                target: stock_history;
                visible: true;
                opacity: 1
            }
        },
        State {
            name: "closed";
            PropertyChanges {
                target: main_box;
                height: 100
                width: 100
            }
            PropertyChanges {
                target: x_holder;
                state: "closed"
            }
            PropertyChanges {
                target: question_holder;
                state: "closed"
            }
            PropertyChanges {
                target: info_text;
                visible: false;
                opacity: 0
            }
            PropertyChanges {
                target: stock_history;
                visible: false;
                opacity: 0
            }
        }
    ]

    transitions:[
        Transition {
            from: "open"; to: "closed"; reversible: true
            SequentialAnimation {
                NumberAnimation {
                    target: main_box
                    property: "height"
                    duration: 200
                }
                PropertyAnimation {
                    target: info_text
                    property: visible
                    duration: 1000
                }
            }
            SequentialAnimation {
                PropertyAnimation {
                    target: stock_history
                    property: visible
                    duration: 1000
                }
                NumberAnimation {
                    target: main_box
                    property: "width"
                    duration: 200
                }
            }
        }
    ]

    Rectangle {
        id: main_box
        color: "gray"
        anchors.top: root.top
        anchors.right: root.right
        height: root.height
        width: root.width
        radius: 40
        border.color: "black"
        border.width: 10

        Rectangle {
            id: x_holder

            color: "#00000000"
            anchors.right: main_box.right
            anchors.top: main_box.top
            height: 100
            width: 100

            state: "closed"
            states:[
                State {
                    name: "open";
                    PropertyChanges {
                        target: x;
                        visible: true;
                        opacity: 1
                    }
                    PropertyChanges {
                        target: x_ma;
                        visible: true;
                        opacity: 1
                    }
                },
                State {
                    name: "closed";
                    PropertyChanges {
                        target: x;
                        visible: false;
                        opacity: 0
                    }
                    PropertyChanges {
                        target: x_ma;
                        visible: false;
                        opacity: 0
                    }
                }
            ]

            Image {
                id: x
                anchors.fill: parent
                anchors.margins: 20
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
                    root.state = "closed"
                }
            }
        }

        Rectangle {
            id: question_holder
            color: "#00000000"
            anchors.right: main_box.right
            anchors.top: main_box.top
            height: 100
            width: 100

            state: "closed"
            states:[
                State {
                    name: "open";
                    PropertyChanges {
                        target: question;
                        visible: false;
                        opacity: 0
                    }
                    PropertyChanges {
                        target: question_ma;
                        visible: false;
                        opacity: 0
                    }
                },
                State {
                    name: "closed";
                    PropertyChanges {
                        target: question;
                        visible: true;
                        opacity: 1
                    }
                    PropertyChanges {
                        target: question_ma;
                        visible: true;
                        opacity: 1
                    }
                }
            ]

            Image {
                id: question
                anchors.fill: parent
                anchors.margins: 20
                source: "qrc:/Images/question_darkgray.png"
            }

            MouseArea {
                id: question_ma
                anchors.fill: parent
                onPressed: {
                    root.pressed()
                }
                onReleased: {
                    root.released()
                }
                onClicked: {
                    root.clicked()
                    root.state = "open"
                }
            }
        }

        Text {
            id: info_text

            anchors.top: main_box.top
            anchors.left: main_box.left
            anchors.topMargin: 180
            anchors.leftMargin: 40
            width: main_box.width/2-40
            height: main_box.height
            font.pointSize: 20
            lineHeight: 1.5
            wrapMode: Text.Wrap
            text: global_vars.tempInfo
        }

        Text {
            id: stock_history

            anchors.top: info_text.top
            anchors.left: info_text.right
            anchors.leftMargin: 40
            width: main_box.width - info_text.width
            height: main_box.height
            font.pointSize: 15
            maximumLineCount: 27
            lineHeight: 1.05
            wrapMode: Text.Wrap
            text: global_vars.tempStockHistory
        }
    }
}
