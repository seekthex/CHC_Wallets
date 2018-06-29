#!/bin/sh
#Version 0.0.0.1
#Info: Create Chaincoin-qt.exe (from master branch)
#Chaincoin Mainnet Version 0.16.0.0
#Testing OS: Ubuntu 14.04
#Note Only works with Ubuntu 14.04
#TODO: testing...
#TODO: ask community for improvement

message() {

	echo "╒════════════════════════════════════════════════════════>>>"
	echo "| $1"
	echo "╘════════════════════════════════════════════════════════<<<"
}


installdepends(){

	message "installing dependencies"

	# General dependencies
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get install git -y
	sudo apt install curl -y
	sudo apt-get install build-essential -y
	sudo apt-get install libtool -y
	sudo apt-get install autotools-dev -y
	sudo apt-get install automake -y
	sudo apt-get install pkg-config -y
	sudo apt-get install libssl-dev -y
	sudo apt-get install libevent-dev -y
	sudo apt-get install bsdmainutils -y
	sudo apt-get install python3 -y

	# Boost C macros - Bitcoin core trying to remove this
	sudo apt-get install libboost-filesystem-dev -y
	sudo apt-get install libboost-system-dev -y
	sudo apt-get install libboost-chrono-dev -y
	sudo apt-get install libboost-program-options-dev -y
	sudo apt-get install libboost-test-dev -y
	sudo apt-get install libboost-thread-dev -y

	# Berkeley Db
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:bitcoin/bitcoin -y
	sudo apt-get update -y
	sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

	# upnc - Optional (see --with-miniupnpc and --enable-upnp-default):
	sudo apt-get install libminiupnpc-dev -y

	# zero message queue
	sudo apt-get install libzmq3-dev -y

	# QT5 - QT Wallet
	sudo apt-get install libqt5gui5
	sudo apt-get install libqt5core5a
	sudo apt-get install libqt5dbus5
	sudo apt-get install qttools5-dev
	sudo apt-get install qttools5-dev-tools
	sudo apt-get install libprotobuf-dev
	sudo apt-get install protobuf-compiler -y

	# QR
	sudo apt-get install libqrencode-dev -y

	# cross compilation toolchain
	sudo apt install g++-mingw-w64-x86-64 -y
}

makechaincoin() {
	message "preparing the chaincoin..."
	git clone https://github.com/ChainCoin/ChainCoin.git -b .16 --single-branch
	cd ChainCoin
	./autogen.sh
        ./configure CPPFLAGS=-fPIC
 	make clean
	make dist-clean
}

makechaincoinqt() {
	# build steps
	PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g') # strip out problematic Windows %PATH% imported var
	cd depends
	make HOST=x86_64-w64-mingw32
	cd ..
	CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/ --disable-tests
	sudo make
	sudo make install
}

install() {
	installdepends
	makechaincoin
	makechaincoinqt
  	message "Your Chaincoin QT wallet is ready"
  	message "Location:  ~/ChainCoin/src/qt/chaincoin-qt.exe"
}

#main
install
