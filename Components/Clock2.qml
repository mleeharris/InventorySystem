import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "clock"

    color: "#00000000"
    property bool connected: false

    Timer {
        id: timer
    }

    function connect(cb) {
        root.connected = true;
        //console.log("YOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
        timer.triggered.connect(cb);
    }

    function delay(delayTime) {
        //root.connected = true;
        timer.interval = delayTime;
        timer.repeat = false;
        timer.start();
    }

    function disconnect() {
        timer.disconnect();
    }
}
