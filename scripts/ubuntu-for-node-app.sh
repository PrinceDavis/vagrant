#!/bin/bash
#update server
apt-get update -y

#install essentail packages
sudo apt-get install build-essential tcl

#install node 8.x
cd ~
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs

echo "Verifying node and npm installation"
sudo node -v
sudo npm -v

#innstall mongodb 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org