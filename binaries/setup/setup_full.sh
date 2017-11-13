#!/bin/bash

printx () {

    COLOR="96m";

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "\n$STARTCOLOR%s$ENDCOLOR\n" "-------------------------$1-------------------";
}

sudo apt install sysvbanner

printx "-"
banner ubin 
printx "-"
printf "\n"

printx "kill proceses"
 ./cleanup_process.sh

printx "Clean up directories"
 ./cleanup_dir.sh

printx "Clean up path"
. ./cleanup_path.sh

printx "Installation Setup Quorum Core Components"

cd ..
printx "Installing OS pre-requisites"
sudo apt-get update;
sudo apt-get install -y build-essential libssl-dev git curl

# zkp
sudo apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk libboost-all-dev libssl-dev git libgmp3-dev libprocps4-dev libgtest-dev python-markdown

printx "Installing node"
#curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#sudo apt-get install -y nodejs

#sudo chown -R $USER:$(id -gn $USER) /home/$USER/.config
#sudo apt autoremove
 ./install_npm.sh

printx "Installing GO  pre-requisites"
wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
sudo tar -xvf go1.7.linux-amd64.tar.gz
sudo cp -r go/ /usr/local/
sudo rm -rf go/ go1.7.linux-amd64.tar.gz

printx "Config GO"
export GOROOT=/usr/local/go
export GOPATH=$HOME/projects/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update

printx "Installing ethereum"
sudo apt-get install -y ethereum
sudo mv /usr/bin/geth /usr/bin/normalGeth

echo "export PATH=\$PATH:"$PWD/build/bin >> ~/.bashrc
source ~/.bashrc
export PATH=$PWD/build/bin:$PATH

printx "Copying Quorum Geth"
sudo cp ./geth/* /usr/bin/geth
sudo chmod 711 /usr/bin/geth

printx "Installing constellation"
mkdir constellation && cd constellation/
sudo apt-get install -y libdb-dev libsodium-dev zlib1g-dev libtinfo-dev unzip
wget https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip
unzip ubuntu1604.zip
chmod +x ubuntu1604/constellation-node
chmod +x ubuntu1604/constellation-enclave-keygen

echo "export PATH=\$PATH:"$PWD/ubuntu1604 >> ~/.bashrc
echo "export PATH=\$PATH:"$PWD/ubuntu1604/constellation-enclave-keygen  >> ~/.bashrc
echo "export PATH=\$PATH:"$PWD/ubuntu1604/constellation-node  >> ~/.bashrc
source ~/.bashrc

PATH=$PATH:$PWD/ubuntu1604
PATH=$PATH:$PWD/ubuntu1604/constellation-enclave-keygen
PATH=$PATH:$PWD/ubuntu1604/constellation-node


#export PATH=$PWD/ubuntu1604:$PATH

printx "Pulling quorum genesis commits used in UBIN"
pwd
cd ../setup
./install_quorumgenesis.sh

printx "Installing Quorum Network Manager"
cd ../setup
 ./install_quorumnetworkmanager.sh

#cdir=`pwd`;
#sudo su - -c "cd ${cdir}; . ./install_quorumnetworkmanager.sh; chown -R ubuntu:ubuntu *.*"
# some random error occuring when installing quorum netowkr manager

printx "Clean up"
cd ..
sudo rm -rf constellation-0.1.0-ubuntu1604
sudo rm -rf go1.7.linux-amd64.tar.gz
sudo rm -rf ubuntu1604.zip

printx "-"
banner DONE 
printx "-"

printx "Starting Quorum Network Manager"
cd QuorumNetworkManager/
cp ../setup/abc*.* .
sudo npm install -g

export PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
echo "export PATH=\$PATH;" >> ~/.bashrc
touch ~/.bashrc
source ~/.bashrc

