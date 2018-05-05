
Create Chaincoin-qt.exe Testnet Wallet
=============

Version: 0.0.0.1

This is a shell script to assist in creating Chaincoin-qt.exe

Start on clean installation of Ubuntu 14.04

Experimental scripts, use at your own risk!!!


### Supported OS
-Ubuntu 14.04 (only)


### Tested Systems:
-Ubuntu 14.04 on Vultr 1024MB server


build-tchc-win-qt-ub14.sh  
--------------

Description: Creates a Chaincoin-qt.exe testnet wallet on Ubuntu 14.04

Usage:

On a brand new VPS server copy and paste the following line(s) and press ENTER


### Setup Swap File


  if you are running a smaller VPS such as a Vultr 512 MB or 1024 MB server you will need to install a 2 Gig Swap
  during the inital compilie of chaincoin.

  To create a 2 Gig Tempary swap

  curl https://raw.githubusercontent.com/seekthex/Server_Setup_Scripts/master/install-2-swap.sh | bash

  Note: You can find more swap file building scripts here.
        https://github.com/seekthex/server_setup_scripts/blob/master/README.md


### To Create Chaincoin-qt.exe


  curl https://raw.githubusercontent.com/seekthex/create_chc_testnet/master/sh/build-tchc-win-qt-ub14.sh | bash

**********

Donations:

Bitcoin:

Chaincoin:

Many thanks to the CHC Community
