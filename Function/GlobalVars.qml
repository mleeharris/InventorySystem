import QtQuick 2.2

Item {
    objectName: "GlobalVars"
    property string active_layer: ""

    /*Background*/
    property string grayColor: "#DCDCDC"
    property string darkGrayColor: "#C8C8C8"

    /*Button Characteristics*/
    property int buttonHeight: 170
    property int buttonWidth: buttonHeight*3
    property int buttonSize: 70

    /*Tab Characteristics*/
    property int tabHeightUnpressed: 400
    property int tabHeightPressed: 385
    property int tabWidth: 400
    property int tabSize: 90
    property string tabColorUnpressed: "#9EDAE2"
    property string tabColorPressed: "#8AC6CE"

    /*DropShadow Characteristics*/
    property int dropShadowVertOffset: 10
    property int dropShadowHorizOffset: 10

    /*Welcome Page*/
    property int buttonTopMargin: 10
    property int buttonLeftMargin: 240
}
