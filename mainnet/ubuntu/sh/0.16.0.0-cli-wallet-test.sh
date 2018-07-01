#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind on clean Unbuntu OS version 16.04
#Chaincoin Version 0.16.x (master)(mainnet)
#Tested OS: Ubuntu 14.04, 16.04, 17.10
#TODO: everything
#TODO:


message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc() {





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
	git clone https://github.com/ChainCoin/ChainCoin.git -b 0.16 --single-branch
	cd ChainCoin
	./autogen.sh
	./configure
	make install
	cd ~
	mkdir .chaincoincore
	cd .chaincoincore
	touch chaincoin.conf
	echo "daemon=1" >> chaincoin.conf
	echo "listen=1" >> chaincoin.conf
	echo "server=1" >> chaincoin.conf
	echo "rpcuser=chcuser" >> chaincoin.conf
	echo "rpcpassword=chcpassword" >> chaincoin.conf
	echo "rpcport=11995" >> chaincoin.conf
	echo "rpcallowip=127.0.0.1" >> chaincoin.conf
	echo "externalip=" && $( ip a s eth0 | awk '/inet.*brd/ {print $2}' | awk -F'/' '{print $1}' ) >> chaincoin.conf
  echo "masternode=1" >> chaincoin.conf
	echo "masternodeprivkey=$privkey" >> chaincoin.conf
	message "chaincoin has been built and configured"

	message "Download and install the Sentinel..."
	sudo apt-get update
	sudo apt-get -y install python-virtualenv
	sudo apt install virtualenv -y
	cd ~
	git clone https://github.com/chaincoin/sentinel.git && cd sentinel
	virtualenv ./venv
	virtualenv ./venv && ./venv/bin/pip install -r requirements.txt
	echo "chaincoin_conf=/root/.chaincoincore/chaincoin.conf" >> sentinel.conf
	crontab -l >> mycron
	echo "* * * * * cd /root/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> mycron
	crontab mycron
	rm mycron
	message "Sentinel has beein installed and configured"
	message "Launching Chaincoin"



	chaincoind
}

install() {
  build_chc
}

message " Thankyou for trying script"

echo "please enter your masternod private key to continue"

read privkey
install
