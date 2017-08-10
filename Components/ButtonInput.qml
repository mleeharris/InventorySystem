import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "button_input"
    property alias label: button_txt
    property color buttonColor
    property alias location: icon.source
    property alias iconHeight: icon.height
    property alias iconAnchors: icon.anchors
    property alias maxLength: text_input.maximumLength
    property alias inputText: text_input.displayText
    property alias helpText: helper.text

    clip: false
    signal pressed()
    signal released()
    signal clicked()

    height: global_vars.buttonHeight
    width: global_vars.buttonWidth
    color: "#00000000"

    Rectangle {
        id: black_part
        height: root.height
        width: root.width
        anchors.top: root.top
        anchors.horizontalCenter: parent.horizontalCenter
        radius: height/4
        border.width: 4
        border.color: "black"
        color: "black"

        FontLoader{
            id: default_font
            name: "BebasNeue"
            source: "qrc:/Typefaces/BebasNeue.otf"
        }

        state: "unpressed"
        states:[
            State {
                name: "unpressed";
                PropertyChanges {
                    target: black_part;
                    anchors.topMargin: global_vars.buttonTopMargin
                    anchors.horizontalCenterOffset: 0
                }
            },
            State {
                name: "pressed";
                PropertyChanges {
                    target: black_part;
                    anchors.topMargin: global_vars.buttonTopMargin + global_vars.dropShadowVertOffset
                    anchors.horizontalCenterOffset: global_vars.dropShadowHorizOffset
                }
            }
        ]

        Rectangle {
            id: holder
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "#00000000"

            Text {
                id: button_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: icon.width/1.5
                anchors.verticalCenter: parent.verticalCenter
                font.family: "BebasNeue"
                text: ""
                font.pointSize: global_vars.buttonSize
                smooth: true
                color: global_vars.grayColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Image {
                id: icon
                anchors.right: button_txt.left
                anchors.rightMargin: global_vars.display(25)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                height: global_vars.defaultIconHeight
                width: icon.height
                source: ''
            }
        }

        MouseArea {
            id: btn_ma
            anchors.fill: black_part
            onPressed: {
                root.pressed()
                button_shadow.state = "hidden"
                black_part.state = "pressed"
            }
            onReleased: {
                root.released()
                button_shadow.state = "visible"
                black_part.state = "unpressed"
            }
            onClicked: {
                root.clicked()
                text_input.text = ''
            }
        }
    }

    DropShadow {
        id: button_shadow
        anchors.fill: black_part
        horizontalOffset: global_vars.dropShadowHorizOffset
        verticalOffset: global_vars.dropShadowVertOffset
        radius: global_vars.display(8)
        samples: radius*2+1
        color: "#80000000"
        source: black_part
        transparentBorder: true
        cached: true

        state: "visible"
        states:[
            State {
                name: "visible";
                PropertyChanges {
                    target: button_shadow;
                    visible: true;
                    opacity: 1
                }
            },
            State {
                name: "hidden";
                PropertyChanges {
                    target: button_shadow;
                    visible: false;
                    opacity: 0
                }
            }
        ]
    }

    Rectangle {
        id: black_background

        anchors.left: root.right
        anchors.leftMargin: global_vars.display(25)
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: global_vars.display(10)

        color: "white"
        radius: height/2
        height: root.height - global_vars.display(40)
        width: root.width

        TextInput {
            id: text_input
            font.family: "Helvetica"
            text: ''
            font.pointSize: global_vars.display(26)
            height: parent.height
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: global_vars.display(40)
            anchors.verticalCenter: black_background.verticalCenter
            anchors.verticalCenterOffset: global_vars.display(28)
            maximumLength: 15

//            state: "notyet"
//            states:[
//                State {
//                    name: "notyet";
//                    PropertyChanges {
//                        target: text_input;
//                        opacity: 0.5
//                    }
//                },
//                State {
//                    name: "yet";
//                    PropertyChanges {
//                        target: text_input;
//                        opacity: 1.0
//                    }
//                }
//            ]
//        }

//        MouseArea {
//            anchors.fill: parent
//            id: mouse_area
//            onPressed: {
//                text_input.state = "yet"
//            }
        }
    }

    Text {
        id: helper
        anchors.top: black_background.bottom
        anchors.horizontalCenter: black_background.horizontalCenter
        anchors.topMargin: global_vars.display(3)
        font.pointSize: global_vars.display(15)
        text: ''
    }
}
