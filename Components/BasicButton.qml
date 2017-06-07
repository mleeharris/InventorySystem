import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "button"
    property alias label: button_txt
    property color buttonColor
    property alias location: icon.source
    property alias iconHeight: icon.height
    property alias iconAnchors: icon.anchors

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
}
