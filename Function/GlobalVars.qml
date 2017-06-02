import QtQuick 2.2

Item {
    objectName: "GlobalVars"
    property string active_layer: ""

    /*Login*/
    property string username: ''
    property string userpass_creation: ''
    property string password: ''
    property string tempLetter: ''

    /*Background*/
    property string grayColor: "#DCDCDC"
    property string darkGrayColor: "#C8C8C8"

    /*Button Characteristics*/
    property int buttonHeight: 150
    property int buttonWidth: buttonHeight*4+50
    property int buttonSize: 70

    /*Tab Characteristics*/
    property int tabHeightUnpressed: 400
    property int tabHeightPressed: 375
    property int tabWidth: 400
    property int tabSize: 90
    property string tabColorUnpressed: "#9EDAE2"
    property string tabColorPressed: "#8AC6CE"

    property int tabRightMargin: 130
    property int tabSpace: 870

    /*DropShadow Characteristics*/
    property int dropShadowVertOffset: 10
    property int dropShadowHorizOffset: 10

    /*Welcome Page*/
    property int buttonTopMargin: 10
    property int buttonLeftMargin: 240

    /*Scanned Item*/
    property int itemHeight: 80
    property int itemWidth: 1100
    property int itemFontsize: 50

    property int scrollWidth: 1230

    property string currentItem: ''
    property int numItems: 0
}
