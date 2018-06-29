
Create CHC Wallets
=============

This is a collection shell scripts to assist in creating CHC wallet(s)

Highly suggested to start on clean installation of Ubuntu

Experimental scripts, use at your own risk!!!


### Supported OS
-Ubuntu


### Tested Systems:
-Ubuntu 14.04
-Ubuntu 16.04


For Mainnet Builds
--------------

Description: Creates a .16 CHC "cli"  wallet on Ubuntu 14.04,16.04 with pre-configured sentinel



### Setup firewall

  (Recommended) If you would  like to setup firewall to allow OpenSSH, port 11994 and 21995

  Note: firewall will not become enabled until you reboot the Server

  Usage:

  On a brand new VPS server signed in as root, copy and paste the following line(s) and press ENTER

  curl https://raw.githubusercontent.com/seekthex/Server_Setup_Scripts/master/install-firewall.sh | bash



### Setup Swap File

   (Recommend) if you would need to create a 1 gig permanent swap filesystem

   Usage:

   On a brand new VPS server signed in as root, copy and paste the following line(s) and press ENTER

   curl https://raw.githubusercontent.com/seekthex/Server_Setup_Scripts/master/install-1-swap-p.sh | bash

   Note: if you are running a smaller VPS such as a Vultr 512 MB server you will need to install a 2 Gig Swap
        during the inital compilie of chaincoin. however to run chaincoind you will only need a 1 Gig Swap file
        on the 512 MB server.
        You can find more swap file building scripts here.
        https://github.com/seekthex/server_setup_scripts/blob/master/README.md



### Install Chaincoin -cli wallet with Sentinel

  Usage:

  On a brand new VPS server signed in as root, copy and paste the following line(s) and press ENTER  

  For Ubuntu 14.04, 16.04, 17.10

  curl https://raw.githubusercontent.com/seekthex/CHC_Wallets/master/mainnet/ubuntu/sh/0.16.0.0-cli-wallet.sh | bash


  For Ubuntu 18.04

  curl https://raw.githubusercontent.com/seekthex/CHC_Wallets/master/mainnet/ubuntu/sh/0.16.0.0-cli-wallet-UB18.sh | bash



### Chaincoin-qt-exe


  If you need a Windows 64-bit Chaincoin-qt.exe desktop wallet go here.
  https://github.com/seekthex/CHC_Wallets/blob/master/mainnet/ubuntu/docs/0.16.0.0-qt-win64bit-wallet.md   


  For Tesetnet Builds
  --------------

    If you need a Ubuntu cli wallet for testnet go here.

    https://github.com/seekthex/CHC_Wallets/blob/master/testnet/ubuntu/docs/0.16.0.0-qt-win64bit-wallet.md  

    If you need a Windows 64-bit Chaincoin-qt.exe desktop wallet for testnet go here.

    https://github.com/seekthex/CHC_Wallets/blob/master/testnet/ubuntu/docs/0.16.0.0-cli-wallet.md   



Donations:

Bitcoin:

Chaincoin: CYFSSCHNtLj1pDhPEWK9KP5gnHQqohNEfh

Many thanks to the CHC Community
