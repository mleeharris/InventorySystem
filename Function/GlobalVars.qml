import QtQuick 2.2
import "qrc:/JavaScript/globalVars.js" as GlobVars

Item {
    objectName: "GlobalVars"
    property string active_layer: ""

    /*Login*/
    property string username: ''
    property string userpass_creation: ''
    property string password: ''
    property string tempLetter: ''
    property string realpass: ''
    property string event: ''

    /*Error Msgs*/
    property string main_error: 'Welcome'
    property string howto_error: 'There seems to be nothing here yet'
    property string login_error: ''
    property string admin_error: ''
    property string checkpage_error: ''
    property string checkinpage_error: ''
    property string checkoutpage_error: ''
    property string admin_api_error: ''
    property string admin_selection_error: ''
    property string endpage_error: ''

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
    property int itemDownShift: 100

    /*Icons*/
    property int iconDefaultHeight: 95
    property int login_height: 93
    property int login_offset: -4
    property int check_in_height: 110
    property int check_out_height: 117
    property int check_in_offset: -5
    property int check_out_offset: -3
    property int clear_height: 92
    property int clear_offset: -4
    property int startover_height: 95
    property int startover_offset: -4

    /*Admin Console*/
    property int buttonHeightAdmin: 140
    property int buttonWidthAdmin: 400

    /*API*/
    property int loggedIn: 0
    property bool addUser: false

    property int checkInError: 0
    property int checkOutError: 0
    property string lookupString: ''

    property string lookupName: ''
    property string scannedItem: ''
    property string lookupStock: ''
}
