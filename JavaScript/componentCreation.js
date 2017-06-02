var component;
var sprite;

function createScannedItemObjects() {
    component = Qt.createComponent("qrc:/Components/ScannedItem.qml");
    if (component.status == Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation() {
    if (component.status == Component.Ready) {
        component.createObject(root, {"x": 100, "y": 150});
    } else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
