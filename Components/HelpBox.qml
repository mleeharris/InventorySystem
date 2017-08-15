//UNUSED CODE//

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

    signal xClicked()
    signal questionClicked()

    color: "#00000000"
    property alias setHeight: root.height
    property alias setWidth: root.width
    property alias stateUpLevel: root.state
    property alias infoText: info_text.text
    property alias stockHistory: stock_history.text

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
                state: "open"
            }
            PropertyChanges {
                target: stock_history;
                state: "open"
            }
        },
        State {
            name: "closed";
            PropertyChanges {
                target: main_box;
                height: root.height
                width: root.width
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
                state: "closed"
            }
            PropertyChanges {
                target: stock_history;
                state: "closed"
            }
        }
    ]

    transitions:[
        Transition {
            from: "open"; to: "closed";
            SequentialAnimation {
                PropertyAnimation {
                    target: info_text
                    property: visible
                    duration: 10
                }
                PropertyAnimation {
                    target: stock_history
                    property: visible
                    duration: 10
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: main_box
                        property: "height"
                        duration: 200
                    }
                    NumberAnimation {
                        target: main_box
                        property: "width"
                        duration: 200
                    }
                }
            }
        },
        Transition {
            from: "closed"; to: "open";
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: main_box
                        property: "height"
                        duration: 200
                    }
                    NumberAnimation {
                        target: main_box
                        property: "width"
                        duration: 200
                    }
                }
//                PropertyAnimation {
//                    target: info_text
//                    property: visible
//                    duration: 1000
//                }
//                PropertyAnimation {
//                    target: stock_history
//                    property: visible
//                    duration: 1000
//                }
            }
        }
    ]

    Rectangle {
        id: main_box

        color: "#585858"

        anchors.top: root.top
        anchors.right: root.right
        height: root.height
        width: root.width
        radius: 40
        border.color: "black"
        border.width: 2

        Rectangle {
            id: x_holder

            color: "#00000000"
            anchors.right: main_box.right
            anchors.top: main_box.top
            height: root.height
            width: root.width

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
                    PropertyChanges {
                        target: main_box
                        border.width: 4
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
                    PropertyChanges {
                        target: main_box
                        border.width: 0
                    }
                }
            ]

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
                    root.xClicked()
                    root.state = "closed"
                }
            }
        }

        Rectangle {
            id: question_holder
            color: "#00000000"
            anchors.right: main_box.right
            anchors.top: main_box.top
            height: root.height
            width: root.width

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
                anchors.margins: 10
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
                    root.questionClicked()
                    root.state = "open"
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

            anchors.top: main_box.top
            anchors.left: main_box.left
            anchors.topMargin: 100
            anchors.leftMargin: 40
            width: main_box.width/2-40
            height: main_box.height
            font.pointSize: 20
            lineHeight: 1.5
            wrapMode: Text.Wrap
            text: ''
        }

        Text {
            id: stock_history

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
            width: main_box.width - info_text.width
            height: main_box.height
            font.pointSize: 15
            maximumLineCount: 27
            lineHeight: 1.05
            wrapMode: Text.Wrap
            text: ''
        }
    }
}
