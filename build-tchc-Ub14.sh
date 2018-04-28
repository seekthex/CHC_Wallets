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
  message "ChainCoin has been installed installed"
	#message "Downlad and instll Centinel"
	#sudo apt-get update
	#sudo apt-get -y install python-virtualenv -y
	#sudo apt install virtualenv -y
	#cd ChainCoin
	#git clone https://github.com/chaincoin/sentinel.git && cd sentinel
	#virtualenv ./venv
	#./venv/bin/pip install -r requirements.txt


	#sudo echo "* * * * * cd /root/ChainCoin/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> /tmp/crontab.SWy3wG/crontab
	#* * * * * cd /root/ChainCoin/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1
	###verify the test
	#/root/ChainCoin/sentinel/venv/bin/py.test ./test
	###configure the sentinels
	##chaincoin_conf=/path/to/chaincoin.conf
	###run the debug
	#SENTINEL_DEBUG=1 ./venv/bin/python bin/sentinel.py

}


install() {
  build_chc_wallet
}

#main
#default to --without-gui
#install --without-gui
install
