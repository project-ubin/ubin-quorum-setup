#!/bin/bash

. ./install_npm.sh
cd ..
sudo rm -rf QuorumNetworkManager
git clone https://github.com/consensys/QuorumNetworkManager.git
cd QuorumNetworkManager/
git checkout zkpPrecompiles

git fetch origin 08bdbd7cc337388621a6d4d68248da0b484630b0 
 #77df0078aa52781a2bc146663a820d6c77301d0d
sudo chown -R $USER:$(id -gn $USER) /home/$USER/.config
npm install 
npm list --depth=200

# killing geth and constellation
pkill -9 geth
pkill -9 constellation-node


