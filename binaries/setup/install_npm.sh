#!/bin/bash

sudo apt-get update

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install build-essential
sudo apt install npm
sudo npm i -g npm

sudo chown -R $USER:$(id -gn $USER) /home/$USER/.config
npm -g list --depth=200
