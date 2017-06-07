import QtQuick 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components/"

Item  {
    id: root
    objectName: "button"

    signal userpassScan(string item)
    signal pressed()
    signal released()
    signal clicked()

    Keys.onPressed: {
        if ( (String(event.key) != '16777251') && (String(event.key) != '16777248') ) {
            //console.log('added')
            global_vars.userpass_creation = global_vars.userpass_creation + event.text
        }
        if (String(event.key) == '16777220') {
            //console.log('reset')
            userpassScan(global_vars.userpass_creation)
            global_vars.userpass_creation = ''
        }
    }

    states:[
        State {
            name: "on";
            PropertyChanges {
                target: barcode
                enabled: true
                focus: true
            }
        },
        State {
            name: "off";
            PropertyChanges {
                target: barcode
                enabled: false
                focus: false
            }
        }
    ]
}
