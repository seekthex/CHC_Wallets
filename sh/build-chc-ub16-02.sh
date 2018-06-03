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
	echo "listen=0" >> chaincoin.conf
	echo "server=1" >> chaincoin.conf
	echo "debug=1" >> chaincoin.conf
	echo "prematurewitness=1" >> chaincoin.conf
	echo "addnode=78.47.108.196:11996" >> chaincoin.conf

#echo "addresstype=p2sh-segwit" >> chaincoin.conf
#echo "changetype=p2sh-segwit" >> chaincoin.conf
	echo "rpcuser=123" >> chaincoin.conf
	echo "rpcpassword=1234" >> chaincoin.conf
	echo "rpcport=11995" >> chaincoin.conf
	echo "rpcallowip=127.0.0.1" >> chaincoin.conf
	echo "addnode=207.246.88.75" >> chaincoin.conf
	echo "addnode=140.82.42.182" >> chaincoin.conf
	message "chaincoin has been built and configured"

	message "Download and install the Sentinel..."
	sudo apt-get update
	sudo apt-get -y install python-virtualenv
	sudo apt install virtualenv -y
	cd ~
	cd ChainCoin
	git clone https://github.com/chaincoin/sentinel.git && cd sentinel
	virtualenv ./venv
	./venv/bin/pip install -r requirements.txt
	rm -rf venv && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt
	echo "chaincoin_conf=/root/.chaincoincore/chaincoin.conf" >> sentinel.conf
	crontab -l >> mycron
	echo "* * * * * cd /root/ChainCoin/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> mycron
	crontab mycron
	rm mycron
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
