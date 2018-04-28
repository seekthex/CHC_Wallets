#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind on clean Unbuntu 14.04
#Chaincoin Testnet Version 0.16.x
#Testing OS: Ubuntu 14.04
#TODO: everything
#TODO:


message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc_wallet() {

	message "Installing pri-dependencies..."
	sudo apt-get git
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
	message "pre-dependencies intalled."


	message "Installing Berkly Database..."
	# Linux (Ubuntu Only) BerkeleyDb Install
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
	message "Berkly Database Installed"



	message "Download and building Chaincoin"
	git clone https://github.com/ChainCoin/ChainCoin.git -b Chaincoin_0.16-dev
	cd ChainCoin
	./autogen.sh
	./configure CPPFLAGS="-fPIC" --disable-tests --without-gui
	make clean
	make install
  cd ~
	mkdir .chaincoincore
	touch chaincoin.conf
  echo "daemon=1" >> chaincoin.conf
	echo "listen=1" >> chaincoin.conf
	echo "server=1" >> chahicoin.conf
	echo "testnet=1" >> chaincoin.conf
	echo "server=1" >> chaincoin.conf
	echo "listen=1" >> chaincoin.conf
	echo "debug=1" >> chaincoin.conf
	echo "prematurewitness=1" >> chaincoin.conf
	echo "rpcuser=123" >> chaincoin.conf
	echo "rpcpassword=123" >> chaincoin.conf
	echo "rpcport=21995" >> chaincoin.conf
	echo "rpcallowip=127.0.0.1" >> chaincoin.conf
  echo "addnode=140.82.42.182" >> chaincoin.conf
	echo "addnode=207.246.88.75" >> chaincoin.conf
	message "chaincoin has been built"

  message "Downlad and installing the Sentinel"
	sudo apt-get update
	sudo apt-get -y install python-virtualenv
  cd ~
	cd ChainCoin
	git clone https://github.com/chaincoin/sentinel.git && cd sentinel
	virtualenv ./venv
	./venv/bin/pip install -r requirements.txt


	message "Configuring Sentinel"
	sed -i 's/network=mainnet/#network=mainnet/g' sentinel.conf
	sed -i 's/#network=testnet/network=testnet/g' sentinel.conf
	echo "chaincoin_conf=/root/.chaincoincore/chaincoin.conf" >> sentinel.conf


  #TODO find out how to do put this line in crontab -e because I dont know if this will work right
  crontab -l > mycron
  echo "* * * * * cd /home/YOURUSERNAME/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> mycron
  crontab mycron
  rm mycron

}


install() {
  build_chc_wallet
}

#main
#default to --without-gui
#install --without-gui
install
