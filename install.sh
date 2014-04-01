#!/bin/bash

#https://github.com/piwikla/ec2-nginx

#Update
sudo su -
yum update

#Installing Packages
yum install nginx php-fpm php-xml php-pdo php-odbc \
  php-soap php-common php-cli php-mbstring php-bcmath php-ldap \
  php-imap php-gd php-pecl-apc
yum install mysql-server mysql php-mysql 
yum install postgresql-server postgresql php-pgsql
  

#Chkconfig and primary configuration
chkconfig nginx on
chkconfig mysqld on
chkconfig php-fpm on

service mysqld start
mysql_secure_installation

#Install PECL
apt-get install php5-geoip php5-dev libgeoip-dev
pecl install geoip

#LOAD DATA INFILE
apt-get install php5-mysqlnd

#Install phpMyAdmin
apt-get install phpmyadmin
sudo ln -s /usr/share/phpmyadmin/ /home/piwik/public_html/piwik.la

#config nginx
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/piwik.la
ln -s /etc/nginx/sites-available/piwik.la /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

#download piwik
mkdir -p /home/piwik/public_html/piwik.la
cd /home/piwik/public_html/piwik.la
wget http://piwik.org/latest.zip && unzip latest.zip
cd piwik
mv * ../
cd ../
rm -rf piwik

#Basic Security
apt-get install fail2ban iptables-persistent

#Start Nginx
service php-fpm start
service nginx start
