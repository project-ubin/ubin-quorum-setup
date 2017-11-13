#!/bin/bash
printx () {

    COLOR="96m";

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "\n$STARTCOLOR%s$ENDCOLOR\n" "-------------------------$1-------------------";
}

sudo apt install sysvbanner

banner            ubin 
printf "\n"

printx "Installation Setup Quorum Core Components"

cd ..
printx "Installing OS pre-requisites"
sudo apt-get update;
sudo apt-get install -y build-essential libssl-dev git curl

# zkp
sudo apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk libboost-all-dev libssl-dev git libgmp3-dev libprocps4-dev libgtest-dev python-markdown

printx "Installing node"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

printx "Installing GO  pre-requisites"
wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
sudo tar -xvf go1.7.linux-amd64.tar.gz
sudo cp -r go/ /usr/local/
sudo rm -rf go/ go1.7.linux-amd64.tar.gz

printx "Installing GO config "
export GOROOT=/usr/local/go
export GOPATH=$HOME/projects/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update

printx "Installing ethereum"
sudo apt-get install -y ethereum
sudo mv /usr/bin/geth /usr/bin/normalGeth

printx "Installing quorum"
cd quorum/
make all
echo "PATH=\$PATH:"$PWD/build/bin >> ~/.bashrc
source ~/.bashrc
export PATH=$PWD/build/bin:$PATH

printx "Installing constellation"
cd ..
cd constellation/
sudo apt-get install -y libdb-dev libsodium-dev zlib1g-dev libtinfo-dev unzip

chmod +x ubuntu1604/constellation-node

echo "PATH=\$PATH:"$PWD/ubuntu1604 >> ~/.bashrc
source ~/.bashrc
export PATH=$PWD/ubuntu1604:$PATH

cd ..
cd quorum-genesis/
npm install # -g

printx "Installing Quorum Network Manager"
cd ..
cd QuorumNetworkManager/
cp ../geth/* .
npm install

printx "Clean up"
cd ..
sudo rm -rf go1.7.linux-amd64.tar.gz


banner Configure
printx "Starting Quorum Network Manager"
cd QuorumNetworkManager/

node index.js
