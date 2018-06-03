#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind on clean Unbuntu OS version 16.04
#Chaincoin Testnet Version 0.16.x
#Testing OS: Ubuntu 14.04,16.04
#TODO: everything
#TODO:


message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc_wallet() {

	message "Installing pre-dependencies..."

	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get install git -y
	sudo apt-get install build-essential -y
	sudo apt-get install libtool -y
	sudo apt-get install autotools-dev -y
	sudo apt-get install automake -y
	sudo apt-get install autoconf -y
	sudo apt-get install pkg-config -y
	sudo apt-get install libssl-dev -y
	sudo apt-get install libevent-dev -y
	sudo apt-get install bsdmainutils -y
	sudo apt-get install libboost-system-dev -y
	sudo apt-get install libboost-filesystem-dev -y
	sudo apt-get install libboost-chrono-dev -y
	sudo apt-get install libboost-program-options-dev -y
	sudo apt-get install libboost-test-dev -y
	sudo apt-get install libboost-thread-dev -y
	sudo apt-get install libminiupnpc-dev -y
	sudo apt-get install libzmq3-dev -y
	message "pre-dependencies installed."


	message "Installing Berkley Database..."
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
	message "Berkley Database Installed"



	message "Download and building Chaincoin"
	git clone https://github.com/ChainCoin/ChainCoin.git -b Chaincoin_0.16-dev --single-branch
	cd ChainCoin
	./autogen.sh
	./configure CPPFLAGS="-fPIC" --disable-tests --without-gui
	make clean
	make install
	cd ~
	mkdir .chaincoincore
	cd .chaincoincore
	touch chaincoin.conf
	echo "daemon=1" >> chaincoin.conf
	echo "listen=1" >> chaincoin.conf
	echo "server=1" >> chaincoin.conf


	echo "rpcuser=123" >> chaincoin.conf
	echo "rpcpassword=1234" >> chaincoin.conf
	echo "rpcport=21995" >> chaincoin.conf
	echo "rpcallowip=127.0.0.1" >> chaincoin.conf

	message "chaincoin has been built and configured"


	message "Launching Chaincoin"
	chaincoind
}


install() {
  build_chc_wallet
}


#main
#default to --without-gui
#install --without-gui
install