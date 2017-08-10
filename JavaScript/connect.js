/*Amine's and Shane's Code*/

/* ***************************************************************************

                                   JAVASCRIPT

 *************************************************************************** */

var actionSuccess = 0;

function test() {

    //queryHandler("wrong","stuff","http://192.168.10.16:3001","users","","login","","POST", "");
    //queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","users","","login","","POST");

    //queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","1","addStock","quantity=5","PUT")
    //queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","2","","","PUT");

    // ADD QUERY HERE TO TEST
}

/* ******************************** QUERY HANDLER ***************************************************** */


function login(username, password) {
    //console.log(username);
    //console.log(password);
    queryHandler(username, password, "http://192.168.10.16:3001", "users", "", "login", "", "POST", "", "");
}

function logout(username, password) {
    //console.log(username);
    //console.log(password);
    queryHandler(username, password, "http://192.168.10.16:3001", "users", "", "logout", "", "GET", "", "");
}

function checkIn(itemListIn) {
    var i = 0;
    while (i < itemListIn.length) {
        //console.log("itemListIn[i]: ", itemListIn[i])
        queryHandler(global_vars.username, global_vars.realpass, "http://192.168.10.16:3001", "parts", itemListIn[i], "addStock", "quantity=1", "PUT", "", itemListIn[i]);
        i += 1
    }
}

function checkOut(itemList) {
    var i = 0;
    while (i < itemList.length) {
        //console.log("itemList[i]: ", itemList[i])
        //console.log ("=======================NEW QUERY==============================================================================")
        queryHandler(global_vars.username, global_vars.realpass, "http://192.168.10.16:3001", "parts", itemList[i], "removeStock", "quantity=1", "PUT", "", itemList[i]);
        i += 1
    }
}

function lookUp(item) {
    queryHandler(global_vars.username, global_vars.realpass, "http://192.168.10.16:3001", "parts", item, "", "", "GET", "lookUp", "");
}

function addUser(newusername, newpassword) {
    global_vars.addUser = false
    var userstring = '{"newPassword":"' + newpassword + '","username":"' + newusername + '","protected":false}'
//    console.log('userstring: ', userstring);
    queryHandler("admin", "abc123pass", "http://192.168.10.16:3001","users","","",userstring,"POST", "addUser", "");
}

function addUserAdmin(newusername, newpassword) {
    global_vars.addUser = false
    var userstring = '{"newPassword":"' + newpassword + '","username":"' + newusername + '","protected":true}'
//    console.log('userstring: ', userstring);
    queryHandler("admin", "abc123pass", "http://192.168.10.16:3001","users","","",userstring,"POST", "addUser", "");
}

function addPart(newItem, newLocation) {
    global_vars.addPart = false
    var itemstring = '{"name":"' + newItem + '","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"' + newLocation + '","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}'
    //var itemstring = '{"name":"' + newItem + '","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}'
    //console.log("itemstring: ", itemstring)
    //console.log('{"name":"LastInsertzzz","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}');
    queryHandler("admin", "abc123pass", "http://192.168.10.16:3001", "parts", "", "", itemstring, "POST", "addPart", newItem);
    //queryHandler("admin", "abc123pass", "http://192.168.10.16:3001", "parts", "", "", '{"name":"Insertinoz","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/5","@type":"StorageLocation","name":"tool_room_wallA","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}', "POST", "addPart", newItem);
}

function setStock(item, stocknumber) {
    global_vars.setStock = false
    var stockstring = 'quantity=num'
    stockstring = stockstring.replace('num',stocknumber)
    //console.log("stockstring: ", stockstring)

    //queryHandler("partMaster", "warehouseMaster","http://192.168.10.16:3001","parts","27","setStock","quantity=156","PUT", "", item);
    queryHandler("admin", "abc123pass", "http://192.168.10.16:3001", "parts", item, "setStock", stockstring, "PUT", "", item);
}

function getStockHistory(item) {

    //queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","stock_entries","","","start=0&order=%5B%7B%22property%22%3A%22dateTime%22%2C%22direction%22%3A%22DESC%22%7D%5D&filter=%5B%7B%22subfilters%22%3A%5B%5D%2C%22property%22%3A%22part%22%2C%22operator%22%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2F0005%22%7D%5D","GET", "lookupHistory", item);
    //console.log(typeof item)
    item = item.toString()
    item = item.slice(0,-1)
    var stockstring = "start=0&order=%5B%7B%22property%22%3A%22dateTime%22%2C%22direction%22%3A%22DESC%22%7D%5D&filter=%5B%7B%22subfilters%22%3A%5B%5D%2C%22property%22%3A%22part%22%2C%22operator%22%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2F" + item + "%22%7D%5D"
    //var stockstring = "start=0&order=%5B%7B%22property%22%2%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2Fitemzzz%22%7D%5D"
    //stockstring = stockstring.replace('itemzzz',item)
    //console.log("stockstring: ", stockstring)
    queryHandler(global_vars.username, global_vars.realpass, "http://192.168.10.16:3001", "stock_entries", "", "", stockstring, "GET", 'lookupHistory', item);

}

function queryHandler(user, password, server, module, partID, command, json, method, command2, item) {
    var restURL = server + "/api/"
        if (module != "")
            restURL += module;

        if (partID != "")
            restURL += "/" + partID.toString();

        if (command != "")
            restURL += "/" + command;

        if (module == "stock_entries") {
            restURL += "?" + json;
            json = "";
        }
        httpConnect(restURL, user, password, json, command, method, command2, item);
}

function httpConnect(urlStr, user, password, json, command, method, command2, item) {

    console.log("urlStr: ", urlStr)

    var encode =  encode64(string2Bin(user + ":" + password));
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {

            console.log("===============MSG HANDLER===================")
            if (xmlhttp.status > 199 && xmlhttp.status < 300) {
                responseHandler(xmlhttp.responseText, xmlhttp.getAllResponseHeaders(), command, command2, item);
            }
            else {
                errorHandler(xmlhttp.responseText, xmlhttp.getAllResponseHeaders(), command, command2, item)
            }
        }

        if(xmlhttp.readyState == xmlhttp.HEADERS_RECEIVED) {

        }
    }
    //console.log(urlStr);
    xmlhttp.open(method, urlStr, true);
    xmlhttp.setRequestHeader("Authorization", "Basic " + encode);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded ; charset=UTF-8");
    xmlhttp.setRequestHeader("Content-length", json.length + "");
    xmlhttp.send(json);
}

function errorHandler(response, headers, command, command2, item) {
    console.log("Action Unsuccessful")
    switch(command) {
        case "login":
            console.log("Couldn't log in");
            global_vars.loggedIn = 0;
            break;

        case "logout":
            console.log("Logged Out");
            break;

        case "addStock":
            console.log("Couldn't check in part");
            global_funcs.addBadIn(item);
            global_vars.checkInError = 1;
            break;

        case "removeStock":
            console.log("Couldn't check out part");
            global_funcs.addBadOut(item);
            global_vars.checkOutError = 1;
            break;

        case "setStock":
            console.log("Couldn't set stock");
            global_vars.setStock = false;
            break;

        default:
            switch(command2) {
                case "lookUp":
                    console.log("Couldn't lookup part");
                    global_vars.lookupName = "???"
                    global_vars.lookupStock = "???"
                    global_vars.lookupString = "Couldn't find item " + global_vars.scannedItem
                    global_vars.checkinpage_error = "Item " + global_vars.scannedItem + " not found"
                    global_vars.checkoutpage_error = "Item " + global_vars.scannedItem + " not found"
                    break;

                case "lookupHistory":
                    console.log("Couldn't lookup stock history");
                    break;

                case "addUser":
                    console.log("Couldn't add user");
                    global_vars.addUser = false;
                    global_vars.admin_api_error = "Couldn't add new user"
                    break;

                case "addPart":
                    console.log("Couldn't add part " + item);
                    global_vars.addPart = false;
                    global_vars.admin_api_error = "Couldn't add new part"

            }
    }
}

function responseHandler(response, headers, command, command2, item) {
    if (command != "logout") {
        var arr = JSON.parse(response);
    }

    console.log("Action Successful")
//    console.log("************************* RESPONSE HEADERS  ********************************\n");

//    console.log(headers);

//    console.log("********************* RESPONSE BODY ************************************\n");

//    console.log(response);

    switch(command) {
        case "addStock":
            //Where responses are going to be handled
            global_funcs.addGoodIn(item);
            console.log("Add Stock Executed\n");
            break;

        case "removeStock":
            //Where responses are going to be handled
            global_funcs.addGoodOut(item);
            console.log("Remove Stock Executed\n");
            break;

        case "login":
            if(arr) {
                console.log("Connected");
                console.log("Welcome " + arr["username"]);
                global_vars.loggedIn = 1;
                //console.log("loggedIn: ", global_vars.loggedIn)
            }
            break;

        case "logout":
            console.log("Logged Out");
            break;

        case "setStock":
            console.log("Set Stock Executed\n");
            global_vars.setStock = true;
            break;

        default:
            switch(command2) {
                case "lookUp":
                    console.log("Lookup Completed\n")
                    //console.log("********************* PARTS INFORMATION ************************************\n");

                    //for an easier use of JSONS try using https://jsonformatter.curiousconcept.com/
//                    console.log("Name: " + arr["name"]);
//                    console.log("internal Part Number: " + arr["internalPartNumber"]);
//                    console.log("Stock Level: " + arr["stockLevel"] + " " + arr["partUnit"]["name"]);
//                    console.log("Storage Location: " + arr["storageLocation"]["name"]);
//                    console.log("Type: " + arr["@type"]);
//                    console.log("Description: " + arr["description"]);
//                    console.log("Minimum Stock: " + arr["minStockLevel"]);
//                    console.log("Low Stock: " + arr["lowStock"]);

                    global_vars.lookupString = '';
                    global_vars.lookupString += ("Name: " + arr["name"] + "\n");
                    global_vars.lookupString += ("ID: " + arr["@id"] + "\n");
                    global_vars.lookupString += ("Stock Level: " + arr["stockLevel"] + " " + arr["partUnit"]["name"] + "\n");
                    global_vars.lookupString += ("Storage Location: " + arr["storageLocation"]["name"] + "\n");
                    global_vars.lookupString += ("Type: " + arr["@type"] + "\n");
                    global_vars.lookupString += ("Description: " + arr["description"] + "\n");
                    //global_vars.lookupString += ("Minimum Stock: " + arr["minStockLevel"] + "\n");

                    console.log("yoooo")

                    global_vars.lookupName = arr["name"]
                    global_vars.lookupStock = arr["stockLevel"]

                    global_vars.checkinpage_error = "Item " + global_vars.lookupName + " found, added to list"
                    global_vars.checkoutpage_error = "Item " + global_vars.lookupName + " found, added to list"

//                    //********************************* DISPLAY IMAGE ************************************************

//                    var xhr = getXMLHttpRequest();
//                    xhr.onreadystatechange=ProcessResponse;
//                    imageUrl="http://192.168.10.97/api/part_attachments/"+arr["internalPartNumber"]+"/getFile"
//                    xhr.open("GET",imageUrl, true);
//                    xhr.overrideMimeType('text/plain; charset=x-user-defined');
//                    xhr.send(null);

//                    function ProcessResponse()
//                    {
//                       if(xhr.readyState==4)
//                      {
//                        if (xhr.status > 199 && xhr.status < 300)
//                        {
//                            retval ="";
//                            for (var i=0; i<=xhr.responseText.length-1; i++)
//                                  retval += String.fromCharCode(xhr.responseText.charCodeAt(i) & 0xff);
//                       }
//                     }

//                    //Display image encoded in 64:
//                    encode64(xhr.responseText);
                    break;

                case "lookupHistory":
                    console.log("lookupHistory executed")
                    //console.log("length: ", arr["hydra:member"].length)
                    var i = 0;
                    var usercheckout = '';
                    var datetime = '';
                    var action = '';
                    var linetoadd = '';
                    global_vars.stockHistory = '';
                    while (i < arr["hydra:member"].length) {
                        //console.log("user", arr["hydra:member"][i]["user"])
                        if (arr["hydra:member"][i]["user"]) {
                            usercheckout = arr["hydra:member"][i]["user"]["username"]
                            datetime = arr["hydra:member"][i]["dateTime"]
                            if (arr["hydra:member"][i]["stockLevel"] === -1) {
                                action = "Checkout"
                            }
                            if (arr["hydra:member"][i]["stockLevel"] === 1) {
                                action = "Checkin"
                            }
                            linetoadd = "-User: " + usercheckout + ",   Action: " + action + "\nDatetime: " + datetime + "\n\n"
                            global_vars.stockHistory += linetoadd
                        }
                        i += 1
                    }
                    break;

                case "addUser":
                    global_vars.addUser = true
                    console.log("Add User Executed\n")
                    break;

                case "addPart":
                    global_vars.addPart = true
                    global_vars.addedItem = item
                    console.log("Add Part Executed\n")
                    break;
            }
    }
}

        /* ******************************** BYTES FROM STRING **************************************************/

function string2Bin(str) {
    var bytes = [];

    for (var i = 0; i < str.length; ++i)
    {
        bytes.push(str.charCodeAt(i));
    }
    return bytes;
}

        /* ****************************************** ENCODING FOR HEADER ***************************************/

function encode64(buffer) {
    var binary = '';
    var bytes = new Uint8Array(buffer);
    var len = bytes.byteLength;
    for (var i = 0; i < len; i++) {
        binary += String.fromCharCode(bytes[i]);
    }
    return Qt.btoa(binary);
}

/* ******************************** CORRESPONDENCE TABLE && EXAMPLES ************************************


   ADD STOCK X : command: addStock parameters: quantity=X&comment=Y&price=Z

   REMOVE STOCK X : command: removeStock parameters: quantity=X&comment=Y

   SET STOCK TO XYZ : command: setStock parameters: quantity=XYZ&comment=Y

   CHECK INFORMATION OF A PART : command: BLANK parameters: BLANK [Include ID only]

   ADD USER : CHANGE MODULE TO USERS

               Credentials are to be built in this format :

               {"newPassword":"passe","username":"user"}

   ADD NEW ITEM : CHANGE MODULE TO PARTS

               Parameters format :

               {"name":"InsertTest","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}

   MODIFY ITEM : CHANGE MODULE TO PARTS AND SPECIFY PART ID !

               Parameters format :

               '{"@type":"Part","name":"InsertTest","description":"","footprint":null,"comment":"","minStockLevel":2,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"metaPartMatches":null,"categoryPath":"Root Category","@context":"/api/contexts/Part","category":{"@id":"/api/part_categories/1","@type":"PartCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category","category":{"@id":"/api/storage_location_categories/1","@type":"StorageLocationCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0}}}'


    ITEM HISTORY : CHANGE MODULE TO stock_entries

                SET PARAMETERS TO start=0&order=%5B%7B%22property%22%3A%22dateTime%22%2C%22direction%22%3A%22DESC%22%7D%5D&filter=%5B%7B%22subfilters%22%3A%5B%5D%2C%22property%22%3A%22part%22%2C%22operator%22%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2F+     ID      +%22%7D%5D


        EXAMPLES :

    // ADD STOCK

    queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","1","addStock","quantity=666","PUT");


   // REMOVE STOCK

    queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","1","removeStock","quantity=666","PUT");

   //SET STOCK

    queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","1","setStock","quantity=114","PUT");

   // VIEWING AN ITEMS INFORMATION

        queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","2","","","PUT");

   // ADDING A USER

         queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","users","","",'{"newPassword":"pass","username":"user","admin":0}',"POST");

   // ADDING AN ITEM

        queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","","",
        ' {"name":"LastInsert","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}
                   ',"POST");

   // MODIFYING AN ITEM

        queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","parts","1","",
        ' {"@type":"Part","name":"sst","description":"","footprint":null,"comment":"","minStockLevel":999666,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"metaPartMatches":null,"categoryPath":"Root Category","@context":"/api/contexts/Part","category":{"@id":"/api/part_categories/1","@type":"PartCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category","category":{"@id":"/api/storage_location_categories/1","@type":"StorageLocationCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0}}}'
            ,"PUT");

    // TESTING CREDENTIALS WHILE LOGIN

     queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","users","","login","","POST");


    // LOGGING OUT

     queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","users","","logout","","GET");


    // GETTING STOCK HISTORY FOR A SPECIFIC ITEM

     queryHandler("partMaster","warehouseMaster","http://192.168.10.16:3001","stock_entries","","","start=0&order=%5B%7B%22property%22%3A%22dateTime%22%2C%22direction%22%3A%22DESC%22%7D%5D&filter=%5B%7B%22subfilters%22%3A%5B%5D%2C%22property%22%3A%22part%22%2C%22operator%22%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2F2%22%7D%5D","GET");

  ******************************************************************************************************* */
