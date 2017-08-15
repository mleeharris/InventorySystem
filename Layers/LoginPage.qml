import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"
import "qrc:/JavaScript/connect.js" as Connect
import "qrc:/JavaScript/globalVars.js" as GlobVars

Rectangle {
    id: root
    visible: true
    width: global_vars.tempWidth
    height: global_vars.tempHeight
    objectName: "login_page"

    signal nextLayer(string currentLayer, string nextLayer)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Down"
        right_tab.state = "Up"

        main_window.tabOperationForLoginPage.connect(tabOperationLoginPage)
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
        height: global_vars.tempHeight
        width: global_vars.tempWidth
        source: "qrc:/Images/background_opening_3.jpg"
    }

    Text {
        id: please_scan
        anchors.top: parent.top
        anchors.topMargin: global_vars.display(150)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "How  To???"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: global_vars.display(200)
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        //label.text: "Power"
        location: "qrc:/Images/power.png"
        onPressed: {
            location = "qrc:/Images/power_dark.png"
        }
        onReleased: {
            location = "qrc:/Images/power.png"
        }
        onClicked: {
            global_vars.howto_error = "Exiting..."
            Connect.logoutQuit(global_vars.username, global_vars.realpass)
        }
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: right_tab.left
        anchors.rightMargin: global_vars.tabSpace
        id: middle_tab
        //label.text: "Back"
        location: "qrc:/Images/back.png"
        onPressed: {
            location = "qrc:/Images/back_dark.png"
        }
        onReleased: {
            location = "qrc:/Images/back.png"
        }
        onClicked: {
            tabOperationLoginPage("middle", "Down")
            nextLayer(root.objectName, "main")
            root.state = "hidden"
        }
    }

    Error {
        id: howto_error
        errorHeight: global_vars.display(300)
        errorWidth: global_vars.display(600)
        errorText: global_vars.howto_error

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: global_vars.display(130)
    }

    function tabOperationLoginPage(tabnum, state) {
        if (tabnum === "middle") {
            if (state === "Up") {
                middle_tab.state = "Up"
            }
            if (state === "Down") {
                middle_tab.state = "Down"
            }
        }
        if (tabnum === "right") {
            if (state === "Up") {
                right_tab.state = "Up"
            }
            if (state === "Down") {
                right_tab.state = "Down"
            }
        }
    }
}


