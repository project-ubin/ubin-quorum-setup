#!/bin/bash

. ./install_npm.sh

cd ..
sudo rm -rf quorum-genesis
git clone https://github.com/davebryson/quorum-genesis.git
cd quorum-genesis/
git checkout 14e8f97c2c0ad2294b1d2521e058b7be66e9a72e

chmod -R 755 *
sudo chown -R $USER:$(id -gn $USER) /home/$USER/.config
sudo npm install -g
npm list --depth=200
