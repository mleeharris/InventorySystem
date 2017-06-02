import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "button"
    property alias label: button_txt
    property color buttonColor
    clip:false
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

        Text {
            id: button_txt
            anchors.left: black_part.left
            anchors.top: black_part.top
            anchors.right: black_part.right
            anchors.bottom: black_part.bottom
            font.family: "BebasNeue"
            text: ""
            font.pointSize: global_vars.buttonSize
            smooth: true
            color: global_vars.grayColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
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
}
