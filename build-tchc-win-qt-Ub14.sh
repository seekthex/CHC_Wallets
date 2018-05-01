#!/bin/sh
#Version 0.0.0.1
#Info: Installs Chaincoind daemon
#Chaincoin Testnet Version 0.16.x 
#Testing OS: Ubuntu 14.04 
#TODO: not testested
#TODO: massive cleanup

message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1" BAAAHHH!!!
	echo "╘════════════════════════════════════════════════════════<<<"
}




installgeneraldependencies(){

	message "installing dependencies"
	
	# General
	sudo apt update -y
	sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 git -y

	# Boost C macros - Bitcoin core trying to remove this
	sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev -y

	# Berkeley Db - Some duplication - script is used later
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update -y
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

	# upnc - Optional (see --with-miniupnpc and --enable-upnp-default):
	sudo apt-get install libminiupnpc-dev -y
	
	# zero message queue
	sudo apt-get install libzmq3-dev -y
	
	# QT5 - QT Wallet
	sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y

	# QR
	sudo apt-get install libqrencode-dev -y
}



installmorestuff() {	
	message "installing more stuff"
	# General dependencies
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git -y

	# cross compilation toolchain
	sudo apt install g++-mingw-w64-x86-64 -y
}

makechaincoin() {
	message "preparing the the chaincoin..."
	git clone https://github.com/ChainCoin/ChainCoin.git -b Chaincoin_0.16-dev
	cd ChainCoin
	make clean
	
	./autogen.sh
	
	sudo ./contrib/install_db4.sh berkeley48
	export BDB_PREFIX='/db4'

	./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2 -fPIC" LDFLAGS="-L${BDB_PREFIX}/lib/" --disable-tests
} 

makewindows() {

	# build steps
	PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g') # strip out problematic Windows %PATH% imported var
	cd depends
	make HOST=x86_64-w64-mingw32
	cd ..

	CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/ --disable-tests
	
	sudo make
	
	sudo make install
}


success() {

	message "SUCCESS you ran some code, feel safe, be happy"
}


install() {
  cd ~
	installgeneraldependencies
	makechaincoin
	installmorestuff
	makewindows
	success
}

#main
install
