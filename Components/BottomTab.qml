import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root_top
    objectName: "button"
    property alias label: tab_txt
    property alias location: power.source
    clip: false
    signal pressed()
    signal released()
    signal clicked()

    color: "#00000000"
    height: global_vars.tabHeightUnpressed
    width: global_vars.tabWidth
    radius: height/8

    transitions:[
        Transition {
            from: "Up"; to: "Down"; reversible: true
            NumberAnimation {
                target: black_background
                property: "height"
                duration: 200
            }
            NumberAnimation {
                target: tab_txt
                property: "opacity"
                duration: 200
            }
            NumberAnimation {
                target: root
                property: "height"
                duration: 200
            }
            NumberAnimation {
                target: root
                property: "anchors.topMargin"
                duration: 200
            }
            NumberAnimation {
                target: btn_ma
                property: "width"
                duration: 200
            }
            NumberAnimation {
                target: btn_ma
                property: "height"
                duration: 200
            }
            NumberAnimation {
                target: black_background
                property: "radius"
                duration: 200
            }
            NumberAnimation {
                target: root
                property: "radius"
                duration: 200
            }
            PropertyAnimation {
                target: power
                property: "opacity"
                duration: 200
            }
        }
    ]

    states:[
        State {
            name: "Up";
            PropertyChanges {
                target: black_background
                height: global_vars.tabHeightUnpressed
            }
            PropertyChanges {
                target: tab_txt
                opacity: 100
            }
            PropertyChanges {
                target: root
                height: global_vars.tabHeightUnpressed
                anchors.topMargin: 0
            }
            PropertyChanges {
                target: btn_ma
                width: root_top.width
                height: root_top.height
            }
            PropertyChanges {
                target: power
                opacity: 1
            }
        },
        State {
            name: "Down";
            PropertyChanges {
                target: black_background
                height: 100
                radius: 50
            }
            PropertyChanges {
                target: tab_txt
                opacity: 0
            }
            PropertyChanges {
                target: root
                height: 100
                radius: 50
                anchors.topMargin: 330
            }
            PropertyChanges {
                target: btn_ma
                width: 0
                height: 0
            }
            PropertyChanges {
                target: power
                opacity: 0
            }
        }
    ]

    FontLoader {
        id: default_font
        name: "BebasNeue"
        source: "qrc:/Typefaces/BebasNeue.otf"
    }

    Rectangle {
        id: root
        color: global_vars.tabColorUnpressed
        anchors.fill: parent
        radius: height/8
        z: 2
    }

    Rectangle {
        id: blue_cover
        height: 47
        width: global_vars.tabWidth + 50
        color: global_vars.tabColorUnpressed
        z: 3

        anchors.bottom: root.bottom
        anchors.left: root.left
    }

    Rectangle {
        id: black_background
        height: global_vars.tabHeightUnpressed
        width: global_vars.tabWidth
        radius: height/8
        color: "black"
        z: 1
        anchors.top: root.top
        anchors.topMargin: 10
        anchors.left: root.left
        anchors.leftMargin: 20
    }

    Text {
        id: tab_txt
        anchors.left: root.left
        anchors.top: root.top
        anchors.right: root.right
        anchors.bottom: root.bottom
        font.family: "BebasNeue"
        text: ""
        font.pointSize: global_vars.tabSize
        smooth: true
        color: global_vars.grayColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        z: 4
    }

    Image {
        id: power
        anchors.left: root.left
        anchors.leftMargin: 100
        anchors.top: root.top
        anchors.right: root.right
        anchors.rightMargin: 100
        anchors.bottom: root.bottom
        anchors.bottomMargin: 40

        smooth: true
        opacity: 1
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        fillMode: Image.PreserveAspectFit
        width: 10
        height: 10
        source: ''
        z: 4
    }

    MouseArea {
        id: btn_ma
        width: root_top.width
        height: root_top.height
        onPressed: {
            root_top.pressed()
            root.color = global_vars.tabColorPressed
            root_top.height = global_vars.tabHeightPressed
            tab_txt.color = global_vars.darkGrayColor
        }
        onReleased: {
            root_top.released()
            root.color = global_vars.tabColorUnpressed
            root_top.height = global_vars.tabHeightUnpressed
            tab_txt.color = global_vars.grayColor
        }
        onClicked: {
            root_top.clicked()
        }
    }
}
