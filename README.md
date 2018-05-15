
Create CHC Testnet Wallets
=============

Version: 0.0.0.1

This is a collection shell scripts to assist in creating CHC testnet wallet(s)

Highly suggested to start on clean installation of Ubuntu

Experimental scripts, use at your own risk!!!


### Supported OS
-Ubuntu


### Tested Systems:
-Ubuntu 14.04
-Ubuntu 16.04


build-chc-Ub16.sh  
--------------

Description: Creates a .16 CHC "cli" testnet wallet on Ubuntu 14.04,16.04 with sentinel and pre-configured



### Setup firewall

  (optional) If you would  like to setup firewall to allow OpenSSH, port 11994 and 21995

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



### Install Chaincoin -cli testnet wallet with Sentinel

Configuration: Below is the list of how this installation was configured 
  
Options used to compile and link:
  with wallet   = yes
  with gui / qt = no
  with zmq      = yes
  with test     = no
  with bench    = yes
  with upnp     = yes
  use asm       = yes
  debug enabled = no
  werror        = no

  target os     = linux
  build os      =

  CC            = gcc
  CFLAGS        = -g -O2
  CPPFLAGS      = -fPIC -DHAVE_BUILD_INFO -D__STDC_FORMAT_MACROS
  CXX           = g++ -std=c++11
  CXXFLAGS      = -g -O2 -Wall -Wextra -Wformat -Wvla -Wformat-security -Wno-unu sed-parameter
  LDFLAGS       =
  ARFLAGS       = cr
  
  Usage:
  
  On a brand new VPS server signed in as root, copy and paste the following line(s) and press ENTER  

  curl https://raw.githubusercontent.com/seekthex/create_chc_testnet/master/sh/build-tchc-ub16.sh | bash



 ### Update Chaincoin -cli testnet wallet with Sentinel to the latest build

  This is script to update the Chaincoin - cli wallet to the latest build. To use shut down the chaincoind deamon (using the command  chaincoin-cli stop) then run the following shell script.

  curl https://raw.githubusercontent.com/seekthex/create_chc_testnet/master/update-tchc-ub16.sh | bash

### Chaincoin-qt-exe

  If you need a Windows 64-bit Chaincoin-qt.exe desktop wallet go here.
  https://github.com/seekthex/create_chc_testnet/blob/master/doc/build-windows.md   

Donations:

Bitcoin:

Chaincoin:

Many thanks to the CHC Community
