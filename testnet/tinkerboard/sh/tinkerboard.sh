#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind on clean tinkeboard OS version whatever
#Chaincoin Version 0.16.x (master)(mainnet)
#Testing OS: tinkerboard
#TODO: everything
#TODO:


message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}

build_chc() {


	message "Creating 1GB temporary swap file...this may take a few minutes..."
	sudo dd if=/dev/zero of=/swapfile bs=1M count=1000
	sudo mkswap /swapfile
	sudo chown root:root /swapfile
	sudo chmod 0600 /swapfile
	sudo swapon /swapfile
	sudo chmod 0600 /swapfile
	sudo chown root:root /swapfile
	message "1GB swap has been created"


 message "Installing pre-dependencies..."
 sudo apt update -y
 sudo apt upgrade -y
 sudo apt-get install build-essential -y
 sudo apt-get install libtool -y
 sudo apt-get install autotools-dev -y
 sudo apt-get install automake -y
 sudo apt-get install autoconf -y
 sudo apt-get install pkg-config -y
 #sudo apt-get remove libssl-dev -y
 sudo apt-get install libssl1.0-dev
 sudo apt install
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

 message "Install Tinkerboard specific"
 sudo apt-get install cron -y
 message "Tinkerboard specifc intalled"

 message "Download and compile Berkley Database..."
 #sudo apt-get install software-properties-common -y
 #sudo add-apt-repository ppa:bitcoin/bitcoin -y
 #sudo apt-get update
 #sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
 cd ~
 mkdir bitcoin
 cd bitcoin
 mkdir db4
 wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
 tar -xzvf db-4.8.30.NC.tar.gz
 cd db-4.8.30.NC/build_unix/
 ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/root/bitcoin/db4/
 make install
 message "Berkley Database compiled"

 message "Download and building Chaincoin"
 cd ~
 git clone https://github.com/ChainCoin/ChainCoin.git -b 0.16 --single-branch
 cd ChainCoin
 ./autogen.sh
 sudo ./contrib/install_db4.sh berkeley48
 export BDB_PREFIX='/db4'
 ./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2 -fPIC" LDFLAGS="-L${BDB_PREFIX}/lib/" --disable-tests
 make install
 cd ~
 mkdir .chaincoincore
 cd .chaincoincore
 touch chaincoin.conf

 touch debug.empty



 echo "daemon=1" >> chaincoin.conf
 echo "listen=1" >> chaincoin.conf
 echo "server=1" >> chaincoin.conf
 echo "rpcuser=chcuser" >> chaincoin.conf
 echo "rpcpassword=chcpassword" >> chaincoin.conf
 echo "rpcport=11995" >> chaincoin.conf
 echo "rpcallowip=127.0.0.1" >> chaincoin.conf
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
 echo "* * * * * cd /root/sentinel && cp debug.empty debug.log" >> mycron



 crontab mycron
 rm mycron
 message "Sentinel has beein installed and configured"
 message "Launching Chaincoin"
 chaincoind
}

install() {
	build_chc
}

install
