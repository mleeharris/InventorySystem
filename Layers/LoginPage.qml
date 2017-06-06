import QtQuick 2.6
import QtQuick.Window 2.2
import "qrc:/Components"

Rectangle {
    id: root
    visible: true
    width: 1920
    height: 1080
    objectName: "login_page"

    signal nextLayer(string nextLayer)
    signal tabOperationMain(string tabnum, string state)

    Component.onCompleted: {
        root.state = "hidden"

        middle_tab.state = "Down"
        main_window.tabOperationLoginPage.connect(tabOperationLoginPage)
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
        id: please_scan
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Type  In  Info?"
        font.family: "Typo Graphica"
        color: "Black"
        font.pointSize: 200
    }

    BottomTab {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: global_vars.tabRightMargin
        id: right_tab
        //label.text: "Power"
        location: "qrc:/Images/power_gray.png"
        onPressed: {
            location = "qrc:/Images/power_darkgray.png"
        }
        onReleased: {
            location = "qrc:/Images/power_gray.png"
        }
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
            tabOperationLoginPage("middle", "Down")
            slot_switchLayer("main")
            root.state = "hidden"
        }
    }

    function tabOperationLoginPage(tabnum, state) {
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

    function userpass(userpass) {
        console.log('userpass: ', userpass)
        userpass = userpass.split(':')
        global_vars.username = userpass[0]
        global_vars.password = userpass[1]
        console.log("username: ", global_vars.username)
        console.log("password: ", global_vars.password)
        root.state = "hidden"
        nextLayer("logged_in")
    }
}


