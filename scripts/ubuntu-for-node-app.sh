#!/bin/bash
#update server
apt-get update -y

#install essentail packages
sudo apt-get install build-essential -y
sudo apt-get install tcl -y


#uninstall nginx that came with homestead
sudo apt-get purge nginx nginx-common -y
sudo apt-get autoremove

#install nginx
sudo apt-get install nginx -y

#configuring nginx
echo "Configuring nginx"
sudo cp /home/vagrant/code/application/scripts/default /etc/nginx/sites-available/default

echo "Restarting nginx"
sudo systemctl restart nginx

#install node 8.x
echo "Installing node 8 and npm"
cd ~
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs

echo "Verifying node and npm installation"
sudo node -v
sudo npm -v

#innstall mongodb
echo "Installing mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

#configuring mongodb
echo "Configuring mongodb"
sudo cp /home/vagrant/code/application/scripts/mongodb.service /etc/systemd/system/mongodb.service

#startup mongodb
echo "Startup and verify mongodb service"
sudo systemctl start mongodb
sudo systemctl status mongodb
sudo systemctl enable mongodb

#installing redis
echo "Installing redis"
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
echo "Compiling redis"
make
make test
sudo make install

#Configuring redis
echo "Configuring redis"
sudo mkdir -p /etc/redis
sudo cp /home/vagrant/code/application/scripts/redis.conf /etc/redis/
sudo cp /home/vagrant/code/application/scripts/redis.service /etc/systemd/system/

#adding a redis user account
echo "Creating redis user"
sudo adduser --system --group --no-create-home redis

#create redis persistance directory
sudo mkdir -p /var/lib/redis

#Granting redis user sole permission to redis data store directory
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis

#Test redis setup
echo "Test redis setup"
sudo systemctl start redis
sudo systemctl status redis
echo "Restart redis"
sudo systemctl restart redis

#installing postgres
echo "Installing postgres"
sudo apt-get install postgresql postgresql-contrib -y

#Verify postgres
echo "Verifying postgres installation"
sudo which postgres

#clean up
echo "Cleaning up"
cat /dev/null > ~/.bash_history && history -c && exit