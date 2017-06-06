var component;
var sprite;

function createScannedItemObjects() {
    component = Qt.createComponent("qrc:/Components/ScannedItem.qml");
    //console.log("component: ", component)
    if (component.status == Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation() {
    if (component.status == Component.Ready) {
        global_vars.numItems++
//        console.log("GlobVars.itemList: ", GlobVars.itemList)
//        console.log("global_vars.numItems: ", global_vars.numItems)
//        console.log("GlobVars.itemList[global_vars.numItems]: ", (GlobVars.itemList)[global_vars.numItems])
        //var NewObject = component.createObject(root, {"x": 615, "y": (global_vars.numItems)*(global_vars.itemDownShift)+30, "item_id.text": (GlobVars.itemList)[global_vars.numItems-1]});
        GlobVars.objectList.push(NewObject)
        //item_listmodel.append(NewObject)
        //console.log("GlobVars.objectList: ", GlobVars.objectList)
//        console.log("NewObject: ", NewObject)
//        console.log("NewObject.x: ", NewObject.x)
//        console.log("NewObject.item_id.text: ", NewObject.item_id.text)
//        console.log("component2: ", component)
//        return NewObject
    }
    else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
