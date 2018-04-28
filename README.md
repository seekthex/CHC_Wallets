---------
Create CHC Testnet Wallet
---------
Version: 0.0.0.1

This is a collection shell scripts to assist in creating CHC testnet wallet(s)

Highly suggested to start on clean installation of Ubuntu

Experimental scripts, use at your own risk!!!

---------
Supported OS
---------
-Ubuntu

---------------
Tested Systems:
---------------
-Ubuntu 16.04

--------------
build-chc-Ub14.sh  
--------------

Description: Creates a .16 CHC "cli" testnet wallet on Ubuntu 16.04 with sentinel and pre-configured

Usage:

On a brand new VPS server copy and paste the following line(s) and press ENTER


Setup firewall

  (optional) If you would  like to setup firewall to allow OpenSSH, port 11994 and 21995

  Note: firewall will not become enabled until you reboot the Server

  curl https://raw.githubusercontent.com/seekthex/Server_Setup_Scripts/master/install-firewall.sh | bash

Setup Swap File

  (Recommend) if you would like to create a 1 gig permanent swap filesystem

  curl https://raw.githubusercontent.com/seekthex/Server_Setup_Scripts/master/install-1-swap-p.sh | bash


To install Chaincoin -cli wallet with Sentinel

  curl https://raw.githubusercontent.com/seekthex/create_chc_testnet/master/build-tchc-Ub14.sh | bash

**********

Donations:

Bitcoin:

Chaincoin:

Many thanks to the CHC Community
