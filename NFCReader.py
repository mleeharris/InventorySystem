#! /usr/bin/env python
import re, argparse
from smartcard.System import readers
import datetime, sys

#ACS ACR122U NFC Reader
#Suprisingly, to get data from the tag, it is a handshake protocol
#You send it a command to get data back
#This command below is based on the "API Driver Manual of ACR122U NFC Contactless Smart Card Reader"
COMMAND = [0xFF, 0xCA, 0x00, 0x00, 0x00] #handshake cmd needed to initiate data transfer

# get all the available readers
r = readers()
#print "Available readers:", r

def stringParser(dataCurr):
#--------------String Parser--------------#
    #([85, 203, 230, 191], 144, 0) -> [85, 203, 230, 191]
    if isinstance(dataCurr, tuple):
        temp = dataCurr[0]
        code = dataCurr[1]
    #[85, 203, 230, 191] -> [85, 203, 230, 191]
    else:
        temp = dataCurr
        code = 0

    dataCurr = ''

    #[85, 203, 230, 191] -> bfe6cb55 (int to hex reversed)
    for val in temp:
        # dataCurr += (hex(int(val))).lstrip('0x') # += bf
        dataCurr += format(val, '#04x')[2:] # += bf

    #bfe6cb55 -> BFE6CB55
    dataCurr = dataCurr.upper()

    #if return is successful
    if (code == 144):
        return dataCurr

def readBlock(page):
        try:
            connection = reader.createConnection()
            status_connection = connection.connect()
            connection.transmit(COMMAND)
            #Read command [FF, B0, 00, page, #bytes]
            resp = connection.transmit([0xFF, 0xB0, 0x00, int(page), 0x10])
            dataCurr = stringParser(resp)

            #only allows new tags to be worked so no duplicates
            if(dataCurr is not None):
                dataCurr = dataCurr.decode("hex")
                print (dataCurr)
                #print (dataCurr + " read from page " + str(page))
            else:
                sys.stdout.write("Error")
                #print ("Error: Couldnt read page " + str(page) + ". Authentication needed")
        except Exception,e:
            sys.stdout.write("Error")
            #print ("Error: Couldnt read page " + str(page) + ". Connection problem.")

def authBlock(page, keynum):
    if (int(page)%4 == 3):
        print ("Error: You cannot authenticate trailer blocks")
    else:
        try:
            connection = reader.createConnection()
            status_connection = connection.connect()
            connection.transmit(COMMAND) 
            WRITE_COMMAND = [0xFF, 0x86, 0x00, 0x00, 0x05, 0x01, 0x00, int(page), 0x60, int(keynum)]
            #print(WRITE_COMMAND)
            
            resp = connection.transmit(WRITE_COMMAND)
            if (resp[1] == 144):
                print("Authenticated block: " + str(page))
            if (resp[1] == 99):
                sys.stdout.write("Error")
                #print ("Error: Authentication of block " + str(page) + " unsuccessful")
        except Exception, e:
            sys.stdout.write("Error")
            #print ("Error: Authentication Error No. 2")

def updateBlock(page, value):
    if (int(page)%4 == 3):
        print ("Error: You cannot update trailer blocks")
    else: 
        try:
            connection = reader.createConnection()
            status_connection = connection.connect()
            connection.transmit(COMMAND)
            print (int(page)) 
            WRITE_COMMAND = [0xFF, 0xD6, 0x00, int(page), 0x10, int(value[0:2], 16), int(value[2:4], 16), int(value[4:6], 16), int(value[6:8], 16), int(value[8:10], 16), int(value[10:12], 16), int(value[12:14], 16), int(value[14:16], 16), int(value[16:18], 16), int(value[18:20], 16), int(value[20:22], 16), int(value[22:24], 16), int(value[24:26], 16), int(value[26:28], 16), int(value[28:30], 16), int(value[30:32], 16)]
            # Let's write a page Page 9 is usually 00000000
            #print(WRITE_COMMAND)
            resp = connection.transmit(WRITE_COMMAND)
            #print (resp)
            if resp[1] == 144:
                print (value + " written to page " + str(page))
            if resp[1] == 99:
                sys.stdout.write("Error")
                #print ("Error: Could not write " + value + " to page " + str(page) + ". Authentication needed")
        except Exception, e:
            sys.stdout.write("Error")
            #print ("Error: Could not write " + value + " to page " + str(page)  + ". Connection problem.")

def addKey(keynum, key):
    try:
        connection = reader.createConnection()
        status_connection = connection.connect()
        connection.transmit(COMMAND)
        WRITE_COMMAND = [0xFF, 0x82, 0x00, int(keynum), 0x06, int(key[0:2], 16), int(key[2:4], 16), int(key[4:6], 16), int(key[6:8], 16), int(key[8:10], 16), int(key[10:12], 16)]
        print(WRITE_COMMAND)

        resp = connection.transmit(WRITE_COMMAND)
        if (resp[1] == 144):
            print ("Added key " + str(keynum) + " as " + str(key))
        if (resp[1] == 99):
            sys.stdout.write("Error")
            #print ("Error: Unsuccessful addition of key number " + str(keynum))
    except Exception, e:
        sys.stdout.write("Error")
        #print ("Error: Unsuccessful addition of key number " + str(keynum))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Read / write NFC tags')
    usingreader_group = parser.add_argument_group('usingreader')
    usingreader_group.add_argument('--usingreader', nargs=1, metavar='READER_ID', help='Reader to use [0-X], default is 0')

    read_group = parser.add_argument_group('read')
    read_group.add_argument('--read', nargs=1, metavar='PAGE', help='Input the block you want to read')

    auth_group = parser.add_argument_group('auth')
    auth_group.add_argument('--auth', nargs=2, metavar=('PAGE', 'KEYNUM'), help='Input the block you want to authenticate (no trailers), then the key you are matching it with')

    update_group = parser.add_argument_group("update")
    update_group.add_argument('--update',nargs=2, metavar=('PAGE', 'DATA'), help='Input the block you want to update (no trailers), then the data (16 bytes)')

    addkey_group = parser.add_argument_group("addkey")
    addkey_group.add_argument('--addkey', nargs=2, metavar=('KEYNUM','KEY'), help='Input 0 or 1 for the key number, then 6 bytes for the key')

    args = parser.parse_args()

    #Choosing which reader to use
    if args.usingreader:
        usingreader = args.usingreader[0]
        if (int(usingreader) >= 0 and int(usingreader) <= len(r)-1):
            reader = r[int(usingreader)]
        else:
            reader = r[0]
    else:
        reader = r[0]

    #print "Using:", reader
    
    #Page numbers are sent as ints, not hex, to the reader
    if args.read:
        page = args.read[0]
        readBlock(int(page))

    if args.auth:
        page = args.auth[0]
        keynum = args.auth[1]
        authBlock(int(page), int(keynum))

    if args.update:
        page = args.update[0]
        data = args.update[1]

        data = data.encode("hex")
        # print data
        # print type(data)

        # print len(data)
        if (len(data) < 32):
            left = 32-len(data)
            i = len(data)
            while (i < 32):
                data = data + '0'
                i += 1

        data = data.upper()

        updateBlock(int(page), data)

    if args.addkey:
        keynum = args.addkey[0]
        key = args.addkey[1]
        addKey(int(keynum), key)
