#!/bin/sh
#Version 0.0.0.1
#Info: haincoind on clean Unbuntu OS version 16.04
#Chaincoin Version 0.9.3.3
#Testing OS: Ubuntu 14.04,16.04
#TODO: everything
#TODO:


#satus, not working yet I think, but need to try it!




message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc_wallet() {

	message "Installing pre-dependencies..."

	sudo apt-get update
	sudo apt-get install automake -y
	sudo apt-get install libdb++-dev -y
	sudo apt-get install build-essential libtool autotools-dev -y
	sudo apt-get install autoconf pkg-config libssl-dev -y
	sudo apt-get install libboost-all-dev -y
	sudo apt-get install libminiupnpc-dev -y
	sudo apt-get install git -y
	sudo apt-get install software-properties-common -y
	sudo apt-get install python-software-properties -y
	sudo apt-get install g++ -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y 


	message "Download and building Chaincoin"
	git clone https://github.com/chaincoin-legacy/chaincoin.git 
	cd chaincoin
	./autogen.sh
	./configure --without-gui
	make 
	sudo make install
	message "Launching Chaincoin"
	#chaincoind
}


install() {
  build_chc_wallet
}


#main
#default to --without-gui
#install --without-gui
install
