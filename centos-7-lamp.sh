#!/bin/bash
##updating centos with patches
echo "upating packages including kernels...."
yum update -y 

##installing tools
echo "installing system application like nano..."
yum install -y nano vim git unzip screen wget curl

##installing apache
echo "installing apache...."
yum install -y httpd
systemctl enable httpd.service
systemctl stop httpd.service
rm -rf /var/www/html
ln -s /vagrant /var/www/html
systemctl start httpd.service

##php
echo "installing php"
yum install -y php php-cli php-common php-devel php-mysql
yum install -y  php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc 
yum install -y php-mbstring php-snmp php-soap curl curl-devel
yum install phpMyAdmin

##mysql
echo "installing mysql"
yum install -y mariadb-server mariadb
systemctl start mariadb.service
systemctl enable mariadb.service
mysql -u root -e "SHOW DATABASES";

systemctl restart httpd.service

