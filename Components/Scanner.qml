import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"
import "qrc:/Function/"

/***********************************************************************/
// This component is created in main.qml to handle all cases of
// barcode scan in
/***********************************************************************/

Item  {
    id: root
    objectName: "scanner"

    signal pressed()
    signal released()
    signal clicked()
    signal temp()
    signal scanned()

    Keys.onPressed: {
                //console.log("event.key: ", event.key)
                //console.log("event.text: ", event.text)
                if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
                    global_vars.event = event.text
                    root.temp()
                    //global_vars.currentItem = global_vars.currentItem + event.text
                }
                if (String(event.key) == '16777220') {
                    //console.log("global_vars.currentItem: ", global_vars.currentItem)
                    root.scanned()
                    //global_vars.currentItem = ''
                }
    }

    states:[
        State {
            name: "on";
            PropertyChanges {
                target: root
                enabled: true
                focus: true
            }
        },
        State {
            name: "off";
            PropertyChanges {
                target: root
                enabled: false
                focus: false
            }
        }
    ]
}
