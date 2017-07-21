import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Rectangle  {
    id: root
    objectName: "clock"

    color: "#00000000"

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.triggered.connect(cb);
        timer.repeat = false;
        timer.start();
    }
}
