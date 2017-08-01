README.txt

This is a complete inventory system consisting of three main components.
1. RFID cards communicate with a ACR122U reader using NFC reader. The cards hold hold user information, which is
constantly polled and updated.
2. The user interface allows a user to login, checkin items, checkout items, lookup items, and logout. Also built in
are basic "admin" functionalities such as adding new cards and server users. To access this, use the "admin" RFID card.
3. The server integration utilizes Javascript and partKeepr API to update real time with the user's actions.

To use, the ACR122U reader must be plugged in and have NFC reader installed.

Numerous error catches should ensure smooth operation
