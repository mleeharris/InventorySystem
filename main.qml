import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/Layers"
import "qrc:/Function"

Window {
    id: main_window
    visible: true
    width: 854
    height: 480
    objectName: "MainWindow"

    property string active_layer: ""

    FontLoader {
        id: opening_font
        name: "Instruction"
        source: "qrc:/Typefaces/Instruction.otf"
    }

    Rectangle {
        anchors.fill: parent
        color: "#800000"
    }

    Component.onCompleted: {
        first_main.nextLayer.connect(slot_switchLayer)
        second_main.nextLayer.connect(slot_switchLayer)
        third_main.nextLayer.connect(slot_switchLayer)
        fourth_main.nextLayer.connect(slot_switchLayer)
    }

    /*LAYER DECL*/
    First{id: first_main; x:10; y:10}
    Second{id: second_main; x:10; y:10}
    Third{id: third_main; x:10; y:10}
    Fourth{id: fourth_main; x:10; y:10}

    /*COMPONENT DECL*/
    GlobalVars{id:global_vars}

    Rectangle {
        anchors.fill: parent
        color: "#800000"
        id: object_holder

        states:[
            State {
                name: "visible";
                PropertyChanges {
                    target: object_holder;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "hidden";
                PropertyChanges {
                    target: object_holder;
                    visible: false;
                    opacity: 0
                }
            }
        ]

        Text {
            id: title_text
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Page Selection"
            font.family: "Instruction"
            color: "white"
            font.pointSize: 70

        }

        BasicButton {
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 10
            anchors.top: parent.verticalCenter
            id: first_button
            label.text: "First"
            buttonColor: object_holder.color
            onClicked: {
                slot_switchLayer("first_main")
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 10
            anchors.top: first_button.bottom
            anchors.topMargin: 10
            label.text: "Second"
            buttonColor: object_holder.color
            onClicked: {
                slot_switchLayer("second_main")
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 10
            anchors.top: parent.verticalCenter
            id: third_button
            label.text: "Third"
            buttonColor: object_holder.color
            onClicked: {
                slot_switchLayer("third_main")
                object_holder.state = "hidden"
            }
        }

        BasicButton {
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 10
            anchors.top: third_button.bottom
            anchors.topMargin: 10
            label.text: "Fourth"
            buttonColor: object_holder.color
            onClicked: {
                slot_switchLayer("fourth_main")
                object_holder.state = "hidden"
            }
        }
    }

    function slot_switchLayer(nextLayer) {
        console.log(nextLayer)
        active_layer = nextLayer
        switch(nextLayer) {
            case "main": {
                object_holder.state = "visible"
                break;
            }
            case "first_main": {
                first_main.state = "visible"
                break;
            }
            case "second_main": {
                second_main.state = "visible"
                break;
            }
            case "third_main": {
                third_main.state = "visible"
                break;
            }
            case "fourth_main": {
                fourth_main.state = "visible"
                break;
            }
        }
    }
}
