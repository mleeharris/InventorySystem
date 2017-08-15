import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "qrc:/Components"
import "qrc:/Layers"
import "qrc:/Function"
import "qrc:/Images"
import "qrc:/JavaScript/globalVars.js" as GlobVars

Item {

//    Clock2 {
//        id: clock_checkout
//    }

//    Clock2 {
//        id: clock_checkin
//    }

//    function addGoodOut(item) {
//        //GlobVars.checkGoodOut.push(global_vars.lookupName)
//        GlobVars.checkGoodOut.push(item)
//    }

//    function addBadOut(item) {

//        GlobVars.checkBadOut.push(item)
//    }

//    function checkOutMsg() {
//        var i = 0;
//        if (clock_checkout.connected == false) {
//            clock_checkout.connect(function() {
//                if (global_vars.checkOutError == 0) {
//                    if (GlobVars.checkGoodOut.length > 0) {
//                        global_vars.endpage_error = "All items checked out. These are: "
//                        i = 0;
//                        while (i < GlobVars.checkGoodOut.length) {
//                            global_vars.endpage_error += GlobVars.checkGoodOut[i] + ' '
//                            i += 1
//                        }
//                    }
//                    else {
//                        global_vars.endpage_error = "No items entered, so none were checked out"
//                    }
//                }
//                if (global_vars.checkOutError == 1) {
//                    global_vars.endpage_error = "Error checking out these items: "
//                    i = 0;
//                    while (i < GlobVars.checkBadOut.length) {
//                        global_vars.endpage_error += GlobVars.checkBadOut[i] + '  '
//                        i += 1
//                    }
//                    global_vars.endpage_error += "\n\n"
//                    if (GlobVars.checkGoodOut.length > 0) {
//                        global_vars.endpage_error += "But successfully checked out these items: "
//                        i = 0;
//                        while (i < GlobVars.checkGoodOut.length) {
//                            global_vars.endpage_error += GlobVars.checkGoodOut[i] + ' '
//                            i += 1
//                        }
//                    }
//                }
//            });
//        }

//        clock_checkout.delay(2000);
//        GlobVars.checkBadOut.splice(0,GlobVars.checkBadOut.length)
//        GlobVars.checkGoodOut.splice(0,GlobVars.checkGoodOut.length)
//    }

//    function addGoodIn(item) {
//        GlobVars.checkGoodIn.push(item)
//    }

//    function addBadIn(item) {
//        GlobVars.checkBadIn.push(item)
//    }

//    function checkInMsg() {
//        var i = 0;
//        if (clock_checkin.connected == false) {
//            clock_checkin.connect(function() {
//                if (global_vars.checkInError == 0) {
//                    if (GlobVars.checkGoodIn.length > 0) {
//                        global_vars.endpage_error = "All items checked in successfully. These are: "
//                        i = 0;
//                        while (i < GlobVars.checkGoodIn.length) {
//                            global_vars.endpage_error += GlobVars.checkGoodIn[i] + ' '
//                            i += 1
//                        }
//                    }
//                    else {
//                        global_vars.endpage_error = "No items entered, so none were checked in"
//                    }
//                }
//                if (global_vars.checkInError == 1) {
//                    global_vars.endpage_error = "Error checking in these items:"
//                    i = 0;
//                    while (i < GlobVars.checkBadIn.length) {
//                        global_vars.endpage_error += GlobVars.checkBadIn[i] + '  '
//                        i += 1
//                    }
//                    global_vars.endpage_error += "\n\n"
//                    if (GlobVars.checkGoodIn.length > 0) {
//                        global_vars.endpage_error += "But successfully checked in these items: "
//                        i = 0;
//                        while (i < GlobVars.checkGoodIn.length) {
//                            global_vars.endpage_error += GlobVars.checkGoodIn[i] + ' '
//                            i += 1
//                        }
//                    }
//                }
//            });
//        }

//        clock_checkin.delay(2000);
//        GlobVars.checkBadIn.splice(0,GlobVars.checkBadIn.length)
//        GlobVars.checkGoodIn.splice(0,GlobVars.checkGoodIn.length)
//    }
}
