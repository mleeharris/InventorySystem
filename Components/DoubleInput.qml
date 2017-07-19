import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "double_input"
    property alias label: button_txt
    property color buttonColor
    property alias location: icon.source
    property alias iconHeight: icon.height
    property alias iconAnchors: icon.anchors

    property alias maxLength1: text_input_1.maximumLength
    property alias inputText1: text_input_1.displayText
    property alias textChange1: text_input_1.text
    property alias helpText1: helper_1.text
    property alias maxLength2: text_input_2.maximumLength
    property alias inputText2: text_input_2.displayText
    property alias textChange2: text_input_2.text
    property alias helpText2: helper_2.text
    property alias helpText3: helper_3.text

    clip: false
    signal pressed()
    signal released()
    signal clicked()

    property bool adminClicked: false

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
                anchors.rightMargin: 25
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
            }
        }
    }

    DropShadow {
        id: button_shadow
        anchors.fill: black_part
        horizontalOffset: global_vars.dropShadowHorizOffset
        verticalOffset: global_vars.dropShadowVertOffset
        radius: 8
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
        id: black_background_1

        anchors.left: root.right
        anchors.leftMargin: 25
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 10

        color: "white"
        radius: height/2
        height: root.height - 40
        width: root.width + 220

        TextInput {
            id: text_input_1
            font.family: "Helvetica"
            text: ''
            font.pointSize: 26
            height: parent.height
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: black_background_1.verticalCenter
            anchors.verticalCenterOffset: 28
            maximumLength: 15
        }
    }

    Rectangle {
        id: black_background_2

        anchors.left: black_background_1.right
        anchors.leftMargin: 25
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 10

        color: "white"
        radius: black_background_1.radius
        height: black_background_1.height
        width: black_background_1.width

        TextInput {
            id: text_input_2
            font.family: "Helvetica"
            text: ''
            font.pointSize: 26
            height: parent.height
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: black_background_2.verticalCenter
            anchors.verticalCenterOffset: 28
            maximumLength: 15
        }
    }

    Text {
        id: helper_1
        anchors.top: black_background_1.bottom
        anchors.horizontalCenter: black_background_1.horizontalCenter
        anchors.topMargin: 3
        font.pointSize: 20
        text: ''
    }

    Text {
        id: helper_2
        anchors.top: black_background_2.bottom
        anchors.horizontalCenter: black_background_2.horizontalCenter
        anchors.topMargin: 3
        font.pointSize: helper_1.font.pointSize
        text: ''
    }

    Rectangle {
        id: admin_check

        anchors.left: black_background_2.right
        anchors.leftMargin: 25
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 10

        radius: black_background_1.radius
        height: black_background_1.height
        width: black_background_1.height

        state: "unchecked"
        states:[
            State {
                name: "unchecked";
                PropertyChanges {
                    target: mid_circle;
                    color: "white"
                }
                PropertyChanges {
                    target: root
                    adminClicked: false
                }
            },
            State {
                name: "checked";
                PropertyChanges {
                    target: mid_circle
                    color: "black"
                }
                PropertyChanges {
                    target: root
                    adminClicked: true
                }
            }
        ]

        Rectangle {
            id: mid_circle
            anchors.fill: parent
            anchors.margins: 30
            radius: black_background_1.radius
            color: "black"
        }

        MouseArea {
            id: check_ma
            anchors.fill: parent
            onClicked: {
                if (admin_check.state === "unchecked") {
                    admin_check.state = "checked"
                }
                else if (admin_check.state === "checked") {
                    admin_check.state = "unchecked"
                }
            }
        }
    }

    Text {
        id: helper_3
        anchors.top: admin_check.bottom
        anchors.horizontalCenter: admin_check.horizontalCenter
        anchors.topMargin: 3
        font.pointSize: helper_1.font.pointSize
        text: ''
    }
}
