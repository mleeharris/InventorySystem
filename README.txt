README.txt

This is a complete inventory system consisting of three main components.
1. RFID cards communicate with a ACR122U reader using NFC reader. The cards hold hold user information, which is
constantly polled and updated.
2. The user interface allows a user to login, checkin items, checkout items, lookup items, and logout. Also built in
are basic "admin" functionalities such as adding new cards and server users. To access this, use the "admin" RFID card.
3. The server integration utilizes Javascript and partKeepr API to update real time with the user's actions.

To use, the ACR122U reader must be plugged in and have NFC reader installed.

///==================================================================///

1. NFC Reader

The RFID cards are read and written to by using the ACR122U NFC Reader. To use on Ubuntu, the python code "NFCReader.py" within this repository must run correctly.
To do this, 'smartcard reader' must be installed for Python 2.7. If smartcard reader is installed for Python 3+, there is working Python3 NFC code
in this repository called "NFCReader3.py"

To successfully get "NFCReader.py" to run, try:

a. sudo apt-get update
b. sudo apt-get install pcsc-tools pcscd libnfc-bin python-pyscard

Once it is installed and running, you can try writing to the cards. Typing "python NFCReader.py --help" in the command line will list the potential commands.
Here is a list of how to get a card from brand new to user enabled from the command line:

a. "python NFCReader.py --addkey 00 FFFFFFFFFFFF" will add the key 'FFFFFFFFFFFF' to the NFC Reader to the key location 00
b. "python NFCReader.py --auth 04 00" will allow any reader with the key 'FFFFFFFFFFFF' to access the four blocks of memory (04, 05, 06, 07)
c. "python NFCReader.py --read 04" will read 04. 04 is currently the storage location for usernames
d. "python NFCReader.py --read 05" will read 05. 05 is currently the storage location for passwords
e. "python NFCReader.py --update 04 NEWUSERNAME" will change the username to whatever is typed in 'NEWUSERNAME'. 'NEWUSERNAME' is ASCII characters, but it is saved as Hex in the card.
f. "python NFCReader.py --update 05 NEWPASSWORD" will change the password to whatever is typed in 'NEWPASSWORD'. 'NEWPASSWORD' is ASCII characters, but it is saved as Hex in the card.

Here is a list of how to get a card from brand new to user enabled from the user interface:
a. Enter 'FFFFFFFFFFFF' on the upper left box, click "add key'
b. Enter '04' in the bottom left box, click 'auth'
c. Enter 'NEWUSERNAME' in the upper right box, click 'add user'
d. Enter 'NEWPASSWORD' in the bottom right box, click 'add pass'
e. Confirm everything is correct by hitting the 'PRINT' button on the upper right of the screen.

///==================================================================///

2. PartKeepr API
Most of the PartKeepr functionality can be accessed and used easily by going to "admlocal.com" and selecting "PartKeepr". The functionality that is built into the UI are currently
"add user", "add part", and "set stock".

a. "add user" accepts a username, password, and 'admin' field. Unless specifically stated, do not click the admin field.
b. "add part" takes in a new part name and the storage location.
c. "set stock" accepts in the part ID and a new stock number.

In order to use the UI effectively, a new user must be entered in an RFID Card and on PartKeepr. Ensure that the username and password match.

///==================================================================///

3. User Interface
Most of the UI is self explanatory. 90% of interaction with the UI will entail these operations:

a. User places card on scanner. This automatically enters the username and password.
b. User clicks the "login" button.
c. User selects the operation they want to perform. This could be "lookup", "checkin", or "checkout".
d. User concludes operation by hittin "done" on the "checkin" or "checkout" page.

To access the admin pages in the UI, simply scan the admin RFID card on any page of the UI. The admin username is "admin" and the admin password is "abc123pass". Once "login" is clicked,
the UI will provide access to the functions listed in parts 1 and 2 of this README.txt.

Regarding login/logout of the PartKeepr API:
a. Once a user "logs in", hitting any power button or "start over" on the ending page will log them out
b. If a user is "logged in", scanning another card will log them out enable them to sign in with the new card
c. All commands besides admin page commands are carried out with the login credentials of the user.
