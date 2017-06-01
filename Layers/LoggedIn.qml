import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "logged_in"

    signal nextLayer(string nextLayer)
    signal tabOperationMain(string tabnum, string state)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Down"
        main_window.tabOperationLoggedIn.connect(tabOperationLoggedIn)
    }

    states: [
        State {
            name: "visible";
            PropertyChanges {
                target: root;
                visible: true;
                opacity: 1
            }
        },
        State {
            name: "hidden";
            PropertyChanges {
                target: root;
                visible: false;
                opacity: 0
            }
        }
    ]

    Image {
        id: background_image
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: logged_in_text
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 200
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Login"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 60
    }



    property int wrapperHeight: 800
    property int wrapperWidth: 1700

    property int wrapperSize: wrapperHeight/7
    property int vertSpacing: wrapperHeight/9
    property int horizSpacing: wrapperWidth/6
    property int boxHeight: wrapperHeight/5
    property int boxLength: wrapperWidth/2

    Rectangle {
        id: userpass_wrapper
        color: "#00000000"
        width: wrapperHeight
        height: wrapperWidth
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 165
        anchors.leftMargin: 200

        Column {
            id: labels
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: parent.left
            spacing: vertSpacing

            z: 1

            Rectangle {
                id: user_label
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: "Username: "
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }

            Rectangle {
                id: pass_label
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: "Password: "
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }
        }

        Column {
            id: info
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: labels.right
            anchors.leftMargin: horizSpacing
            spacing: vertSpacing

            z: 3

            Rectangle {
                id: user_info
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: global_vars.username
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }

            Rectangle {
                id: pass_info
                height: boxHeight
                width: 0.5 * userpass_wrapper.width
                color: "#00000000"

                Text {
                    text: global_vars.password
                    font.family: "Bebas Neue"
                    color: "black"
                    font.pointSize: wrapperSize
                }
            }
        }

        Column {
            id: white_boxes
            height: parent.height
            width: parent.width/2
            anchors.top: parent.top
            anchors.left: labels.right
            anchors.leftMargin: horizSpacing - (wrapperSize/2)
            spacing: vertSpacing

            z: 2

            Rectangle {
                id: white_box_1
                color: "white"
                height: boxHeight
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4
                radius: height/2
            }

            Rectangle {
                color: "white"
                height: boxHeight
                width: 0.5 * userpass_wrapper.width + wrapperSize * 4
                radius: height/2
            }
        }

    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        label.text: "Power"
        onClicked: {
            Qt.quit()
            root.state = "hidden"
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: right_tab.left
        anchors.rightMargin: global_vars.tabSpace
        id: middle_tab
        label.text: "Back"
        onClicked: {
            tabOperationLoggedIn("middle", "Down")
            slot_switchLayer("main")
            root.state = "hidden"
        }
    }

    function tabOperationLoggedIn(tabnum, state) {
        if (tabnum === "middle") {
            if (state === "Up") {
                  middle_tab.state = "Up"
                  tabOperationMain("middle", "Up")
            }
            if (state === "Down") {
                middle_tab.state = "Down"
                tabOperationMain("middle", "Down")
            }
        }
    }
}


