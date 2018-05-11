#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind on clean Unbuntu OS version 16.04
#Chaincoin Testnet Version 0.16.x
#Testing OS: Ubuntu 16.04
#TODO: everything
#TODO:


message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc_wallet() {
	message "Removing the old ChainCoin"
	cd ~
	sudo rm -r ChainCoin
	
	message "Installing Berkley Database..."
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
	message "Berkley Database Installed"
	
	message "Download and building Chaincoin"
	git clone https://github.com/ChainCoin/ChainCoin.git -b Chaincoin_0.16-dev
	cd ChainCoin
	./autogen.sh
	./configure CPPFLAGS="-fPIC" --disable-tests --without-gui
	make clean
	make install
	cd ~
	message "Download and install the Sentinel..."
	cd ~
	cd ChainCoin
	git clone https://github.com/chaincoin/sentinel.git && cd sentinel
	virtualenv ./venv
	./venv/bin/pip install -r requirements.txt
	sed -i 's/network=mainnet/#network=mainnet/g' sentinel.conf
	sed -i 's/#network=testnet/network=testnet/g' sentinel.conf
	echo "chaincoin_conf=/root/.chaincoincore/chaincoin.conf" >> sentinel.conf

	message "Sentinel has beein installed and configured"
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
