#!/bin/bash

# Update centOS with any patches
yum update -y --exclude=kernel
# Tools
yum install -y nano unzip screen

# Apache
yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# PHP
yum install -y php php-cli php-common php-devel php-mysql

# MySQL
yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on 

service mysqld start

mysql -u root -e "SHOW DATABASES";

# Download Starter Content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/PrinceDavis/vagrant/e0b58f30a94aa4c30cab9787089e3169580c4ff0/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/PrinceDavis/vagrant/e0b58f30a94aa4c30cab9787089e3169580c4ff0/files/info.php

services httpd restart