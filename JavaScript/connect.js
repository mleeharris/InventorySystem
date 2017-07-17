/*Amine's Code*/

/* ***************************************************************************

                                   JAVASCRIPT

 *************************************************************************** */

var actionSuccess = 0;

function test() {

    //queryHandler("partMaster","warehouseMaster","http://192.168.10.97","users","","login","","POST");

    queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","1","addStock","quantity=5","PUT")
    //queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","2","","","PUT");

    // ADD QUERY HERE TO TEST
}

/* ******************************** QUERY HANDLER ***************************************************** */


function login(username, password) {
    console.log(username);
    console.log(password);
    queryHandler(username,password,"http://192.168.10.97","users","","login","","POST");
}

function queryHandler(user, password, server, module, partID, command, json,method){

    var restURL=server + "/api/"

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

        httpConnect(restURL,user,password,json,command,method);
}

function httpConnect(urlStr, user, password, json, command, method) {

    var encode =  encode64(string2Bin(user + ":" + password));
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {

            responseHandler(xmlhttp.responseText,xmlhttp.getAllResponseHeaders(),command);

        }

        if(xmlhttp.readyState == xmlhttp.HEADERS_RECEIVED) {

          }
    }
    console.log(urlStr);
    xmlhttp.open(method, urlStr, true);
    xmlhttp.setRequestHeader("Authorization", "Basic " + encode);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded ; charset=UTF-8");
    xmlhttp.setRequestHeader("Content-length", json.length + "");
    xmlhttp.send(json);
}

function responseHandler(response,headers,command) {

    try {
        var arr = JSON.parse(response);
        actionSuccess = 1;
    }
    catch(err) {
        actionSuccess = 0;
        console.log("Action Failed")
        switch(command) {
            case "login":
                console.log("Couldn't log in")
                global_vars.loggedIn = 0;
        }
    }

    if (actionSuccess == 1) {
        console.log("************************* RESPONSE HEADERS  ********************************\n");

        console.log(headers);

        console.log("********************* RESPONSE BODY ************************************\n");

        console.log(response);

        switch(command) {
            case "addStock":
                //Where responses are going to be handled
                 console.log("Add Stock Executed\n");
                break;

            case "setStock":
                //Where responses are going to be handled
                console.log("Set Stock Executed\n");
                break;

            case "removeStock":
                //Where responses are going to be handled
                console.log("Remove Stock Executed\n");
                break;

            case "login":
                if(arr) {
                    console.log("Connected");
                    console.log("Welcome " + arr["username"]);
                    global_vars.loggedIn = 1;
                    console.log("loggedIn: ", global_vars.loggedIn)
                }
                break;

            case "logout":
                break;

            default:
                console.log("********************* PARTS INFORMATION ************************************\n");

                //for an easier use of JSONS try using https://jsonformatter.curiousconcept.com/
                console.log("Name :" + arr["name"]);
                console.log("internal Part Number :" + arr["internalPartNumber"]);
                console.log("Stock Level :" + arr["stockLevel"] + " " + arr["partUnit"]["name"]);
                console.log("Storage Location :" + arr["storageLocation"]["name"]);
                console.log("Type :" + arr["@type"]);
                console.log("Description :" + arr["description"]);
                console.log("Minimum Stock :" + arr["minStockLevel"]);
                console.log("Low Stock ? :" + arr["lowStock"]);

                /* ********************************* DISPLAY IMAGE ************************************************

                var xhr = getXMLHttpRequest();
                xhr.onreadystatechange=ProcessResponse;
                imageUrl="http://192.168.10.97/api/part_attachments/"+arr["internalPartNumber"]+"/getFile"
                xhr.open("GET",imageUrl, true);
                xhr.overrideMimeType('text/plain; charset=x-user-defined');
                xhr.send(null);

                function ProcessResponse()
                {
                   if(xhr.readyState==4)
                  {
                    if (xhr.status==200)
                    {
                        retval ="";
                        for (var i=0; i<=xhr.responseText.length-1; i++)
                              retval += String.fromCharCode(xhr.responseText.charCodeAt(i) & 0xff);
                   }
                 }

                Display image encoded in 64:  encode64(xhr.responseText);

                */
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

    queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","1","addStock","quantity=666","PUT");


   // REMOVE STOCK

    queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","1","removeStock","quantity=666","PUT");

   //SET STOCK

    queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","1","setStock","quantity=114","PUT");

   // VIEWING AN ITEMS INFORMATION

        queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","2","","","PUT");

   // ADDING A USER

         queryHandler("partMaster","warehouseMaster","http://192.168.10.97","users","","",'{"newPassword":"pass","username":"user"}',"POST");

   // ADDING AN ITEM

        queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","","",
        ' {"name":"LastInsert","description":"","comment":"","minStockLevel":0,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"category":{"@context":"/api/contexts/PartCategory","@id":"/api/part_categories/1","@type":"PartCategory","categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":"@local-tree-root","index":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"footprint":null,"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category"},"stockLevels":[{"stockLevel":288,"price":0,"dateTime":null,"correction":false,"comment":null,"user":null}]}
                   ',"POST");

   // MODIFYING AN ITEM

        queryHandler("partMaster","warehouseMaster","http://192.168.10.97","parts","1","",
        ' {"@type":"Part","name":"sst","description":"","footprint":null,"comment":"","minStockLevel":999666,"status":"","needsReview":false,"partCondition":"","productionRemarks":"","internalPartNumber":"","metaPart":false,"metaPartMatches":null,"categoryPath":"Root Category","@context":"/api/contexts/Part","category":{"@id":"/api/part_categories/1","@type":"PartCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0},"partUnit":{"@id":"/api/part_measurement_units/1","@type":"PartMeasurementUnit","name":"Pieces","shortName":"pcs","default":true},"storageLocation":{"@id":"/api/storage_locations/6","@type":"StorageLocation","name":"Column1_Bin3","image":null,"categoryPath":"Root Category","category":{"@id":"/api/storage_location_categories/1","@type":"StorageLocationCategory","parent":null,"categoryPath":"Root Category","expanded":true,"name":"Root Category","description":null,"parentId":null,"index":-1,"depth":0,"expandable":true,"checked":null,"leaf":false,"cls":"","iconCls":"","icon":"","glyph":"","root":null,"isLast":false,"isFirst":false,"allowDrop":true,"allowDrag":true,"loaded":false,"loading":false,"href":"","hrefTarget":"","qtip":"","qtitle":"","qshowDelay":0,"children":null,"visible":true,"text":"","lft":0,"rgt":0,"lvl":0}}}'
            ,"PUT");

    // TESTING CREDENTIALS WHILE LOGIN

     queryHandler("partMaster","warehouseMaster","http://192.168.10.97","users","","login","","POST");


    // LOGGING OUT

     queryHandler("partMaster","warehouseMaster","http://192.168.10.97","users","","logout","","GET");


    // GETTING STOCK HISTORY FOR A SPECIFIC ITEM

     queryHandler("partMaster","warehouseMaster","http://192.168.10.97","stock_entries","","","start=0&order=%5B%7B%22property%22%3A%22dateTime%22%2C%22direction%22%3A%22DESC%22%7D%5D&filter=%5B%7B%22subfilters%22%3A%5B%5D%2C%22property%22%3A%22part%22%2C%22operator%22%3A%22%3D%22%2C%22value%22%3A%22%2Fapi%2Fparts%2F2%22%7D%5D","GET");

  ******************************************************************************************************* */