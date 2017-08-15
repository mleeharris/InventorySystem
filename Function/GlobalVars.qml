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
    property string admin_api2_error: 'There seems to be nothing here yet'

    /*Background*/
    property string grayColor: "#DCDCDC"
    property string darkGrayColor: "#C8C8C8"

    /*Button Characteristics*/
    property int buttonHeight: display(150)
    property int buttonWidth: buttonHeight*4+display(50)
    property int buttonSize: display(70)

    /*Tab Characteristics*/
    property int tabHeightUnpressed: display(400)
    property int tabHeightPressed: display(375)
    property int tabWidth: display(400)
    property int tabSize: display(90)
    property string tabColorUnpressed: "#9EDAE2"
    property string tabColorPressed: "#8AC6CE"

    property int tabRightMargin: display(130)
    property int tabSpace: display(870)

    /*DropShadow Characteristics*/
    property int dropShadowVertOffset: display(10)
    property int dropShadowHorizOffset: display(10)

    /*Welcome Page*/
    property int buttonTopMargin: display(10)
    property int buttonLeftMargin: display(240)

    /*Scanned Item*/
    property int itemHeight: display(80)
    property int itemWidth: display(1100)
    property int itemFontsize: display(50)

    property int scrollWidth: display(1230)

    property string currentItem: ''
    property int numItems: 0
    property int itemDownShift: display(100)

    /*Icons*/
    property int iconDefaultHeight: display(95)
    property int login_height: display(93)
    property int login_offset: display(-4)
    property int check_in_height: display(110)
    property int check_out_height: display(117)
    property int check_in_offset: display(-5)
    property int check_out_offset: display(-3)
    property int clear_height: display(92)
    property int clear_offset: display(-4)
    property int startover_height: display(95)
    property int startover_offset: display(-4)

    /*Admin Console*/
    property int buttonHeightAdmin: display(130)
    property int buttonWidthAdmin: display(400)

    /*API*/
    property int loggedIn: 0
    property bool addUser: false
    property bool addPart: false
    property bool setStock: false

    property int checkInError: 0
    property int checkOutError: 0
    property string lookupString: ''
    property string stockHistory: ''

    property string lookupName: ''
    property string scannedItem: ''
    property string lookupStock: ''

    property string addedItem: ''

    /*Helpbox*/
    property string tempInfo: 'yooooooooooooo'
    property string tempStockHistory: 'ayyyyyyyyyyyyyyyyyyy'
    property string stockHistoryHelp: 'yoo'
    property string infoTextHelp: 'ayyy'

    /*Display Size*/
    property int fullWidth: 1920
    property int fullHeight: 1080


    //change these to computer screen size
    property int tempWidth: 1920
    property int tempHeight: 1080


    /*
    property int tempWidth: 1920
    property int tempHeight: 1080
    */

    /*Check In Redo*/
    property int checkInCheck: 0
    property int checkOutCheck: 0
    property int checkInItemHeight: display(80)
    property int checkInItemWidth: display(1100)

    function display(fullSize) {
        //change this to true to get custom sizes
        var changeSize = false;

        var newSize = 0;
        var fullWidth = 1920
        var fullHeight = 1080

        if (changeSize == true) {
            var tempWidth = 854
            var tempHeight = 480
            newSize = (tempWidth/fullWidth) * fullSize
            return newSize
        }

        if (changeSize == false) {
            return fullSize
        }
    }
}
